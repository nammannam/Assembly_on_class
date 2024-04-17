    #Assignment 5

.data   
max:    .asciiz "Largest: "
min:    .asciiz "\nSmallest: "
comma:  .asciiz ", "
.text   
    #Load
    li      $s0,        5
    li      $s1,        -12
    li      $s2,        56
    li      $s3,        12
    li      $s4,        87
    li      $s5,        -2
    li      $s6,        -343
    li      $s7,        23

    jal     Load_stack
    nop     
    #-----------------------------

    #	 $t8 = MAX, $t6 = index of MAX
    # 	$t9 = MIN, $t7 = index of MIN

    #--------------------------------

    li      $v0,        4               #Print max
    la      $a0,        max
    syscall 

    li      $v0,        1
    add     $a0,        $t8,        $0
    syscall 

    li      $v0,        4
    la      $a0,        comma
    syscall 

    li      $v0,        1
    add     $a0,        $t6,        $0
    syscall 

    li      $v0,        4               #Print MIN
    la      $a0,        min
    syscall 

    li      $v0,        1
    add     $a0,        $t9,        $0
    syscall 

    li      $v0,        4
    la      $a0,        comma
    syscall 

    li      $v0,        1
    add     $a0,        $t7,        $0
    syscall 

    li      $v0,        10              #EXIT
    syscall 

Load_stack:	addi $fp, $sp, 0		#Using $fp (1)

    addi    $sp,        $sp,        -32
    sw      $s0,        0($sp)
    sw      $s1,        4($sp)
    sw      $s2,        8($sp)
    sw      $s3,        12($sp)
    sw      $s4,        16($sp)
    sw      $s5,        20($sp)
    sw      $s6,        24($sp)
    sw      $s7,        28($sp)

    #not using 32($sp)
    la      $t5,        32($sp)         #Save address of 32($sp) -> use address to stop the programn (2)
    add     $t4,        $ra,        $0

    #sw $ra, 32($sp) 		#Save return address to print result (3)
    #add $t5, $ra, $0		#Save original address of sp to end programn

    li      $t6,        0               #Initiate index and min = max = first value
    li      $t7,        0
    lw      $t8,        0($sp)
    lw      $t9,        0($sp)

    li      $t0,        0               #i = 0
    j       FindMaxMin
    nop     

SwapMax:
    add     $t6,        $t0,        $0
    addi     $t8,        $t1,        0
    jr      $ra

SwapMin:
    add     $t7,        $t0,        $0
    addi     $t9,        $t1,        0
    jr      $ra

FindMaxMin:
    addi     $sp,        $sp,        4

    beq     $sp,        $fp,        end #Not using 32($sp)

    #lw $t4, 0($sp)			#Check stop find
    #beq $t4, $t5, end
    nop     

    lw      $t1,        0($sp)          #temp de so sanh

    #-----------------------------

    #	 $t8 = MAX, $t6 = index of MAX
    # 	$t9 = MIN, $t7 = index of MIN

    #--------------------------------
    add     $t0,        $t0,        1

    sub     $t2,        $t8,        $t1 #Check Max
    bltzal  $t2,        SwapMax
    nop     

    sub     $t2,        $t1,        $t9 #Check Min
    bltzal  $t2,        SwapMin
    nop     

    j       FindMaxMin
    nop     

end:    
    add     $ra,        $t4,        $0  #Not using 32($sp)
    #lw $ra, 0($sp)
    jr      $ra





