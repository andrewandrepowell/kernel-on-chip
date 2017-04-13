#ifndef KOC_LOCK_H_
#define KOC_LOCK_H_

#ifdef __cplusplus
extern "C" 
{
#endif

	#define KOC_LOCK_CONTROL_OFFSET             (0)
	#define KOC_LOCK_CONTROL_DEFAULT_VALUE		(1)
	
	typedef struct
	{
		unsigned base_address;
	}
	koc_lock;
	
	static inline __attribute__ ((always_inline))
	void koc_lock_setup(koc_lock* obj,unsigned base_address,unsigned cpuid)
	{
		obj->base_address = base_address;
	}
	
	static inline __attribute__ ((always_inline))
	unsigned koc_lock_take(koc_lock* obj,unsigned cpuid)
	{
		unsigned lockid = cpuid+1;
		
		__asm__ __volatile__ ( "" : : : "memory");
		*((volatile unsigned*)(obj->base_address+KOC_LOCK_CONTROL_OFFSET)) = lockid;
		__asm__ __volatile__ ( "" : : : "memory");
		return (*((volatile unsigned*)(obj->base_address+KOC_LOCK_CONTROL_OFFSET)))==lockid;
	}
	
	static inline __attribute__ ((always_inline))
	void koc_lock_give(koc_lock* obj)
	{
		__asm__ __volatile__ ( "" : : : "memory");
		*((volatile unsigned*)(obj->base_address+KOC_LOCK_CONTROL_OFFSET)) = 0;
	}
	

#ifdef __cplusplus
}
#endif

#endif /* KOC_LOCK_H_ */