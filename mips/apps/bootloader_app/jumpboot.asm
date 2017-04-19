# @author Andrew Powell
# @date April 19, 2017 
# @brief Implements the Jump application. 
#
# Really simple application. Its only purpose is to force the
# KoC's CPU to jump to the location of the main application
# which is assumed to be in memory already.
	
	JUMP_ADDRESS	= 0x10000000	

	.data

	.text
	.section	.text.startup

	.align 		2

	.global 	entry
	.ent		entry
entry:
   	.set 		noreorder
	
	lui		$8, %hi(JUMP_ADDRESS)
	ori		$8, %lo(JUMP_ADDRESS)
	jr		$8
	nop

	.set 		reorder
	.end		entry


