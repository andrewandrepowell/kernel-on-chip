#ifndef KOC_DEFS_H_
#define KOC_DEFS_H_

#define KOC_CPU_TOTAL					(3)
#define KOC_CPU_STACK_SIZE				(512)
#define KOC_CPU_STACK_STUB_SIZE				(24)
#define KOC_CPU_MASTER_CPUID				(0)
#define KOC_CPUID_BASE_ADDRESS				(0xf0000000)
#define KOC_CPU_INT_BASE_ADDRESS			(0xf0010000)
#define KOC_CPU_SIGNAL_BASE_ADDRESS			(0xf0020000)
#define KOC_CPU_SIGNAL_INT_ID				(0)
#define KOC_CPU_OSINT_BASE_ADDRESS			(0x3c)
#define KOC_CPU_OSINT_PATCHSIZE				(4*sizeof(unsigned))

#endif /* KOC_DEFS_H_ */