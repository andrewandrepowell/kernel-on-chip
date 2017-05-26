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

#include "string.h"

/* This structure is associated with each task
by storing it at the bottom of each task's stack. */
typedef struct
{
	portUBASE_TYPE affinity;	/* Describes which CPU the task is assigned to. */
	portUBASE_TYPE running;		/* Describes whether or not the task is running on its assigned CPU. */
}
tskSMPCB;

volatile portUBASE_TYPE uxCPUStackAddrs[KOC_CPU_TOTAL];
volatile TaskHandle_t xCPUCurrentTCBs[KOC_CPU_TOTAL];
volatile portUBASE_TYPE uxCPUYields[KOC_CPU_TOTAL];
volatile portUBASE_TYPE uxCPUSysCalls[KOC_CPU_TOTAL];
volatile tskSMPCB xCurrentSMPCB;
portUBASE_TYPE uxCriticalNestCntr = 0;
portUBASE_TYPE uxIntMask = 0;

__attribute__ ((optimize("O3")))
volatile portUBASE_TYPE* prvPortCPUStackAddr()
{
	return &uxCPUStackAddrs[cpuid()];
}

__attribute__ ((optimize("O3")))
volatile TaskHandle_t* prvPortCPUCurrentTCB()
{
	return &xCPUCurrentTCBs[cpuid()];
}

__attribute__ ((optimize("O3")))
volatile portUBASE_TYPE* prvPortCPUYield()
{
	return &uxCPUYields[cpuid()];
}

__attribute__ ((optimize("O3")))
volatile portUBASE_TYPE* prvPortCPUSysCall()
{
	return &uxCPUSysCalls[cpuid()];
}

__attribute__ ((optimize("O3")))
volatile tskSMPCB* prvTskSMPCB(TaskHandle_t xTask)
{
	unsigned char* pucTopOfStack;
	volatile tskSMPCB* pxTaskSMPCB

	pucTopOfStack = *(unsigned char**)xTask
	pxTaskSMPCB = (volatile tskSMPCB*)(pucTopOfStack+portCPU_REG_CONTEXT_SIZE);

	return pxTaskSMPCB;
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
	extern void vPortUserInitializeHardware(void);

	/* Patch the vector so that the FreeRTOS ISR is called. */
	prvAsmInterruptInit();

	/* Make sure hardware drivers are configured by the user. */
	vPortUserInitializeHardware();
	
	/* Start the first task for each cpu. */
	{
		unsigned each;
		for (each=1;each<KOC_CPU_TOTAL;each++)
			cpurun(each,vPortStartFirstTask);
		vPortStartFirstTask();
	}	

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
	extern unsigned uxPortUserAcquireCPULock(void);
	register unsigned int_mask;

	/* Keep trying to enter os critical section while
	in a cpu critical section. On failed attempts, breifly 
	leave cpu critical section so that interrupt can be 
	serviced. */
	int_mask = enter_critical();
	while (uxPortUserAcquireCPULock()!=0)
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
	extern void vPortUserReleaseCPULock(void);

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

/* User needs to call this function in their ISR for the tick. The user needs
to make sure they signal all other slave CPUs after this function is called in 
the ISR. */
void vPortServiceTick()
{
	unsigned each;
	BaseType_t xSwitchRequired = pdFALSE;

	vPortEnterCritical();
	{
		xSwitchRequired = xTaskIncrementTick();
	}
	vPortExitCritical();

	for (each=0;each<KOC_CPU_TOTAL;each++)
		uxCPUYields[each] = 1;
	l1_cache_flush_range(uxCPUYields,sizeof(uxCPUYields));
}

void prvPortFreeRTOSPerformServices() 
{
	extern void vPortUserServiceInterrupts(void);
 
	/* Interrupts should be serviced before the kernel performs its services. */
	vPortUserServiceInterrupts();

	/* If necessary perform a context switch. */
	{
		volatile portUBASE_TYPE* puxCPUYield;
		extern TaskHandle_t pxCurrentTCB;
		tskSMPCB* pxCurrentSMPCB;
		unsigned cpuid_val;
		
		/* Get the flag for the current CPU that signals
		the task shield yield. A memory barrier is needed since the
		master CPU will need to signal each CPU */
		puxCPUYield = prvPortCPUYield();
		l1_cache_memory_barrier();

		/* Check and see if the context of the current CPU needs to be
		switched. */
		if (*puxCPUYield)
		{
			/* Flag needs to be reset to indicate the yield has occurred. */
			*puxCPUYield = 0;

			/* The following operations must be performed in an os critical section to ensure
			the OS only operates on a single CPU, specifically the vTaskSwitchContext. */
			vPortEnterCritical();
			{
				cpuid_val = cpuid();
				pxCurrentSMPCB = prvTskSMPCB(pxCurrentTCB);

				/* Indicate the current task is not running on its assigned CPU. */
				pxCurrentSMPCB->running = 0;

				/* Continue to perform context switches until a task that is not running already
				and whose affinity is the current CPU is found. */
				while (1)
				{
					vTaskSwitchContext();
					pxCurrentSMPCB = prvTskSMPCB(pxCurrentTCB);
					if ((pxCurrentSMPCB->running==0)&&(pxCurrentSMPCB->affinity==cpuid_val))
					{
						pxCurrentSMPCB->running = 1;
						*prvPortCPUCurrentTCB() = pxCurrentTCB;
						break;
					}
				}
			}
			vPortExitCritical(); 
		}
		
	}
}

StackType_t* prvPortInitializeTskSMPCB(StackType_t* pxTopOfStack)
{
	unsigned char* pucNewTopOfStack = ((unsigned char*)pxTopOfStack)-sizeof(tskSMPCB);
	tskSMPCB* pxNewSMPCB = (tskSMPCB*)pucNewTopOfStack;
	
	/* In order to ensure associate tasks to a CPU, a SMPCB 
	is regarded as a part of the task's context. */
	memset(pxNewSMPCB,0,sizeof(tskSMPCB));

	return (StackType_t*)pucNewTopOfStack;
}

BaseType_t xTaskCreateSMP(TaskFunction_t pvTaskCode,const char * const pcName,unsigned short usStackDepth,
	void *pvParameters,UBaseType_t uxPriority,TaskHandle_t *pxCreatedTask,portUBASE_TYPE affinity)
{
	extern void vPortEnterCritical();
	extern void vPortExitCritical(); 
	BaseType_t xReturned;
	
	/* Since the SMPCB is associated with the task, this operation must be
	atomic. */
	vPortEnterCritical();
	{
		/* The task is created as normal. */
		xReturned = xTaskCreate(pvTaskCode,pcName,usStackDepth,pvParameters,uxPriority,pxCreatedTask);

		/* The SMPCB is configured if the task itself is successfully configured. */
		if (xReturned==pdPASS)
		{
			volatile tskSMPCB* pxTaskSMPCB;

			pxTaskSMPCB = prvTskSMPCB(*pxCreatedTask);
			pxTaskSMPCB->affinity = affinity;
		}
		
	}
	vPortExitCritical();

	return xReturned;
}

void vPortYield()
{
	register unsigned int_mask;

	int_mask = enter_critical();
	*prvPortCPUSysCall() = 1;
	*prvPortCPUYield() = 1;
	__asm__ __volatile__ ("syscall");
	leave_critical(int_mask);
}


