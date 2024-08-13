    .eqv KEY_CODE 0xFFFF0004                    # ASCII code from keyboard, 1 byte
    .eqv KEY_READY 0xFFFF0000                   # =1 if has a new keycode ?
    # Auto clear after lw
    .eqv DISPLAY_CODE 0xFFFF000C                # ASCII code to show, 1 byte
    .eqv DISPLAY_READY 0xFFFF0008               # =1 if the display has already to do
    # Auto clear after sw
.text
    li      $k0,    KEY_CODE
    li      $k1,    KEY_READY
    li      $s0,    DISPLAY_CODE
    li      $s1,    DISPLAY_READY
loop:    nop     
WaitForKey:    lw      $t1,    0($k1)           # $t1 = [$k1] = KEY_READY
    nop     
    beq     $t1,    $zero,          WaitForKey  # if $t1 == 0 then Polling
    nop     
    #-----------------------------------------------------
ReadKey:    lw      $t0,    0($k0)              # $t0 = [$k0] = KEY_CODE
    nop 
    
    
    #-----------------------------------------------------
WaitForDis:    lw      $t2,    0($s1)           # $t2 = [$s1] = DISPLAY_READY
    nop     

    beq     $t2,    $zero,          WaitForDis  # if $t2 == 0 then Polling
    nop     
    #-----------------------------------------------------
#Encrypt:    addi    $t0,    $t0,            1   # change input key
    #-----------------------------------------------------
ShowKey:
   
   	
  	sw      $t0,    0($s0)              # show key
	nop
CHECK:
	beq $t7, 1, wait_x	
	bne $t0, 0x65, loop	#Check e
	nop
	addi $t7, $0, 1
wait_x:
	beq $t7, 2, wait_i
	bne $t0, 0x78, loop
	nop
	addi $t7, $t7, 1
wait_i:
	beq $t7, 3, wait_t
	bne $t0, 0x69, loop
	nop
	addi $t7, $t7, 1
	
wait_t:
	bne $t0, 0x74, loop
	nop	
	j exitProgram	
   	nop

    #-----------------------------------------------------
    j       loop
    nop
   
exitProgram:
	li $v0, 10
	syscall 