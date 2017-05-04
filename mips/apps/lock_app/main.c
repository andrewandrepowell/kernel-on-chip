#include "port_layer.h"

volatile unsigned counter = 3;

void runmain()
{
	cpuinitialize();
	
	setout(2);
	
	while (1)
	{
		unsigned byte;
		//blocklock();
		byte = getbyte();
		setout(byte);
		setbyte(byte);
		//printf("test\n\r");
		//givelock();
	}
}

int main()
{
	initialize();
	
	setout(1);
	
	//cpurun(1,runmain);
	//cpurun(2,runmain);
	runmain();
	
	
	
	return 0;
}
