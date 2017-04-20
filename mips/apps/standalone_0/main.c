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
volatile unsigned initialized[KOC_CPU_TOTAL];
volatile unsigned data;

__attribute__((weak))
void koc_cpu_signal_isr(void* param)
{	
	unsigned cpuid_val;

	/* Acknowledge any signals and acquire CPUID. */
	koc_signal_ack(cpusignal());
	cpuid_val = cpuid();
	
	/* Perform initialization operations.*/
	if (initialized[cpuid_val]==0)
	{
		initialized[cpuid_val] = 1;
		
		/* Objects needs to be invalidated to ensure they're 
		located in each CPU's cache. */
		l1_cache_invalidate_range((unsigned)&lock_obj,sizeof(lock_obj));
		l1_cache_invalidate_range((unsigned)&gpio_obj,sizeof(gpio_obj));
		l1_cache_invalidate_range((unsigned)&int_obj,sizeof(int_obj));
		
		/* Perform operations unique to each CPU. */
		switch (cpuid_val)
		{
		case 1:
			/* slave CPU1 initializes data by reading from
			the input and writing it to data. */
			{
				data = plasoc_gpio_get_data_in(&gpio_obj);
				l1_cache_flush_range((unsigned)&data,sizeof(data));
			}
			break;
		case 2:
			/* The only job of slave CPU2 is to continuously read 
			data and write it to the output. It's interrupt is enabled so
			that future signals are acknlowedged. */
			{
				OS_AsmInterruptEnable(1);
				while (1)
				{
					l1_cache_invalidate_range((unsigned)&data,sizeof(data));
					plasoc_gpio_set_data_out(&gpio_obj,data);
				}
			}
			break;
		}
	}
	else
	{
		switch (cpuid_val)
		{
		case 1:
			{
				data = plasoc_gpio_get_data_in(&gpio_obj);
				l1_cache_flush_range((unsigned)&data,sizeof(data));
			}
			break;
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
		
		l1_cache_flush_range((unsigned)&lock_obj,sizeof(lock_obj));
		l1_cache_flush_range((unsigned)&gpio_obj,sizeof(gpio_obj));
		l1_cache_flush_range((unsigned)&int_obj,sizeof(int_obj));
	}
	
	/* Enable interrupts and trigger the other CPUs. */
	{
		plasoc_gpio_set_data_out(&gpio_obj,1);
		plasoc_gpio_enable_int(&gpio_obj,0);
		plasoc_int_set_enables(&int_obj,INT_MASK);
		plasoc_int_set_enables(cpuint(),CPUINT_MASK);
		koc_signal_start(cpusignal());
	}
	
	/* The master CPU is allowed to end since it's purpose in this application is complete. */
	return 0;
}
