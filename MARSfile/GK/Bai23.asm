.data
	input_msg1: .asciiz "Input n: "
	input_msg2: .asciiz "Input k: "
	
	output_res: .asciiz "C(k,n) = "
	
	error_msg1: .asciiz "wrong input"
	error_msg2: .asciiz "overflow: n > 12"
	
.text
	addi $s0, $0, 0		#s0 = n!
	addi $s1, $0, 0		#s1 = k!
	addi $s2, $0, 0		#s2 = (n-k)!
	addi $s3, $0, 0		#s3 = C(k,n)
	
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
	
	# CHECK  1 <= n <= 12 -> continue
	# ( n > 12 -> overflow)						
	bgt $s0, 12, error_input2
	nop 
	
	slt $t0, $s0, $s1		#Check n < k -> ERROR
	beq $t0, 1, error_input1
	nop
	
	#Temp var
	addi $t2, $s0, 0		#t2 = n
	addi $t3, $s1, 0		#t3 = k
	sub $t4, $s0, $s1	#t4 = n - k
	sub $s2, $s0, $s1	#s2 = n - k
	
	
Loop1:		#calculate n!
	
	beq $t2, 1, end_loop1
	nop
	addi $t2, $t2, -1
	mulu $s0, $s0, $t2
	j Loop1
		
end_loop1:
	
Loop2:		#calculate k!
	
	beq $t3, 1, end_loop2
	nop
	addi $t3, $t3, -1
	mulu $s1, $s1, $t3
	j Loop2
		
end_loop2:
	
Loop3:		#calculate (n-k)!
	
	beq $t4, 1, end_loop3
	nop
	addi $t4, $t4, -1
	mulu $s2, $s2, $t4
	j Loop3
		
end_loop3:

	#Calculate C(k,n)
	
	mulu $t5, $s1, $s2	#t5 = k!(n-k)!
	divu $s0, $t5
	mflo $s3
	j EXIT_result
	
	

error_input1:
	li $v0, 4
	la $a0, error_msg1
	syscall
	
	j EXIT

error_input2:
	li $v0, 4
	la $a0, error_msg2
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