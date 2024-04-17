#Lab 6, Assignment 3
.data 
	A: .word  7, -2, 5, 1, 5, 6, 7, 3, 6, 8, 8, 59, 5
	Aend: .word
	
.text

	la $a0, A		#A address
	addi $t0, $0, 13		# N
	addi $t1, $t1, 1		#i=1
	
insertionSort:
	slt $t2, $t1, $t0	#Kiem tra i < N 
	add $t3, $t1, -1		# j = i - 1
	beq $t2, $0, end
	nop			
	sll $t1, $t1, 2		
	add $a1, $a0, $t1	#Dia chi cua arr[i]
	lw $s0, 0($a1)		#key = arr[i]
	add $a2, $a1, -4		#Dia chi cua arr[j] voi j = i - 1
	
	
	Swap:
		lw $s1, 0($a2)		# = arr[j]
		slt $t4, $t3, $0		#check j>=0
		beq $t4, 1, End_swap
		slt $t5, $s0, $s1	#check arr[j] > key
		beq $t5, 0, End_swap	
		nop
		sw $s1, 4($a2)		#Dia chi cua arr[j+1] va arr[j+1] = arr[j]
		add $t3, $t3, -1		# j = j - 1
		beq $t3, -1, End_swap	#Check j<0 thi nhay ra khoi swap
		nop
		add $a2, $a2, -4		#Thay doi dia chi thanh arr[j = j - 1]
		j Swap
		nop
	End_swap:
		add $t3, $t3, 1		
		sll $t3, $t3, 2		#Cap nhat lai j + 1
		add $a2, $a0, $t3	#Dia chi cua arr[j+1]
		sw $s0, 0($a2)		#arr[j+1] = key
		srl $t1, $t1, 2
		add $t1, $t1, 1
		j insertionSort
		nop
end:
	
	
