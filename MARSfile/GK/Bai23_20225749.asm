.data
	input_msg1: .asciiz "Input n: "
	input_msg2: .asciiz "Input k: "
	
	output_res: .asciiz "C(k,n) = "
	
	error_msg1: .asciiz "wrong input"
	
	result: .word 0
	
.text
#----------------------INPUT------------------------
	li $v0, 4
	la $a0, input_msg1
	syscall
	
	li $v0, 5
	syscall
	
	addi $s0, $v0, 0  #s0 = n
	
	li $v0, 4
	la $a0, input_msg2
	syscall
	
	li $v0, 5
	syscall
	
	addi $s1, $v0, 0  #s1 = k
	addi $s3, $s3, 0  #s3 = C(k,n)
#----------------CHECKING----------------------------------
	blt $s0, $0, error_input1	# n < 0 -> error
	nop
	blt $s1, $0, error_input1	# k < 0 -> error
	nop
	beq $s0, $0, special_case	# n = 0 ->special case
	nop
	
	bne $s1, 1, skip1		# If k = 1 AND n > 0 -> C(k,n) = n
	nop
	addi $s3, $s0, 0
	j EXIT_result
	skip1:
	
special_case:
	bne $s0, $s1, skip2		# If k = n AND n >= 0 -> C(k,n) = 1
	nop
	addi $s3, $0, 1
	j EXIT_result
	skip2:  
	
	bne $s1, 0, skip3		# k = 0 AND n > 0 -> C(k,n) = 1
	nop
	addi $s3, $0, 1
	j EXIT_result
	skip3:
	
	slt $t0, $s0, $s1		#Check n < k -> ERROR
	beq $t0, 1, error_input1
	nop
	
#-------------Recursive Calculation of C(k,n)-----------------

#print result
	jal findCKN
	move $s3, $v0
	sw $s3, result
	
	#display result
	li $v0, 4
	la $a0, output_res
	syscall
	
	li $v0, 1
	lw $a0, result
	syscall
	
	#end program
	li $v0, 10
	syscall

	# v0 = result of the function 
	#
Base_CKN:
	seq $t0, $s1, $0
	seq $t1, $s0, $s1
	add $t2, $t0, $t1
	blt $t2, 1, continue1	# If (k == 0 || k == n)
	nop
	addi $v0, $0, 1		# return 1
	jr $ra
	continue1:
	bne $s1, 1, continue2	# If (k == 1)
	nop
	addi $v0, $s0, 0	 	# return n 
	jr $ra
	continue2:
	
	j findCKN		# return C(k - 1, n - 1) + C(k,n-1)	
	
findCKN:
	subu $sp, $sp, 16 
	sw $ra, 0($sp)	
	
	sw $s1, 4($sp)	#save k
	sw $s0,	8($sp)	#save n
	addi $s1, $s1, -1	# k - 1
	addi $s0, $s0, -1	# n - 1
	jal Base_CKN	# -> C(k - 1, n - 1)
	
	lw $s1, 4($sp)	#restore k
	lw $s0, 8($sp)	#restore n
	sw $v0, 12($sp)	#save C(k - 1 , n - 1)
	
	
	addi $s0, $s0, -1	# n - 1
	
	jal Base_CKN	# -> C(k , n - 1)
		
	lw $t7, 12($sp)		#restore C(k-1,n-1)
	
	add $v0, $t7, $v0	#return C(k-1,n-1) + C(k,n-1)
	
	lw $ra, 0($sp)		#restore $ra
	add $sp, $sp, 16		#
	
	jr $ra

#--------------------------print out----------------------
error_input1:
	li $v0, 4
	la $a0, error_msg1
	syscall
	
	j EXIT

EXIT_result:
	li $v0, 4
	la $a0, output_res
	syscall
	
	li $v0, 1
	addi $a0, $s3, 0
	syscall
	
EXIT:
	li $v0, 10
	syscall
	
