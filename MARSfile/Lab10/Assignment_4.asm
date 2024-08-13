
.eqv KEY_CODE 0xFFFF0004 # ASCII code from keyboard, 1 byte

.eqv KEY_READY 0xFFFF0000 # =1 if has a new keycode ? # Auto clear after lw

.eqv DISPLAY_CODE 0xFFFF000C # ASCII code to show, 1 byte

.eqv DISPLAY_READY 0xFFFF0008 # =1 if the display has already to do # Auto clear after sw

.text

    li $k0, KEY_CODE

    li $k1, KEY_READY

    li $s0, DISPLAY_CODE

    li $s1, DISPLAY_READY

    li $s2, 'e' # ASCII code for 'e'

    li $s3, 'x' # ASCII code for 'x'

    li $s4, 'i' # ASCII code for 'i'

    li $s5, 't' # ASCII code for 't'

    li $s6, 0   # Counter for the number of correct characters
 
loop:   nop

WaitForKey: lw $t1, 0($k1) # $t1 = [$k1] = KEY_READY

    beq $t1, $zero, WaitForKey # if $t1 == 0 then Polling

ReadKey: lw $t0, 0($k0) # $t0 = [$k0] = KEY_CODE

WaitForDis: lw $t2, 0($s1) # $t2 = [$s1] = DISPLAY_READY

    beq $t2, $zero, WaitForDis # if $t2 == 0 then Polling

    ShowKey: sw $t0, 0($s0) # show key

    nop
 
    # Check if the key matches the first character of "exit"

    beq $t0, $s2, CheckSecondChar

    j loop
 
CheckSecondChar:

    # Increment the counter and check the next character

    addi $s6, $s6, 1

    WaitForKey2: lw $t1, 0($k1) # $t1 = [$k1] = KEY_READY

    beq $t1, $zero, WaitForKey2 # if $t1 == 0 then Polling

    ReadKey2: lw $t0, 0($k0)

    WaitForDis2: lw $t2, 0($s1) # $t2 = [$s1] = DISPLAY_READY

    beq $t2, $zero, WaitForDis2 # if $t2 == 0 then Polling

    ShowKey2: sw $t0, 0($s0) # show key

    nop
 
    lw $t0, 0($k0)

    beq $t0, $s3, CheckThirdChar

    j loop
 
CheckThirdChar:

    addi $s6, $s6, 1

    WaitForKey3: lw $t1, 0($k1) # $t1 = [$k1] = KEY_READY

    beq $t1, $zero, WaitForKey3 # if $t1 == 0 then Polling

    ReadKey3: lw $t0, 0($k0)

    WaitForDis3: lw $t2, 0($s1) # $t2 = [$s1] = DISPLAY_READY

    beq $t2, $zero, WaitForDis3 # if $t2 == 0 then Polling

    ShowKey3: sw $t0, 0($s0) # show key

    nop
 
    lw $t0, 0($k0)

    beq $t0, $s4, CheckFourthChar

    j loop
 
CheckFourthChar:

    addi $s6, $s6, 1

    WaitForKey4: lw $t1, 0($k1) # $t1 = [$k1] = KEY_READY

    beq $t1, $zero, WaitForKey4 # if $t1 == 0 then Polling

    ReadKey4: lw $t0, 0($k0)

    WaitForDis4: lw $t2, 0($s1) # $t2 = [$s1] = DISPLAY_READY

    beq $t2, $zero, WaitForDis4 # if $t2 == 0 then Polling

    ShowKey4: sw $t0, 0($s0) # show key

    nop
 
    lw $t0, 0($k0)

    beq $t0, $s5, End

    j loop
 
 
    

End:
 
WaitForDis5: lw $t2, 0($s1) # $t2 = [$s1] = DISPLAY_READY

    beq $t2, $zero, WaitForDis5 # if $t2 == 0 then Polling

    ShowKey5: sw $t0, 0($s0) # show key

    nop
