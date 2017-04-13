#include "koc_cpu.h"

__attribute__ ((aligned (4))) koc_cpu_cntrl_tbl koc_cpu_cntrl_tbl_obj;

plasoc_gpio koc_cpuid_obj;
koc_lock koc_lock_obj;

static inline __attribute__ ((always_inline))
unsigned koc_cpuid_get()
{
	return plasoc_gpio_get_data_out(&cpuid_gpio_obj);
}

//void koc_boot_setup()
//{
	/* The following operations in many cases would be risky considering
	every CPU would perform these operations. However, this is acceptable
	since the following operations consist of simply writing the same 
	information to memory. */
//	plasoc_gpio_setup(&cpuid_gpio_obj,KOC_CPUID_GPIO_BASE_ADDRESS);
//	koc_lock_setup(&lock_obj,KOC_LOCK_BASE_ADDRESS);
	
//	{
		
//	}
	
//}