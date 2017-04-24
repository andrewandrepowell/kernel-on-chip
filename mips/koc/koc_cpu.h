
#ifndef KOC_CPU_H_
#define KOC_CPU_H_

#include "koc_defs.h"
#include "plasoc_cpu.h"
#include "plasoc_int.h"
#include "plasoc_gpio.h"
#include "koc_signal.h"

#ifdef __cplusplus
extern "C" 
{
#endif

	typedef void (cpucode)(void);

	static inline __attribute__ ((always_inline))
	unsigned cpuid() 
	{
		plasoc_gpio gpio_obj;
		plasoc_gpio_setup(&gpio_obj,KOC_CPUID_BASE_ADDRESS);
		return plasoc_gpio_get_data_in(&gpio_obj); 
	}

	static inline __attribute__ ((always_inline))
	plasoc_int* cpuint()
	{
		extern plasoc_int koc_cpu_int_objs[KOC_CPU_TOTAL];
		return &koc_cpu_int_objs[cpuid()];
	}

	static inline __attribute__ ((always_inline))
	koc_signal* cpusignal()
	{
		extern koc_signal koc_cpu_signal_objs[KOC_CPU_TOTAL];
		return &koc_cpu_signal_objs[cpuid()];
	}

	static inline __attribute__ ((always_inline))
	void cpurun(unsigned cpuid_val, cpucode* code)
	{
		extern cpucode* koc_cpu_codes[KOC_CPU_TOTAL];
		koc_cpu_codes[cpuid_val] = code;
		l1_cache_flush_range((unsigned)&koc_cpu_codes[cpuid_val],sizeof(koc_cpu_codes[0]));
	}

	static inline __attribute__ ((always_inline))
	void OS_AsmInterruptInitFlush()
	{
		extern void interrupt_service_routine();
		
		if ((unsigned)interrupt_service_routine!=KOC_CPU_OSINT_BASE_ADDRESS)
		{
			OS_AsmInterruptInit();
			l1_cache_flush_range((unsigned)KOC_CPU_OSINT_BASE_ADDRESS,KOC_CPU_OSINT_PATCHSIZE);
		}
	}

	static inline __attribute__ ((always_inline))
	void OS_AsmInterruptInitInvalidate()
	{
		extern void interrupt_service_routine();
		
		if ((unsigned)interrupt_service_routine!=KOC_CPU_OSINT_BASE_ADDRESS)
			l1_cache_invalidate_range((unsigned)KOC_CPU_OSINT_BASE_ADDRESS,KOC_CPU_OSINT_PATCHSIZE);
	}

#ifdef __cplusplus
}
#endif

#endif /* PLASOC_CPU_H_ */
