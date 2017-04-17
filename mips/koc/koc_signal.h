#ifndef KOC_SIGNAL_H_
#define KOC_SIGNAL_H_

#ifdef __cplusplus
extern "C" 
{
#endif
	
	#define KOC_SIGNAL_CONTROL_OFFSET		(0)
	#define KOC_SIGNAL_CONTROL_SIGNAL_BIT_LOC	(0)
	#define KOC_SIGNAL_CONTROL_STATUS_BIT_LOC	(1)


	typedef struct
	{
		unsigned base_address;
	}
	koc_signal;

	static inline __attribute__ ((always_inline))
	void koc_signal_setup(koc_signal* obj,unsigned base_address)
	{
		obj->base_address = base_address;
	}

	void koc_signal_start(koc_signal* obj)
	{
		__asm__ __volatile__ ( "" : : : "memory");
		*((volatile unsigned*)(obj->base_address+KOC_LOCK_CONTROL_OFFSET)) = (1<<KOC_SIGNAL_CONTROL_SIGNAL_BIT_LOC);
	}

	void koc_signal_ack(koc_signal* obj)
	{
		*((volatile unsigned*)(obj->base_address+KOC_LOCK_CONTROL_OFFSET)) = (1<<KOC_SIGNAL_CONTROL_STATUS_BIT_LOC);
	}

	unsigned koc_signal_status(koc_signal* obj)
	{
		return (*((volatile unsigned*)(obj->base_address+KOC_SIGNAL_CONTROL_STATUS_BIT_LOC)));
	}

#ifdef __cplusplus
}
#endif

#endif /* KOC_SIGNAL_H_ */
