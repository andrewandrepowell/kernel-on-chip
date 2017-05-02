#include "port_layer.h"

volatile unsigned counter = 5;

void runmain()
{
	cpuinitialize();
	
	while (1)
	{
		//blocklock();
		printf("test\n\r");
		counter++;
		//givelock();
	}
}

int main()
{
	initialize();
	
	setout(0x0001);
	while (1)
	{
	getbyte();
	setout(counter++);
	printf("test\n\r");
	}
	
	//cpurun(1,runmain);
	//cpurun(2,runmain);
	runmain();
	
	setout(0x0003);
	
	return 0;
}
