.text
	addi $s1, $s1, 5
		move $s3, $zero		# sum = 0
                move $s0, $zero		# i = 0
        LOOP:	slt $t0, $s0, $s1	# t0 is 1 if i < n; 0 if i >= n
                beq $t0, $zero, END	# goto END if i >= n
                sll $t0, $s0, 2  	# t0 = i * 4
                add $t0, $t0, $s2	# t0 is address of R[i]
                lw $t1, 0 ($t0)		# t1 = R[i]
                add $s3, $s3, $t1	# sum += R[i]
                addi $s0, $s0, 1	# i += 1 (or i++)
                j LOOP
	END: