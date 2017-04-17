#include "koc_cpu.h"

/* The stacks will be initialized to zero by the master CPU. */
unsigned char koc_cpu_stacks[KOC_CPU_TOTAL][KOC_CPU_STACK_SIZE];

/* The following arrays are initialized to -1 to ensure they're not placed in BSS. */
plasoc_int koc_cpu_int_objs[KOC_CPU_TOTAL] = {[0 ... KOC_CPU_TOTAL-1] = (plasoc_int)-1};
plasoc_signal koc_cpu_signal_objs[KOC_CPU_TOTAL] = {[0 ... KOC_CPU_TOTAL-1] = (plasoc_signal)-1};

void OS_InterruptServiceRoutine()
{
	plasoc_int_service_interrupts(&koc_cpu_int_obj);
}

__attribute__((weak))
void koc_cpu_signal_isr(void* param)
{
	koc_signal_ack(&koc_cpu_signal_objs[cpuid()]);
}

void koc_boot_start()
{
	/* Configure stack of CPU. */
	__asm__ __volatile__ (
		"move $sp, %0\n"
		:
		:"r"(&(koc_cpu_stacks[cpuid()][(KOC_CPU_STACK_SIZE-KOC_CPU_STACK_STUB_SIZE)]))
		:"memory");

	/* Perform operations if slave. */
	if (cpuid()!=KOC_CPU_MASTER_CPUID)
	{
		unsigned cpuid_val;
		plasoc_int* cpu_int_ptr;
		plasoc_signal* cpu_signal_ptr;

		/* Grab the pointers respective to the slave CPU. */
		cpuid_val = cpuid();
		cpu_int_ptr = &koc_cpu_int_objs[cpuid_val];
		cpu_signal_ptr = &koc_cpu_signal_objs[cpuid_val];

		/* Configure signal object. */
		koc_signal_setup(cpu_signal_ptr,KOC_CPU_SIGNAL_BASE_ADDRESS);

		/* Configure interrupt controller of CPU. */
		plasoc_int_setup(cpu_int_ptr,KOC_CPU_INT_BASE_ADDRESS);
		plasoc_int_attach_isr(cpu_int_ptr,KOC_CPU_SIGNAL_INT_ID,koc_cpu_signal_isr,0);
		plasoc_int_set_enables(cpu_int_ptr,(1<<KOC_CPU_SIGNAL_INT_ID));

		/* Patch the interrupt service routine and enable interrupt. */
		OS_AsmInterruptInit();
		OS_AsmInterruptEnable(1);

		/* Block until interrupt is called. */
		while (1);
	}

	/* Jump straight back to the entry function and skip
	stack epilogue. */
	__asm__ __volatile__ ("jr $31\nnop\n":::"memory");
}


