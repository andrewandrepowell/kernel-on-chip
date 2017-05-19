#include "port_layer.h"

volatile unsigned counter = 3;

void runmain()
{
	slaveinit();
	
	while (1)
	{
		blocklock();
		setout(counter);
		printf("CPU%u: %u\n\r",cpuid(),counter);
		counter++;
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
