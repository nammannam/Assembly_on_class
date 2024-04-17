#Laboratory Exercise 5, Assignment 1
.data
	test: .asciiz "Nguyen Khanh Nam"
.text
	li $v0, 4
	la $a0, test
	syscall