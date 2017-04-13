#include "koc_defs.h"

	.extern		koc_cpu_cntrl_tbl_obj
	.extern		koc_cpuid_obj
	.extern		koc_lock_obj
	
	.data
	
	.text
	.section	.text.startup
	.align 		2
	
	.global		entry
	.ent		entry
entry:
	.set		noreorder
	
	# Setting the global pointer is necessary for every CPU.
	la		$gp, _gp
	
	# Configure Lock base address.
	la		$8, koc_lock_obj
	li		$9, KOC_LOCK_BASE_ADDRESS
	sw		$9, 0($8)
	
	# Configure CPUID base address.
	la		$8, koc_cpuid_obj
	li		$9, KOC_CPUID_BASE_ADDRESS
	sw		$9, 0($8)
	
	# Check for master CPU.
	lw		$8, 0($9)
	bqe		$8, $0, entry_MASTER__
	nop
	
entry_SLAVE__:

	# Wait until master CPU is ready.
	la		$8, koc_lock_obj
	lw		$8, 0($8)
entry_SLAVE__WAIT_FOR_MASTER:
	lw		$9, 0($8)
	bne		$9, $0, entry_SLAVE__WAIT_FOR_MASTER
	
	# Determine CPU Control Block for Slave CPU.
	la		$8, koc_cpuid_obj
	lw		$8, 0($8)
	lw		$8, 0($8)										# $8 holds CPUID.
	la		$9, koc_cpu_cntrl_tbl_obj						# $8 holds address of CPU Control Block.
entry_SLAVE__FIND_CPU_CNTRL_BLK:	
	addiu	$8, $8, -1
	addiu	$9, $9, KOC_CPU_CNTRL_BLK_SIZE
	bne		$8, $0, entry_SLAVE__FIND_CPU_CNTRL_BLK
	
entry_MASTER__: 

	# Clear the BSS section.
	la		$8, __bss_start
	la		$9, _end
entry_BSS_CLEAR:
	sw		$0, 0($8)
	slt		$10, $8, $9
	bne		$10, $0, entry_BSS_CLEAR
	addiu	$8, $8, 4
	
	# Configure CPU Control Block for Master CPU.
	la		$8, koc_cpu_cntrl_tbl_obj
	la		$9, main
	sw		$9, 0($8)
	sw		$0, 4($8)
	addiu	$sp, $8, KOC_CPU_START_STACK_POINTER_OFFSET
	
	# Release hardware lock to let slaves know it's safe to start. The
	# LOCKID should be CPUID+1.
	la		$8, koc_lock_obj
	lw		$8, 0($8)
	li		$9, KOC_CPU_MASTER_CPUID+1
	sw		$9, 0($8)
	
	# Start main application.
	jal		main
	nop
	
entry_SPIN:
   j 		entry_SPIN

   .end entry