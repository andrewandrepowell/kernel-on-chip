
#ifndef KOC_CPU_H_
#define KOC_CPU_H_

#include "plasoc_cpu.h"
#include "koc_signal.h"

#ifdef __cplusplus
extern "C" 
{
#endif

	#define KOC_CPU_TOTAL					(3)
	#define KOC_CPU_STACK_SIZE				(512)
	#define KOC_CPUID_BASE_ADDRESS				(0xffffff08)
	#define KOC_CPU_MASTER_CPUID				(0)
	#define KOC_CPU_INT_BASE_ADDRESS			(0xf0010000)
	#define KOC_CPU_SIGNAL_BASE_ADDRESS			(0xf0020000)
	#define KOC_CPU_SIGNAL_INT_ID				(0)
	
	typedef struct
	{
		unsigned code_address;
		unsigned param_address;
		unsigned char stack[KOC_CPU_STACK_SIZE];
	}
	koc_cpu_cntrl_blk;
	
	typedef struct
	{
		koc_cpu_cntrl_blk cntrl_blks[KOC_CPU_TOTAL];
	}
	koc_cpu_cntrl_tbl;

	static inline __attribute__ ((always_inline))
	unsigned cpuid() 
	{ 
		return (*(volatile unsigned*)KOC_CPUID_BASE_ADDRESS); 
	}

#ifdef __cplusplus
}
#endif

#endif /* PLASOC_CPU_H_ */
