.text

li $a0, 3

fib:
bgt $a0, 1, recurse
move $v0, $a0
beq $ra, 0, exit
jr $ra

recurse:
sub $sp, $sp, 12 # We need to store 3 registers to stack
sw $ra, 0($sp) # $ra is the first register
sw $a0, 4($sp) # $a0 is the second register, we cannot assume
		# $a registers will not be overwritten by callee
		
addi $a0, $a0, -1 # N-1
jal fib
sw $v0, 8($sp) # store $v0, the third register to be stored on
		#	 the stack so it doesn’t get overwritten by callee
		
lw $a0, 4($sp) # retrieve original value of N
addi $a0, $a0, -2 # N-2
jal fib

lw $t0, 8($sp) # retrieve first function result
add $v0, $v0, $t0
lw $ra, 0($sp) # retrieve return address
addi $sp, $sp, 12
jr $ra

exit:
