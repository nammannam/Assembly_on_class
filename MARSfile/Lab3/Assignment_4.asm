#Lab Ex 3, Assigment 4
.data
	I: .word -3
	J: .word 14
	M: .word 1
	N: .word 13
	
.text
	#Load i and j, m, n 
	la $t6, M
	la $t7, N
	la $t8, I
	la $t9, J
	lw $s1, 0($t8)
	lw $s2, 0($t9)
	lw $s4, 0($t6)
	lw $s5, 0($t7)
	

	add $s3, $s1, $s2	# I + J  
	add $s6, $s4, $s5	# M + N
	
	start:
	slt $t0, $s6, $s3	
	beq $t0, $zero, else	# I + J <= 0
	addi $t1, $t1, 1		# x = x + 1
	addi $t3, $zero, 1	# z = 1
	j endif  
	
	else:
	addi $t2, $t2, -1	# y = y - 1
	add $t3, $t3, $t3	# z = 2*z
	
	endif:  
