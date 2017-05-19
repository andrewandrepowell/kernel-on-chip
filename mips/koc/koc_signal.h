/**
 * @author Andrew Powell
 * @date May 18, 2017
 * @brief Contains hardware definitions and driver for the KoC's Signal Core.
 */

#ifndef KOC_SIGNAL_H_
#define KOC_SIGNAL_H_

#ifdef __cplusplus
extern "C" 
{
#endif
	
	/* Signal Core definitions. See plasoc_pac.vhd for more information on these hardware definitions. */
	#define KOC_SIGNAL_CONTROL_OFFSET		(0)
	#define KOC_SIGNAL_CONTROL_SIGNAL_BIT_LOC	(0)
	#define KOC_SIGNAL_CONTROL_STATUS_BIT_LOC	(1)
	#define KOC_SIGNAL_MEMORY_BARRIER				({__asm__ __volatile__ ( "" : : : "memory");})

	/* Represents the Signal Core. */
	typedef struct
	{
		unsigned base_address; /**< Base address to Signal Core's registers. */
	}
	koc_signal;

	/**
	 * @brief Configures the Signal Core object. 
	 * @param obj Pointer to the object.
	 * @param base_address Base address of the Signal Core's registers.
	 */
	static inline __attribute__ ((always_inline))
	void koc_signal_setup(koc_signal* obj,unsigned base_address)
	{
		obj->base_address = base_address;
	}

	/**
	 * @brief Trigger signal event.
	 * @param obj Pointer to the object.
	 */
	static inline __attribute__ ((always_inline))
	void koc_signal_start(koc_signal* obj)
	{
		KOC_SIGNAL_MEMORY_BARRIER;
		*((volatile unsigned*)(obj->base_address+KOC_SIGNAL_CONTROL_OFFSET)) = (1<<KOC_SIGNAL_CONTROL_SIGNAL_BIT_LOC);
	}

	/**
	 * @brief Acknowledge signal event.
	 * @param obj Pointer to the object.
	 */
	static inline __attribute__ ((always_inline))
	void koc_signal_ack(koc_signal* obj)
	{
		KOC_SIGNAL_MEMORY_BARRIER;
		*((volatile unsigned*)(obj->base_address+KOC_SIGNAL_CONTROL_OFFSET)) = (1<<KOC_SIGNAL_CONTROL_STATUS_BIT_LOC);
	}

	/**
	 * @brief Check the status of the Signal Core.
	 * @param obj Pointer to the object.
	 * @return Returns Nonzero value if Signal Core is active, otherwise 0.
	 */
	static inline __attribute__ ((always_inline))
	unsigned koc_signal_status(koc_signal* obj)
	{
		KOC_SIGNAL_MEMORY_BARRIER;
		return (*((volatile unsigned*)(obj->base_address+KOC_SIGNAL_CONTROL_OFFSET)))&(1<<KOC_SIGNAL_CONTROL_STATUS_BIT_LOC);
	}

#ifdef __cplusplus
}
#endif

#endif /* KOC_SIGNAL_H_ */
