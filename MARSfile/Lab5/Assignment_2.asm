#Laboratory Exercise 5, Assignment 2
.data
	string1: .asciiz "The sum of "
	string2: .asciiz " and "
	string3: .asciiz " is "
	
.text 
	li $s0, 1
	li $s1, 2
	add $s2, $s0, $s1
	
	li $v0, 4
	la $a0, string1
	syscall
	
	li $v0, 1
	add $a0, $0, $s0
	syscall
	
	li $v0, 4
	la $a0, string2
	syscall
	
	li $v0, 1
	add $a0, $0, $s1
	syscall
	
	li $v0, 4
	la $a0, string3
	syscall
	
	li $v0, 1
	add $a0, $0, $s2
	syscall
	
	
	
