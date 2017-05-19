#include "port_layer.h"

volatile unsigned data;

void handlesignal()
{
	/* Have CPU1 get word from GPIO core's input and flush to memory. */
	if (cpuid()==1)
	{
		data = getin();
		l1_cache_flush_range((unsigned)&data,sizeof(data));
	}
}

void handlegpio()
{
	/* Since the master CPU's interrupt controller 
	is directly connected to the main interrupt controller,
	the master CPU needs to signal the other CPUs. */
	koc_signal_start(cpusignal());
}


void cpumain()
{	
	slaveinit();

	/* Have CPU1 get word from GPIO core's input and flush to memory. */
	if (cpuid()==1)
	{
		data = getin();
		l1_cache_flush_range((unsigned)&data,sizeof(data));
	}
	/* Have CPU2 read word from memory and write it to the GPIO core's output. */
	if (cpuid()==2)
	{
		while (1)
		{
			l1_cache_memory_barrier();
			setout(data);
		}
	}
}

int main()
{
	initialize();
	
	setout(1);
	
	setsignalhandler(handlesignal);
	setgpiohandler(handlegpio);

	cpurun(1,cpumain);
	cpurun(2,cpumain);
	
	/* The master CPU is allowed to end since its purpose in this application is complete. */
	return 0;
}
