/**
 * @author Andrew Powell
 * @date May 10, 2017
 * @brief Contains hardware definitions and drivers for the Hard Real-Time Kernel-on-Chip.
 */
 
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

	/**
	 * @brief The signature of each CPU function. 
	 */
	typedef void (cpucode)(void);

	/**
	 * @brief Gets the CPUID of the current CPU.
	 * @return Returns the CPUID of the currenet CPU.
	 */
	static inline __attribute__ ((always_inline))
	unsigned cpuid() 
	{
		plasoc_gpio gpio_obj;
		plasoc_gpio_setup(&gpio_obj,KOC_CPUID_BASE_ADDRESS);
		return plasoc_gpio_get_data_in(&gpio_obj); 
	}

	/**
	 * @brief Gets the object representing the interrupt controller of the current CPU.
	 * @return Returns the pointer to the object.
	 */
	static inline __attribute__ ((always_inline))
	plasoc_int* cpuint()
	{
		extern plasoc_int koc_cpu_int_objs[KOC_CPU_TOTAL];
		return &koc_cpu_int_objs[cpuid()];
	}

	/**
	 * @brief Gets the object representing the signal event core of the current CPU.
	 * @return Returns the pointer to the object.
	 */
	static inline __attribute__ ((always_inline))
	koc_signal* cpusignal()
	{
		extern koc_signal koc_cpu_signal_objs[KOC_CPU_TOTAL];
		return &koc_cpu_signal_objs[cpuid()];
	}

	/**
	 * @brief Starts a specified CPU with code.
	 * @param cpuid_val The CPUID that specifies the CPU to start.
	 * @param code The pointer to the code to run over the specified CPU.
	 */
	static inline __attribute__ ((always_inline))
	void cpurun(unsigned cpuid_val, cpucode* code)
	{
		extern cpucode* koc_cpu_codes[KOC_CPU_TOTAL];
		koc_cpu_codes[cpuid_val] = code;
		l1_cache_flush_all();
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
