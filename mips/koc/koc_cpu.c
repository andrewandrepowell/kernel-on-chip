#include "koc_cpu.h"

/* The stacks will be initialized to zero by the master CPU. */
unsigned char koc_cpu_stacks[KOC_CPU_TOTAL][KOC_CPU_STACK_SIZE];

/* The following arrays are initialized to -1 to ensure they're not placed in BSS. */
plasoc_int koc_cpu_int_objs[KOC_CPU_TOTAL] = {[0 ... KOC_CPU_TOTAL-1] = {-1}};
koc_signal koc_cpu_signal_objs[KOC_CPU_TOTAL] = {[0 ... KOC_CPU_TOTAL-1] = {-1}};
cpucode* koc_cpu_codes[KOC_CPU_TOTAL] = {[0 ... KOC_CPU_TOTAL-1] = (cpucode*)-1};

__attribute__((weak))
void OS_InterruptServiceRoutine()
{
	plasoc_int_service_interrupts(cpuint());
}

__attribute__((weak))
void koc_cpu_signal_isr(void* param)
{
	koc_signal_ack(cpusignal());
}

static void start()
{
	unsigned cpuid_val;
	cpuid_val = cpuid();
	
	/* Configure low-level drivers. */
	{
		plasoc_int* cpu_int_ptr;
		koc_signal* cpu_signal_ptr;

		/* Grab the pointers respective to the slave CPU. */
		cpu_int_ptr = cpuint(); 
		cpu_signal_ptr = cpusignal();

		/* Configure signal object. */
		koc_signal_setup(cpu_signal_ptr,KOC_CPU_SIGNAL_BASE_ADDRESS);

		/* Configure interrupt controller of CPU. */
		plasoc_int_setup(cpu_int_ptr,KOC_CPU_INT_BASE_ADDRESS);
		plasoc_int_attach_isr(cpu_int_ptr,KOC_CPU_SIGNAL_INT_ID,koc_cpu_signal_isr,0);
		plasoc_int_set_enables(cpu_int_ptr,(1<<KOC_CPU_SIGNAL_INT_ID));
	}
	
	/* Clear BSS and run main if master. */
	if (cpuid_val==KOC_CPU_MASTER_CPUID)
	{
		/* Clear BSS. */
		{
			extern unsigned __bss_start;
			extern unsigned _end;
			unsigned* cur;
			unsigned* end;

			cur = &__bss_start;
			end = &_end;	
			while (cur!=end)
				*(cur++) = 0;
		}
		
		/* Run main. */
		{
			extern int main();
			(void)main();
		}
	}
	/* If slave, continuously keep checking for a new code value. */
	else
	{
		l1_cache_flush_all();
		while (1)
		{
			l1_cache_invalidate_range((unsigned)&koc_cpu_codes[cpuid_val],sizeof(koc_cpu_codes[0]));
			if (koc_cpu_codes[cpuid_val]!=(cpucode*)-1)
			{				
				l1_cache_memory_barrier();
				koc_cpu_codes[cpuid_val]();
				break;
			}
		}
	}

	/* Block until interrupt is called. */
	while (1);
}

void koc_boot_start()
{
	/* Configure stack of CPU. */
	__asm__ __volatile__ (
		"move $sp, %0\n"
		:
		:"r"(&(koc_cpu_stacks[cpuid()][(KOC_CPU_STACK_SIZE-KOC_CPU_STACK_STUB_SIZE)]))
		:"memory");

	/* At this point, each CPU should be using its corresponding stack. */
	start();
}


