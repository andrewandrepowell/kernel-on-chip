
#ifndef KOC_CPU_H_
#define KOC_CPU_H_

#include "plasoc_cpu.h"
#include "plasoc_gpio.h"
#include "koc_defs.h"
#include "koc_lock.h"

#ifdef __cplusplus
extern "C" 
{
#endif
	
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

#ifdef __cplusplus
}
#endif

#endif /* PLASOC_CPU_H_ */