#Lab 4, Assignment 2

.text
	
	li $s0, 0x5749			#Load test value to s0
	
	andi $t0, $s0, 0xffffff00	#Extract MSB of s0 to t0
	srl $t0, $t0, 8
	
	andi $s0, $s0, 0xffffff00	#Clear LSB of s0
	
	ori $s0, $s0, 0xff		#Set LSB to 1
	
	and $s0, $s0, $zero		#Clear s0