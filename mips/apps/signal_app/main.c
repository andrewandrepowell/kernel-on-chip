#include "koc_cpu.h"
#include "koc_lock.h"
#include "plasoc_int.h"
#include "plasoc_gpio.h"
#include "plasoc_uart.h"

#define HW_LOCK_BASE_ADDRESS		(0x20000000)
#define HW_INT_BASE_ADDRESS		(0x20010000)
#define HW_TIMER_BASE_ADDRESS		(0x20020000)
#define HW_GPIO_BASE_ADDRESS		(0x20030000)
#define HW_UART_BASE_ADDRESS		(0x20040000)

#define INT_TIMER_ID			(0)
#define INT_GPIO_ID			(1)
#define INT_UART_ID			(2)
#define INT_MASK			(1<<INT_GPIO_ID)

#define CPUINT_SIGNAL_ID	(KOC_CPU_SIGNAL_INT_ID)
#define CPUINT_INT_ID		(1)
#define CPUINT_MASK			((1<<CPUINT_SIGNAL_ID)|(1<<CPUINT_INT_ID))

plasoc_int int_obj;
plasoc_gpio gpio_obj;
koc_lock lock_obj;
volatile unsigned data;

void koc_cpu_signal_isr(void* param)
{
	/* Acknowledge any signals and acquire CPUID. */
	koc_signal_ack(cpusignal());

	/* Have CPU1 get word from GPIO core's input and flush to memory. */
	if (cpuid()==1)
	{
		data = plasoc_gpio_get_data_in(&gpio_obj);
		l1_cache_flush_range((unsigned)&data,sizeof(data));
	}
}

void cpumain()
{	
	/* Objects needs to be invalidated to ensure they're 
	located in each CPU's cache. This operation needs to occur in 
	a critical section, along with all other cache operations. */
	l1_cache_invalidate_range((unsigned)&lock_obj,sizeof(lock_obj));
	l1_cache_invalidate_range((unsigned)&gpio_obj,sizeof(gpio_obj));
	l1_cache_invalidate_range((unsigned)&int_obj,sizeof(int_obj));

	/* Configure CPU interrupt. */
	OS_AsmInterruptInitInvalidate();
	OS_AsmInterruptEnable(1);

	/* Perform operations based on CPU. */
	{
		/* Have CPU1 get word from GPIO core's input and flush to memory. */
		if (cpuid()==1)
		{
			data = plasoc_gpio_get_data_in(&gpio_obj);
			l1_cache_flush_range((unsigned)&data,sizeof(data));
		}
		/* Have CPU2 read word from memory and write it to the GPIO core's output. */
		if (cpuid()==2)
		{
			while (1)
			{
				l1_cache_invalidate_range((unsigned)&data,sizeof(data));
				plasoc_gpio_set_data_out(&gpio_obj,data);
			}
		}
	}
}

void int_isr(void* param)
{
	(void) param;
	plasoc_int_service_interrupts(&int_obj);
}

void gpio_isr(void* param)
{
	(void) param;
	
	/* Since the master CPU's interrupt controller 
	is directly connected to the main interrupt controller,
	the master CPU needs to signal the other CPUs. */
	plasoc_gpio_enable_int(&gpio_obj,1);
	koc_signal_start(cpusignal());
}

int main()
{

	/* At this point, only the master CPU is running. The master CPU's only
	responsibility at this point is to initialize all the drivers and start the
	operation of the other CPUS. The objects need to be flushed so that the other
	CPUs can access the objects and utilize the hardware. */
	{
		koc_lock_setup(&lock_obj,HW_LOCK_BASE_ADDRESS);
		plasoc_gpio_setup(&gpio_obj,HW_GPIO_BASE_ADDRESS);
		plasoc_int_setup(&int_obj,HW_INT_BASE_ADDRESS);
		plasoc_int_attach_isr(&int_obj,INT_GPIO_ID,gpio_isr,0);
		plasoc_int_attach_isr(cpuint(),CPUINT_INT_ID,int_isr,0);
	}
	
	/* Enable interrupts and trigger the other CPUs. The OS_AsmInterruptInitFlush
	should be commented out if the application is starting at address zero. In general,
	The application should typically start much higher than the boot address zero which
	is typically reserved for the boot application. */
	{
		plasoc_gpio_set_data_out(&gpio_obj,1);
		plasoc_gpio_enable_int(&gpio_obj,0);
		plasoc_int_set_enables(&int_obj,INT_MASK);
		plasoc_int_set_enables(cpuint(),CPUINT_MASK);

		l1_cache_flush_range((unsigned)&lock_obj,sizeof(lock_obj));
		l1_cache_flush_range((unsigned)&gpio_obj,sizeof(gpio_obj));
		l1_cache_flush_range((unsigned)&int_obj,sizeof(int_obj));

		OS_AsmInterruptInitFlush();
		OS_AsmInterruptEnable(1);

		cpurun(1,cpumain);
		cpurun(2,cpumain);
	}
	
	/* The master CPU is allowed to end since its purpose in this application is complete. */
	return 0;
}
