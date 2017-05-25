/*
    FreeRTOS V9.0.0 - Copyright (C) 2016 Real Time Engineers Ltd.
    All rights reserved

    VISIT http://www.FreeRTOS.org TO ENSURE YOU ARE USING THE LATEST VERSION.

    This file is part of the FreeRTOS distribution.

    FreeRTOS is free software; you can redistribute it and/or modify it under
    the terms of the GNU General Public License (version 2) as published by the
    Free Software Foundation >>>> AND MODIFIED BY <<<< the FreeRTOS exception.

    ***************************************************************************
    >>!   NOTE: The modification to the GPL is included to allow you to     !<<
    >>!   distribute a combined work that includes FreeRTOS without being   !<<
    >>!   obliged to provide the source code for proprietary components     !<<
    >>!   outside of the FreeRTOS kernel.                                   !<<
    ***************************************************************************

    FreeRTOS is distributed in the hope that it will be useful, but WITHOUT ANY
    WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
    FOR A PARTICULAR PURPOSE.  Full license text is available on the following
    link: http://www.freertos.org/a00114.html

    ***************************************************************************
     *                                                                       *
     *    FreeRTOS provides completely free yet professionally developed,    *
     *    robust, strictly quality controlled, supported, and cross          *
     *    platform software that is more than just the market leader, it     *
     *    is the industry's de facto standard.                               *
     *                                                                       *
     *    Help yourself get started quickly while simultaneously helping     *
     *    to support the FreeRTOS project by purchasing a FreeRTOS           *
     *    tutorial book, reference manual, or both:                          *
     *    http://www.FreeRTOS.org/Documentation                              *
     *                                                                       *
    ***************************************************************************

    http://www.FreeRTOS.org/FAQHelp.html - Having a problem?  Start by reading
    the FAQ page "My application does not run, what could be wrong?".  Have you
    defined configASSERT()?

    http://www.FreeRTOS.org/support - In return for receiving this top quality
    embedded software for free we request you assist our global community by
    participating in the support forum.

    http://www.FreeRTOS.org/training - Investing in training allows your team to
    be as productive as possible as early as possible.  Now you can receive
    FreeRTOS training directly from Richard Barry, CEO of Real Time Engineers
    Ltd, and the world's leading authority on the world's leading RTOS.

    http://www.FreeRTOS.org/plus - A selection of FreeRTOS ecosystem products,
    including FreeRTOS+Trace - an indispensable productivity tool, a DOS
    compatible FAT file system, and our tiny thread aware UDP/IP stack.

    http://www.FreeRTOS.org/labs - Where new FreeRTOS products go to incubate.
    Come and try FreeRTOS+TCP, our new open source TCP/IP stack for FreeRTOS.

    http://www.OpenRTOS.com - Real Time Engineers ltd. license FreeRTOS to High
    Integrity Systems ltd. to sell under the OpenRTOS brand.  Low cost OpenRTOS
    licenses offer ticketed support, indemnification and commercial middleware.

    http://www.SafeRTOS.com - High Integrity Systems also provide a safety
    engineered and independently SIL3 certified version for use in safety and
    mission critical applications that require provable dependability.

    1 tab == 4 spaces!
*/

#include "FreeRTOS.h"
#include "task.h"

#include "koc_cpu.h"

typedef struct
{
	portUBASE_TYPE affinity;
}
tskSMPCB;

extern unsigned vPortUserAcquireCPULock(void);
extern void vPortUserReleaseCPULock(void);
extern void vPortUserServiceInterrupts(void);

static void prvTickISR();

volatile portUBASE_TYPE uxCPUStackAddrs[KOC_CPU_TOTAL];
volatile portUBASE_TYPE uxCPUCurrentTCBs[KOC_CPU_TOTAL];
volatile portUBASE_TYPE uxCPUYields[KOC_CPU_TOTAL];
portUBASE_TYPE uxCriticalNestCntr = 0;
portUBASE_TYPE uxIntMask = 0;

__attribute__ ((optimize("O3")))
volatile portUBASE_TYPE* prvPortCPUStackAddr()
{
	return &uxCPUStackAddrs[cpuid()];
}

__attribute__ ((optimize("O3")))
volatile portUBASE_TYPE* prvPortCPUYield()
{
	return &uxCPUYields[cpuid()];
}

static void prvTaskExitError( void )
{
	portDISABLE_INTERRUPTS();
	for( ;; );
}

extern void OS_InterruptServiceRoutine()
{
	/* Needs to be defined. */
}

BaseType_t xPortStartScheduler( void )
{
	extern void prvAsmInterruptInit();
	extern void vPortStartFirstTask();

	/* Patch the vector so that the FreeRTOS ISR is called. */
	FreeRTOS_AsmInterruptInit();
	
	/* Start the first task. */
	vPortStartFirstTask();

	/* This function should never be called. */
	prvTaskExitError();
	return 0;
}

void vPortEndScheduler(void)
{
	/* Not implemented in ports where there is nothing to return to.
	Artificially force an assert. */
	configASSERT(0);
}

void vPortEnterCritical()
{
	register unsigned int_mask;

	/* Keep trying to enter os critical section while
	in a cpu critical section. On failed attempts, breifly 
	leave cpu critical section so that interrupt can be 
	serviced. */
	int_mask = enter_critical();
	while (vPortUserAcquireCPULock()!=0)
	{
		leave_critical(int_mask);
		int_mask = enter_critical();
	}

	/* If this is the first time entering the os critical
	section for the current CPU, store interrupt mask and
	ensure synchronized memory. */
	if (uxCriticalNestCntr==0)
	{
		uxIntMask = int_mask;	
		l1_cache_memory_barrier();
		/* SMP management needs to go here. */					
	}
	
	/* Each time the current CPU re-enters its os
	critical section, this counter is increased to keep
	track. */
	uxCriticalNestCntr++;

	/* The CPU shall remain in cpu critical section until 
	the full exit of the os critical section. */		
}

void vPortExitCritical()
{
	/* Each time the current CPU leaves its os critical 
	section, this counter is decremented to keep track. */
	if (uxCriticalNestCntr!=0)
		uxCriticalNestCntr--;

	/* If the number of times the current CPU has entered 
	its os critical section is equal to the number of times
	it has left, it is time to synchronize memory and release
	the lock. Finally, the current CPU must also leave its cpu
	critical section. */
	if (uxCriticalNestCntr==0)
	{
		/* SMP management needs to go here. */
		l1_cache_memory_barrier();
		vPortUserReleaseCPULock();
		leave_critical(uxIntMask);
	}
}

/* User needs to call this function in their ISR for the tick. */
void vServiceTick()
{
	BaseType_t xSwitchRequired = pdFALSE;

	/* As a general principle, the OS is only allowed 
	to run on a single CPU at a time. */
	vPortEnterCritical();
	{
		xSwitchRequired = vTaskSwitchContext();
	}
	vPortExitCritical();

	portYIELD_FROM_ISR(xSwitchRequired);
}

void prvFreeRTOSPerformServices() 
{ 
	/* Interrupts should be serviced before the kernel performs its services. */
	vPortUserServiceInterrupts();

	/* The FreeRTOS_Yield flag is defined in portmacro. This flag is needed
	 to force context switches from system and interrupt calls. */
	{
		volatile portUBASE_TYPE* uxCPUYieldPtr;

		uxCPUYieldPtr = prvPortCPUYield();
		if (*uxCPUYieldPtr)
		{
			*uxCPUYieldPtr = 0;

			/* As a general principle, the OS is only allowed 
			to run on a single CPU at a time. */
			vPortEnterCritical();
			{
				vTaskSwitchContext();
			}
			vPortExitCritical();
		}
	}
}




