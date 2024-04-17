    #Laboratory Exercise 5, Assignment 4
    
.data
	CheckMax: .word 20
	CheckEnter: .asciiz "\n"
	reversed: .space 20

	Message2: .asciiz "Chuoi dao nguoc: "
.text
	la $s0, reversed
	lw $t1, CheckMax
	lw $t2, CheckEnter
	addi $t0, $0, 0	# i = 0
	
loop_read:
	li $v0, 12
	syscall
	beq $v0, $t2, end_read
	#Load to string
	add $t3, $s0, $t0
	sb $v0, 0($t3)

	addi $t0, $t0, 1	#Count i
	 
	bne $t0, $t1, loop_read
	nop
end_read:
	li $v0, 11
	lb $a0, CheckEnter
	syscall

	li $v0, 4
	la $a0, Message2
	syscall
print_reverse:
	
	li $v0, 11
	lb $a0, 0($t3)
	syscall
	
	add $t3, $t3, -1
	addi $t0, $t0, -1
	blez $t0, end
	
	j print_reverse
	
end:

