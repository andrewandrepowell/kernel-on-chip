#include "port_layer.h"

volatile unsigned counter = 3;

void runmain()
{
	cpuinitialize();
	
	while (1)
	{
		blocklock();
		//l1_cache_invalidate_range((unsigned)&counter,sizeof(counter));
		setout(counter);
		printf("CPU%u: %u\n\r",cpuid(),counter);
		//setbyte('a');
		counter++;
		//l1_cache_flush_range((unsigned)&counter,sizeof(counter));
		givelock();
	}
}

int main()
{
	initialize();
	setout(1);
	
	cpurun(1,runmain);
	cpurun(2,runmain);
	runmain();
	
	return 0;
}
