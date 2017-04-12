CPUID_GPIO_ADDR		=	0x	
	
	.data
	
	.global		InitStack
	.comm		InitStack,		512
	
	.text
	.section	.text.startup
	
	.global		entry
	.ent		entry
entry:
	.set		noreorder