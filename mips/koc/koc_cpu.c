#include "koc_cpu.h"

__attribute__ ((aligned (4))) koc_cpu_cntrl_tbl koc_cpu_cntrl_tbl_obj;
plasoc_int koc_cpu_int_obj = {-1};
plasoc_signal koc_cpu_signal_obj = {-1};

__attribute__((weak))
void OS_InterruptServiceRoutine()
{
	plasoc_int_service_interrupts(&koc_cpu_int_obj);
}

void koc_cpu_signal_isr(void* param)
{
	
}

void koc_boot_setup()
{
	/* Configure stack of CPU. */
	__asm__ __volatile__ (
		"move $sp, %0\n"
		:
		:"r"(koc_cpu_cntrl_tbl_obj.koc_cpu_cntrl_blk[cpuid()].stack+KOC_CPU_STACK_SIZE)
		:"memory");

	/* Configure signal object. */
	koc_signal_setup(&koc_cpu_signal_obj,KOC_CPU_SIGNAL_BASE_ADDRESS);

	/* Configure interrupt controller of CPU. */
	plasoc_int_setup(&koc_cpu_int_obj,KOC_CPU_INT_BASE_ADDRESS);
	plasoc_int_attach_isr(&koc_cpu_int_obj,KOC_CPU_SIGNAL_INT_ID,koc_cpu_signal_isr,0);
	
	/* Patch the interrupt service routine and enable interrupt. */
	OS_AsmInterruptInit();
	OS_AsmInterruptEnable(1);
}
