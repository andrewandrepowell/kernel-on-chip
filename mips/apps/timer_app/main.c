#include "port_layer.h"
#define LED_TOTAL		(16)
#define TICK_PERIOD		(20)	// 2 ms
#define CNTR_THRES		(50)	// 500 ms

volatile unsigned counters[LED_TOTAL];

void runmain()
{
	unsigned curr_tick;
	unsigned next_tick;
	unsigned out;
	unsigned in;
	unsigned each;
	unsigned mask;
	unsigned cpuid_val;
	
	curr_tick = gettick();
	next_tick = curr_tick+TICK_PERIOD;
	
	while (1)
	{	
		waituntil(next_tick);
		curr_tick = next_tick;
		next_tick += TICK_PERIOD;
		cpuid_val = cpuid();
		
		for (each=0;each<LED_TOTAL;each++)
		{
			if ((each%KOC_CPU_TOTAL)==cpuid_val)
			{
				
				in = getin();
				mask = (1<<each);
				
				if (in&mask)
				{ 
					if (counters[each]==CNTR_THRES)
					{
						counters[each] = 0;
						
						blocklock();
						out = getout();
						if (out&mask)
						{
							out &= ~mask;
						}
						else
						{
							out |= mask;
						}
						setout(out);
						givelock();
					}
					else
					{ 
						counters[each]++;
					}
					
				}
			}
		}
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
