#include "port_layer.h"
#define LED_TOTAL		(16)
#define TICK_PERIOD		(1)	// 1 ms
#define CNTR_THRES		(500)	// 500 ms
#define ALIVE_THRES		(4)

#if LED_TOTAL<KOC_CPU_TOTAL
#error "LED_TOTAL should be greater than or equal to KOC_CPU_TOTAL."
#endif

volatile unsigned counters[LED_TOTAL];
volatile unsigned lo_bds[KOC_CPU_TOTAL];
volatile unsigned hi_bds[KOC_CPU_TOTAL];
volatile unsigned alive_cntr;

void setbounds()
{
	const unsigned incr = LED_TOTAL/KOC_CPU_TOTAL;
	unsigned each = 0;
	
	lo_bds[0] = 0;
	hi_bds[0] = incr;
	
	for (each=1;each<(KOC_CPU_TOTAL-1);each++)
	{
		lo_bds[each] = hi_bds[each-1];
		hi_bds[each] = lo_bds[each]+incr;
	}
	
	if (KOC_CPU_TOTAL>1)
		lo_bds[KOC_CPU_TOTAL-1] = hi_bds[KOC_CPU_TOTAL-2];
	hi_bds[KOC_CPU_TOTAL-1] = LED_TOTAL;
}

void runmain()
{
	const unsigned cpuid_val = cpuid();
	const unsigned start = lo_bds[cpuid_val];
	const unsigned end = hi_bds[cpuid_val];
	unsigned curr_tick;
	unsigned next_tick;
	unsigned out;
	unsigned in;
	unsigned each;
	unsigned mask;
	
	
	curr_tick = gettick();
	next_tick = curr_tick+TICK_PERIOD;
	
	while (1)
	{	
		waituntil(next_tick);
		curr_tick = next_tick;
		next_tick += TICK_PERIOD;
		
		blocklock();
		in = getin();
		out = getout();
		for (each=start;each<end;each++)
		{
			mask = (1<<each);
			if (in&mask)
			{ 
				if (counters[each]==(CNTR_THRES-1))
				{
					counters[each] = 0;
					if (out&mask)
					{
						out &= ~mask;
					}
					else
					{
						out |= mask;
					}
				}
				else
				{ 
					counters[each]++;
				}
				
			}
		}
		setout(out);
		givelock();
	}
}

int main()
{
	initialize();
	
	setout(1);
	
	setbounds();
	
	cpurun(1,runmain);
	cpurun(2,runmain);
	runmain();
	
	return 0;
}
