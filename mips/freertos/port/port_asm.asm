
	.extern		prvFreeRTOSPerformServices
	.extern		pxCurrentTCB
	.extern		prvPortCPUStackAddr

	.data

	.align 2
	.globl	FreeRTOS_SysCall
	.comm	FreeRTOS_SysCall,4,0

	.text
	
	.macro	portSAVE_CONTEXT
	.set noreorder
   	.set noat

	# FreeRTOS: Load source of interrupt and reset it.
	lui	$26,	%hi(FreeRTOS_SysCall)
	ori	$26,	%lo(FreeRTOS_SysCall)
	lw	$27,	0($26)
	sw	$0,	0($26)

	# Store the state of the CPU.
	addi	$29,	$29,	-136			#adjust sp	
	sw	$1,	16($29)				#at	
	sw	$2,	20($29)				#v0
	sw	$3,	24($29)				#v1	
	sw	$4,	28($29)				#a0
	sw	$5,	32($29)				#a1	
	sw	$6,	36($29)				#a2
	sw	$7,	40($29)				#a3	
	sw	$8,	44($29)				#t0
	sw	$9,	48($29)				#t1	
	sw	$10,	52($29)				#t2
	sw	$11,	56($29)				#t3	
	sw	$12,	60($29)				#t4
	sw	$13,	64($29)				#t5	
	sw	$14,	68($29)				#t6
	sw	$15,	72($29)				#t7
	sw	$16,	76($29)				#s0
	sw	$17,	80($29)				#s1
	sw	$18,	84($29)				#s2
	sw	$19,	88($29)				#s3
	sw	$20,	92($29)				#s4
	sw	$21,	96($29)				#s5
	sw	$22,	100($29)			#s6
	sw	$23,	104($29)			#s7	
	sw	$24,	108($29)			#t8
	sw	$25,	112($29)			#t9	
	sw	$31,	116($29)			#lr
	mfc0	$26,	$14				#C0_EPC=14 (Exception PC)
	bne	$27,	$0,	portSAVE_CONTEXT_0	#Check if a system call occurred
	addi	$26,	$26, 	-4			#Backup one opcode on external interrupt
	j	portSAVE_CONTEXT_1
	nop		
portSAVE_CONTEXT_0:
	addi	$26,	$26,	4			#Skip to next opcode on system call
portSAVE_CONTEXT_1:	
	sw	$26,	120($29)			#pc	
	mfhi	$27
	sw	$27,	124($29)			#hi	
	mflo	$27
	sw	$27,	128($29)			#lo

	# The following statements were used for debugging purposes.
	#lui	$27,	0x44A2
	#ori	$27,	0x0008
	#sw	$26,	0($27)

	# FreeRTOS: Store the state of the current task.
	lui	$26,	%hi(pxCurrentTCB)	# Load the address to the current TCB pointer.
	ori	$26,	%lo(pxCurrentTCB) 
	lw	$26,	0($26)			# Load the current TCB pointer.
	sw	$29,	0($26)			# Store the current task's stack pointer in its TCB.

	# FreeRTOS: Load the stack pointer for the CPU.
	lui	$26,	%hi(InitStack)		# Load the address of the CPU stack pointer.
	ori	$26,	%lo(InitStack) 
	lw	$29,	0($26)			# Load the CPU stack pointer.

	.set reorder
	.set at
	.endm

##
# @brief Restores the context of the current task onto the current CPU.
#
	.macro		portRESTORE_CONTEXT
	.set		noreorder
   	.set		noat
	
	# FreeRTOS: Save the stack pointer for the CPU.
	lui		$26, %hi(prvPortCPUStackAddr)	# Load the address of function that will return address of the variable
	ori		$26, %lo(prvPortCPUStackAddr) 	# which temporarily holds the stack pointer of the current CPU.
	jalr		$26
	add		$27, $2, $0			# Store the contents of the first return register.
	sw		$29, 0($2)			# Store the current CPU's stack pointer.
	add		$2, $27, $0			# Restore the original value of the first return register.

	# FreeRTOS: Load the stack pointer for the current task.
	lui		$26, %hi(pxCurrentTCB)	# Load the address to the current TCB pointer.
	ori		$26, %lo(pxCurrentTCB)
	lw		$26, 0($26)		# Load the current TCB pointer.
	lw		$29, 0($26)		# Load the current task's stack pointer from its TCB.
	
	# Resore the state of the CPU with context of task.
	lw		$1, 16($29)	#at	
	lw		$2, 20($29)	#v0	
	lw		$3, 24($29)	#v1
	lw		$4, 28($29)	#a0	
	lw		$5, 32($29)	#a1
	lw		$6, 36($29)	#a2	
	lw		$7, 40($29)	#a3
	lw		$8, 44($29)	#t0	
	lw		$9, 48($29)	#t1
	lw		$10, 52($29)	#t2	
	lw		$11, 56($29)	#t3
	lw		$12, 60($29)	#t4	
	lw		$13, 64($29)	#t5
	lw		$14, 68($29)	#t6	
	lw		$15, 72($29)	#t7
	lw		$16, 76($29)	#s0
	lw		$17, 80($29)	#s1
	lw		$18, 84($29)	#s2
	lw		$19, 88($29)	#s3
	lw		$20, 92($29)	#s4
	lw		$21, 96($29)	#s5
	lw		$22, 100($29)	#s6
	lw		$23, 104($29)	#s7	
	lw		$24, 108($29)	#t8	
	lw		$25, 112($29)	#t9
	lw		$31, 116($29)	#lr	
	lw		$26, 120($29)	#pc
	lw		$27, 124($29)	#hi	
	mthi		$27
	lw		$27, 128($29)	#lo	
	mtlo		$27
	addi		$29, $29, 136	#adjust sp
	
	# FreeRTOS: Enable the CPU interrupt.
   	ori		$27, $0, 0x1	#re-enable interrupts
   	jr		$26
   	mtc0		$27, $12	#STATUS=1; enable interrupts

	.set reorder
	.set at
	.endm

##
# @brief Restores the context of the current task onto the current CPU.
#
	.global		pxPortInitialiseStack
	.ent		pxPortInitialiseStack
pxPortInitialiseStack:
	.set		noreorder

	addi		$2, $4, -136  	# Determine next stack pointer.
	sw		$5, 120($2)	# Store the program counter of the task.
	jr		$31
	sw		$6, 28($2)	# Store the parameter pointer.

	.set reorder
	.end pxPortInitialiseStack

##
# @brief Defines the FreeRTOS operations of the CPU's interrupt service routine.
#
	.global		prvISR
   	.ent		prvISR	
prvISR:   	
	.set		noreorder
   	.set		noat
	
	# Perform interrupt-related operations.
	portSAVE_CONTEXT				# Save the context of the current task.
	jal		prvFreeRTOSPerformServices	# Jump to user-defined ISR.
	nop
	portRESTORE_CONTEXT				# Restore context. The PC should be on register 26.
	nop

	.set		reorder
	.set		at
	.end		prvISR

##
# @brief Write instructions at 0x3c to force the CPU to jump
# to the correct address of interrupt_service_routine.
##
	.global		prvAsmInterruptInit
	.ent		prvAsmInterruptInit
prvAsmInterruptInit:
	.set 		noreorder
	la		$8, prvAsmPatchValue
	lw		$9, 0($8)
	sw		$9, 0x3c($0)
	lw		$9, 4($8)
	sw		$9, 0x40($0)
	lw		$9, 8($8)
	sw		$9, 0x44($0)
	lw		$9, 12($8)
	jr		$31
	sw		$9, 0x48($0)

prvAsmPatchValue:
	lui		$26, %hi(prvISR)
	ori		$26, %lo(prvISR)
	jr		$26 
	nop

	.set		reorder
	.end		prvAsmInterruptInit

##
# @brief Starts the first task of the OS.
##
	.global		vPortStartFirstTask
	.ent		vPortStartFirstTask
vPortStartFirstTask:
	.set		noreorder

	# Set the context to the current task.
	portRESTORE_CONTEXT	# Restore context. The PC should be on register 26.

	.set		reorder
	.end		vPortStartFirstTask

	.global	vPortYield
	.ent	vPortYield
vPortYield:
	.set 	noreorder
	
	# Disable CPU interrupt.
	mtc0	$0,	$12	
	addi	$9,	$0,	1

	# Load source of interrupt and set it.
	lui	$8,	%hi(FreeRTOS_SysCall)
	ori	$8,	%lo(FreeRTOS_SysCall)	
	sw	$9,	0($8)

	# Load yield flag and set it.
	lui	$8,	%hi(FreeRTOS_Yield)
	ori	$8,	%lo(FreeRTOS_Yield)	
	sw	$9,	0($8)

	# Perform the system call
	syscall
	
	# Return to the calling function
	jr	$31
	nop
	
	.set 	reorder
	.end 	vPortYield


   
