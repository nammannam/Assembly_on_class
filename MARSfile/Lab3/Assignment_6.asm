#Laboratory 3, Assignment 6
.data
	n: .word 7
	step: .word 1
	A: .word 9, 1, 22, 10, 11, 22, 1	#Load array

.text
	#Load n, step, starting address A[i]
	la $t7, n
	la $t8, step
	lw $s3, 0($t7)
	lw $s4, 0($t8)
	la $s2, A

		
	addi $s5, $zero, 0	 # sum = 0
	addi $s1, $zero, 0	 # i = 0
	lw $t3, 0($s2)		 # SET MAX = t3
	
	
	loop:
	slt $t2, $s1, $s3	 # $t2 = i < n ? 1 : 0
	beq $t2, $zero, endloop
	add $t1, $s1, $s1	 # $t1 = 2 * $s1
	add $t1, $t1, $t1	 # $t1 = 4 * $s1 - 4 byte word
	add $t1, $t1, $s2 	 # $t1 store the address of A[i]
	lw $t0, 0($t1) 		 # load value of A[i] in $t0 
		#FIND MAX
		slt $t4, $t3, $t0
		bne $t4, 1, CONTINUE
		addi $t3, $t0, 0
		CONTINUE:
		
	add $s1, $s1, $s4	 # i = i + step
	j loop			 # goto loop
	
	endloop:
