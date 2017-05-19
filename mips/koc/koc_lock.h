/**
 * @author Andrew Powell
 * @date May 18, 2017
 * @brief Contains hardware definitions and driver for the KoC's Lock Core.
 */

#ifndef KOC_LOCK_H_
#define KOC_LOCK_H_

#include "koc_cpu.h"

#ifdef __cplusplus
extern "C" 
{
#endif

	/* Lock Core definitions. See plasoc_pac.vhd for more information on these hardware definitions. */
	#define KOC_LOCK_CONTROL_OFFSET             (0)
	#define KOC_LOCK_CONTROL_DEFAULT_VALUE		(0
	#define KOC_LOCK_MEMORY_BARRIER				({__asm__ __volatile__ ( "" : : : "memory");})
	
	/* Represents the Lock Core. */
	typedef struct
	{
		unsigned base_address; /**< Base address to Lock Core's registers. */
	}
	koc_lock;
	
	/**
	 * @brief Configures the Lock Core object. 
	 * @param obj Pointer to the object.
	 * @param base_address Base address of the Lock Core's registers.
	 */
	static inline __attribute__ ((always_inline))
	void koc_lock_setup(koc_lock* obj,unsigned base_address)
	{
		obj->base_address = base_address;
	}
	
	/**
	 * @brief Determines if current CPU has taken the lock. 
	 * @param obj Pointer to the object.
	 * @return Returns 1 if lock has been taken by the current CPU, otherwise 0.
	 */
	static inline __attribute__ ((always_inline))
	unsigned koc_lock_check(koc_lock* obj)
	{
		unsigned lockid = cpuid()+1;
		KOC_LOCK_MEMORY_BARRIER;
		return (*((volatile unsigned*)(obj->base_address+KOC_LOCK_CONTROL_OFFSET)))==lockid;
	}
	
	/**
	 * @brief Causes the current CPU to attempt to take lock. 
	 * @param obj Pointer to the object.
	 * @return Returns 1 if lock has been taken by the current CPU, otherwise 0.
	 */
	static inline __attribute__ ((always_inline))
	unsigned koc_lock_take(koc_lock* obj)
	{
		unsigned lockid = cpuid()+1;
		KOC_LOCK_MEMORY_BARRIER;
		*((volatile unsigned*)(obj->base_address+KOC_LOCK_CONTROL_OFFSET)) = lockid;
		return koc_lock_check(obj);
	}
	
	/**
	 * @brief Causes the current CPU to give back lock.
	 * @param obj Pointer to the object.
	 */
	static inline __attribute__ ((always_inline))
	void koc_lock_give(koc_lock* obj)
	{
		unsigned lockid = cpuid()+1;
		KOC_LOCK_MEMORY_BARRIER;
		*((volatile unsigned*)(obj->base_address+KOC_LOCK_CONTROL_OFFSET)) = lockid;
	}
	

#ifdef __cplusplus
}
#endif

#endif /* KOC_LOCK_H_ */