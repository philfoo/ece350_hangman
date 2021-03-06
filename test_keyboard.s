##--------------------------------------------Register Definition-------------------------------------------##
## $r0 = 0
## $r1 = input register
## $r2 = 1 always (for now)
## $r3: loop counter for each character of word (i)
## $r4 is the temporary register where you check input against data
## $r5 is the temporary register where you load letters
## $r6: register where you store address for writing vga
## $r7: address offset in the write loop
## $r8: register for debouncing keyboard
## $r9: register where you load bignum
## $r10: location where you end up writing letters
## $r30: where the input from keyboard ends up

.text
main:
nop
nop
addi $r2, $r0, 1     #initialize $r2 to 1
nop
nop
nop
add $r6, $r0, $r0    #initialize r6 (starting address) to 0 for now
nop
nop
nop
nop
lw $r9, 36($r0)     #load bignum into $r9
nop
nop
nop



loop:
jal wait_for_input
nop
nop
nop
nop
nop
jal render_character  #Go to render character method, r4 has character
nop
nop
nop
nop
nop
addi $r7, $r7, 12     #increment 12 to the right
nop
nop
nop
nop
nop
bne $r2, $r0, loop    #infinite loop because 1 < 0 is false
nop
nop
nop
nop
nop

#--------------------------Wait for input ---------------------#
wait_for_input:
add $r8, $r0, $r0    #set debounce register to 0 repetitively
nop
nop
bne $r1, $r0, move_input   #branch if you detect something in $r1 that's not 0
nop
nop
nop
j wait_for_input     #loop back and wait if still equal
nop
nop
nop
nop
nop


move_input:
addi $r4, $r1, 0
nop
nop
nop
j input_ready
nop
nop

input_ready:             
nop
nop
nop
addi $r8, $r8, 1     #increment $r8
nop
nop
nop
nop
blt $r8, $r9, input_ready      #if $r8 is less than $r9, stall
nop
nop
nop
nop
nop
jr $r31
nop
nop


#--------------------------Render stuff -------------------------#
render_character:
lw $r5, 0($r0)       #load A
nop
nop
nop
nop
nop
bne $r5, $r4, check_b #this letter is not A
nop
nop
nop
nop
nop
j write_a
nop
nop
nop
nop
nop

check_b:
lw $r5, 1($r0)       #load B
nop
nop
nop
nop
nop
bne $r5, $r4, check_c
nop
nop
nop
nop
j write_b
nop
nop
nop
nop
nop

check_c:
lw $r5, 2($r0)        #load C
nop
nop
nop
nop
nop
bne $r5, $r4, check_d
nop
nop
nop
nop
j write_c
nop
nop


check_d:
lw $r5, 3($r0)        #load D
nop
nop
nop
nop
nop
bne $r5, $r4, check_e
nop
nop
nop
nop
j write_d
nop
nop
nop
nop
nop

check_e:
lw $r5, 4($r0)        #load E
nop
nop
nop
nop
nop
bne $r5, $r4, check_f
nop
nop
nop
nop
j write_e
nop
nop
nop
nop
nop

check_f:
lw $r5, 5($r0)        #load F
nop
nop
nop
nop
nop
bne $r5, $r4, check_g
nop
nop
nop
nop
j write_f
nop
nop
nop
nop
nop

check_g:
lw $r5, 6($r0)        #load G
nop
nop
bne $r5, $r4, check_h
nop
j write_g
nop
nop
nop
nop
nop

check_h:
lw $r5, 7($r0)        #load H
nop
nop
nop
nop
nop
bne $r5, $r4, check_i
nop
nop
nop
nop
j write_h

check_i:
lw $r5, 8($r0)        #load I
nop
nop
nop
nop
nop
bne $r5, $r4, check_j
nop
nop
nop
nop
j write_i
nop
nop
nop
nop
nop

check_j:
lw $r5, 9($r0)        #load J
nop
nop
nop
nop
nop
bne $r5, $r4, check_k
nop
nop
nop
nop
nop
j write_j
nop
nop
nop
nop
nop

check_k:
lw $r5, 10($r0)        #load K
nop
nop
nop
nop
nop
bne $r5, $r4, check_l
nop
nop
j write_k
nop
nop

check_l:
lw $r5, 11($r0)        #load L
nop
nop
nop
nop
nop
bne $r5, $r4, check_m
nop
j write_l
nop
nop

check_m:
lw $r5, 12($r0)        #load m
nop
nop
nop
nop
nop
bne $r5, $r4, check_n
nop
j write_m
nop
nop

check_n:
lw $r5, 13($r0)        #load n
nop
nop
nop
nop
nop
bne $r5, $r4, check_o
nop
nop
nop
nop
j write_n
nop
nop

check_o:
lw $r5, 14($r0)        #load o
nop
nop
nop
nop
nop
bne $r5, $r4, check_p
nop
nop
nop
nop
j write_o
nop
nop

check_p:
lw $r5, 15($r0)        #load p
nop
nop
nop
nop
nop
bne $r5, $r4, check_q
nop
nop
nop
nop
j write_p
nop
nop

check_q:
lw $r5, 16($r0)        #load q
nop
nop
bne $r5, $r4, check_r
nop
nop
nop
nop
j write_q
nop
nop

check_r:
lw $r5, 17($r0)        #load r
nop
nop
bne $r5, $r4, check_s
nop
nop
nop
nop
j write_r
nop
nop

check_s:
lw $r5, 18($r0)        #load s
nop
nop
bne $r5, $r4, check_t
nop
nop
nop
nop
nop
nop
nop
j write_s
nop
nop

check_t:
lw $r5, 19($r0)        #load t
nop
nop
bne $r5, $r4, check_u
nop
nop
nop
nop
j write_t
nop
nop

check_u:
lw $r5, 20($r0)        #load u
nop
nop
bne $r5, $r4, check_v
nop
nop
nop
nop
j write_u
nop
nop

check_v:
lw $r5, 21($r0)        #load v
nop
nop
bne $r5, $r4, check_w
nop
nop
nop
nop
j write_v
nop
nop

check_w:
lw $r5, 22($r0)        #load w
nop
nop
bne $r5, $r4, check_x
nop
nop
nop
nop
j write_w
nop
nop

check_x:
lw $r5, 23($r0)        #load x
nop
nop
bne $r5, $r4, check_y
nop
nop
nop
nop
j write_x
nop
nop

check_y:
lw $r5, 24($r0)        #load y
nop
nop
bne $r5, $r4, check_z
nop
nop
nop
nop
j write_y
nop
nop

check_z:
lw $r5, 25($r0)        #load z
nop
nop
bne $r5, $r4, check_0
nop
nop
nop
nop
j write_z
nop
nop

check_0:
lw $r5, 26($r0)        #load 0
nop
nop
bne $r5, $r4, check_1
nop
nop
nop
nop
j write_o
nop
nop

check_1:
lw $r5, 27($r0)        #load 1
nop
nop
bne $r5, $r4, check_2
nop
nop
nop
nop
j write_1
nop
nop

check_2:
lw $r5, 28($r0)        #load 2
nop
nop
bne $r5, $r4, check_3
nop
j write_2
nop
nop

check_3:
lw $r5, 29($r0)        #load 3
nop
nop
bne $r5, $r4, check_4
nop
j write_3
nop
nop

check_4:
lw $r5, 30($r0)        #load 4
nop
nop
bne $r5, $r4, check_5
nop
j write_4
nop
nop

check_5:
lw $r5, 31($r0)        #load 5
nop
nop
bne $r5, $r4, check_6
nop
j write_5
nop
nop

check_6:
lw $r5, 32($r0)        #load 6
nop
nop
bne $r5, $r4, check_7
nop
j write_6
nop
nop

check_7:
lw $r5, 33($r0)        #load 7
nop
nop
bne $r5, $r4, check_8
nop
j write_7
nop
nop

check_8:
lw $r5, 34($r0)        #load 8
nop
nop
bne $r5, $r4, check_9
nop
j write_8
nop
nop

check_9:
lw $r5, 35($r0)        #load 9
nop
nop
bne $r5, $r4, loop
nop
j write_9
nop
nop

#----------------------------Write character methods---------------------------#
write_a:
add $r10, $r7, $r6      #create it in the proper place
nop
sw $r2, 0x06b1c($r10)
sw $r2, 0x06b1d($r10)
sw $r2, 0x06b1e($r10)
sw $r2, 0x06b1f($r10)
sw $r2, 0x06d9b($r10)
sw $r2, 0x06d9c($r10)
sw $r2, 0x06d9d($r10)
sw $r2, 0x06d9e($r10)
sw $r2, 0x06d9f($r10)
sw $r2, 0x06da0($r10)
sw $r2, 0x0701a($r10)
sw $r2, 0x0701b($r10)
sw $r2, 0x07020($r10)
sw $r2, 0x072a0($r10)
sw $r2, 0x0751b($r10)
sw $r2, 0x0751c($r10)
sw $r2, 0x0751d($r10)
sw $r2, 0x0751e($r10)
sw $r2, 0x0751f($r10)
sw $r2, 0x07520($r10)
sw $r2, 0x0751a($r10)
sw $r2, 0x0779a($r10)
sw $r2, 0x077a0($r10)
sw $r2, 0x07a19($r10)
sw $r2, 0x07a1a($r10)
sw $r2, 0x07a20($r10)
sw $r2, 0x07c99($r10)
sw $r2, 0x07c9a($r10)
sw $r2, 0x07ca0($r10)
sw $r2, 0x07f19($r10)
sw $r2, 0x07f1a($r10)
sw $r2, 0x07f1e($r10)
sw $r2, 0x07f1f($r10)
sw $r2, 0x07f20($r10)
sw $r2, 0x0819a($r10)
sw $r2, 0x0819b($r10)
sw $r2, 0x0819c($r10)
sw $r2, 0x0819d($r10)
sw $r2, 0x0819e($r10)
sw $r2, 0x0819f($r10)
sw $r2, 0x081a0($r10)
jr $r31                  #go back to render_character
nop
nop

write_b:
add $r10, $r7, $r6
nop
sw $r2, 0x06b1b($r10)
sw $r2, 0x06d9b($r10)
sw $r2, 0x0701b($r10)
sw $r2, 0x0729b($r10)
sw $r2, 0x0751b($r10)
sw $r2, 0x0779b($r10)
sw $r2, 0x0779c($r10)
sw $r2, 0x0779d($r10)
sw $r2, 0x0779e($r10)
sw $r2, 0x0779f($r10)
sw $r2, 0x07a1b($r10)
sw $r2, 0x07a1f($r10)
sw $r2, 0x07a20($r10)
sw $r2, 0x07c9b($r10)
sw $r2, 0x07c9f($r10)
sw $r2, 0x07ca0($r10)
sw $r2, 0x07f1b($r10)
sw $r2, 0x07f1f($r10)
sw $r2, 0x07f20($r10)
sw $r2, 0x0719b($r10)
sw $r2, 0x0719c($r10)
sw $r2, 0x0719d($r10)
sw $r2, 0x0719e($r10)
sw $r2, 0x0719f($r10)
sw $r2, 0x071a1($r10)
jr $r31
nop
nop

write_c:
add $r10, $r7, $r6
nop
sw $r2, 0x0751b($r10)
sw $r2, 0x0751c($r10)
sw $r2, 0x0751d($r10)
sw $r2, 0x0779a($r10)
sw $r2, 0x0779b($r10)
sw $r2, 0x07a1a($r10)
sw $r2, 0x07c9a($r10)
sw $r2, 0x07f1a($r10)
sw $r2, 0x07f1b($r10)
sw $r2, 0x0819a($r10)
sw $r2, 0x0819b($r10)
sw $r2, 0x0819c($r10)
sw $r2, 0x0819d($r10)
jr $r31
nop
nop

write_d:
add $r10, $r7, $r6
nop
sw $r2, 0x06b1e($r10)
sw $r2, 0x06d9c($r10)
sw $r2, 0x0701e($r10)
sw $r2, 0x0729e($r10)
sw $r2, 0x0751e($r10)
sw $r2, 0x0779a($r10)
sw $r2, 0x0779b($r10)
sw $r2, 0x0779c($r10)
sw $r2, 0x0779d($r10)
sw $r2, 0x0779e($r10)
sw $r2, 0x07a19($r10)
sw $r2, 0x07a1a($r10)
sw $r2, 0x07a1e($r10)
sw $r2, 0x07c99($r10)
sw $r2, 0x07c9e($r10)
sw $r2, 0x07f19($r10)
sw $r2, 0x07f1a($r10)
sw $r2, 0x07f1e($r10)
sw $r2, 0x08199($r10)
sw $r2, 0x0819a($r10)
sw $r2, 0x0819b($r10)
sw $r2, 0x0819c($r10)
sw $r2, 0x0819d($r10)
sw $r2, 0x0819e($r10)
jr $r31
nop
nop

write_e:
add $r10, $r7, $r6
nop
sw $r2, 0x0729c($r10)
sw $r2, 0x0729d($r10)
sw $r2, 0x0729e($r10)
sw $r2, 0x0751b($r10)
sw $r2, 0x0751f($r10)
sw $r2, 0x0779b($r10)
sw $r2, 0x0779c($r10)
sw $r2, 0x0779d($r10)
sw $r2, 0x0779e($r10)
sw $r2, 0x0779f($r10)
sw $r2, 0x07a1b($r10)
sw $r2, 0x07c9b($r10)
sw $r2, 0x07c9c($r10)
sw $r2, 0x07f1b($r10)
sw $r2, 0x07f1c($r10)
sw $r2, 0x07f1d($r10)
sw $r2, 0x07f1e($r10)
sw $r2, 0x07f1f($r10)
jr $r31
nop
nop

write_f:
add $r10, $r7, $r6
nop
sw $r2, 0x06b1b($r10)
sw $r2, 0x06b1c($r10)
sw $r2, 0x06b1d($r10)
sw $r2, 0x06d9b($r10)
sw $r2, 0x06d9d($r10)
sw $r2, 0x06d9e($r10)
sw $r2, 0x0701b($r10)
sw $r2, 0x0701e($r10)
sw $r2, 0x0729b($r10)
sw $r2, 0x0729e($r10)
sw $r2, 0x0751b($r10)
sw $r2, 0x0779a($r10)
sw $r2, 0x0779b($r10)
sw $r2, 0x0779c($r10)
sw $r2, 0x0779d($r10)
sw $r2, 0x0779e($r10)
sw $r2, 0x07a1b($r10)
sw $r2, 0x07c9b($r10)
sw $r2, 0x07f1b($r10)
sw $r2, 0x0819b($r10)
jr $r31
nop
nop

write_g:
add $r10, $r7, $r6
nop
sw $r2, 0x0729c($r10)
sw $r2, 0x0729d($r10)
sw $r2, 0x0729e($r10)
sw $r2, 0x0729f($r10)
sw $r2, 0x0751b($r10)
sw $r2, 0x0751f($r10)
sw $r2, 0x0779b($r10)
sw $r2, 0x0779f($r10)
sw $r2, 0x07a1b($r10)
sw $r2, 0x07a1c($r10)
sw $r2, 0x07a1d($r10)
sw $r2, 0x07a1e($r10)
sw $r2, 0x07a1f($r10)
sw $r2, 0x07c9f($r10)
sw $r2, 0x07f1f($r10)
sw $r2, 0x0819b($r10)
sw $r2, 0x0819c($r10)
sw $r2, 0x0819d($r10)
sw $r2, 0x0819e($r10)
sw $r2, 0x0819f($r10)
jr $r31
nop
nop

write_h:
add $r10, $r7, $r6
nop
sw $r2, 0x06b1b($r10)
sw $r2, 0x06d9b($r10)
sw $r2, 0x0701b($r10)
sw $r2, 0x0729b($r10)
sw $r2, 0x0751b($r10)
sw $r2, 0x0779b($r10)
sw $r2, 0x0779d($r10)
sw $r2, 0x0779e($r10)
sw $r2, 0x07a1b($r10)
sw $r2, 0x07a1c($r10)
sw $r2, 0x07a1d($r10)
sw $r2, 0x07a1e($r10)
sw $r2, 0x07a1f($r10)
sw $r2, 0x07c9b($r10)
sw $r2, 0x07c9f($r10)
sw $r2, 0x07f1b($r10)
sw $r2, 0x07f1f($r10)
sw $r2, 0x0819b($r10)
sw $r2, 0x0819f($r10)
jr $r31
nop
nop

write_i:
add $r10, $r7, $r6
nop
sw $r2, 0x06b1c($r10)
sw $r2, 0x06b1d($r10)
sw $r2, 0x06d9c($r10)
sw $r2, 0x06d9d($r10)
sw $r2, 0x0729d($r10)
sw $r2, 0x0751c($r10)
sw $r2, 0x0751d($r10)
sw $r2, 0x0779d($r10)
sw $r2, 0x07a1d($r10)
sw $r2, 0x07c9d($r10)
sw $r2, 0x07f1d($r10)
sw $r2, 0x0819e($r10)
sw $r2, 0x0819d($r10)
sw $r2, 0x0819e($r10)
jr $r31
nop
nop

write_j:
add $r10, $r7, $r6
sw $r2, 0x06b1c($r10)
sw $r2, 0x06b1d($r10)
sw $r2, 0x06d9c($r10)
sw $r2, 0x06d9d($r10)
sw $r2, 0x0729d($r10)
sw $r2, 0x0751c($r10)
sw $r2, 0x0751d($r10)
sw $r2, 0x0779d($r10)
sw $r2, 0x07a1d($r10)
sw $r2, 0x07c9a($r10)
sw $r2, 0x07c9d($r10)
sw $r2, 0x07f1a($r10)
sw $r2, 0x07f1c($r10)
sw $r2, 0x07f1d($r10)
sw $r2, 0x0819a($r10)
sw $r2, 0x0819b($r10)
sw $r2, 0x0819c($r10)
sw $r2, 0x0819d($r10)
jr $r31
nop
nop

write_k:
add $r10, $r7, $r6
nop
nop
sw $r2, 0x06b1b($r10)
sw $r2, 0x06d9b($r10)
sw $r2, 0x0701b($r10)
sw $r2, 0x0729b($r10)
sw $r2, 0x0729e($r10)
sw $r2, 0x0751b($r10)
sw $r2, 0x0751d($r10)
sw $r2, 0x0751e($r10)
sw $r2, 0x0779b($r10)
sw $r2, 0x0779c($r10)
sw $r2, 0x0779d($r10)
sw $r2, 0x07a1b($r10)
sw $r2, 0x07a1c($r10)
sw $r2, 0x07c9b($r10)
sw $r2, 0x07c9c($r10)
sw $r2, 0x07c9d($r10)
sw $r2, 0x07f1b($r10)
sw $r2, 0x07f1d($r10)
sw $r2, 0x07f1e($r10)
sw $r2, 0x0819b($r10)
sw $r2, 0x0819e($r10)
jr $r31
nop
nop

write_l:
add $r10, $r7, $r6
nop
nop
sw $r2, 0x06b1b($r10)
sw $r2, 0x06b1c($r10)
sw $r2, 0x06d9c($r10)
sw $r2, 0x0701c($r10)
sw $r2, 0x0729c($r10)
sw $r2, 0x0751c($r10)
sw $r2, 0x0779c($r10)
sw $r2, 0x07a1c($r10)
sw $r2, 0x07c9c($r10)
sw $r2, 0x07f1c($r10)
sw $r2, 0x0819b($r10)
sw $r2, 0x0819c($r10)
sw $r2, 0x0819d($r10)
jr $r31
nop
nop

write_m:
add $r10, $r7, $r6
nop
nop
sw $r2, 0x07019($r10)
sw $r2, 0x07298($r10)
sw $r2, 0x07299($r10)
sw $r2, 0x0729a($r10)
sw $r2, 0x0729b($r10)
sw $r2, 0x0729c($r10)
sw $r2, 0x0729d($r10)
sw $r2, 0x0729e($r10)
sw $r2, 0x0729f($r10)
sw $r2, 0x072a0($r10)
sw $r2, 0x07519($r10)
sw $r2, 0x0751a($r10)
sw $r2, 0x0751c($r10)
sw $r2, 0x0751d($r10)
sw $r2, 0x0751f($r10)
sw $r2, 0x07520($r10)
sw $r2, 0x07799($r10)
sw $r2, 0x07a19($r10)
sw $r2, 0x07c99($r10)
sw $r2, 0x07f19($r10)
sw $r2, 0x08199($r10)
sw $r2, 0x0779c($r10)
sw $r2, 0x07a1c($r10)
sw $r2, 0x07c9c($r10)
sw $r2, 0x07f1c($r10)
sw $r2, 0x0819c($r10)
sw $r2, 0x077a0($r10)
sw $r2, 0x07a20($r10)
sw $r2, 0x07ca0($r10)
sw $r2, 0x07f20($r10)
sw $r2, 0x081a0($r10)
jr $r31
nop
nop

write_n:
add $r10, $r7, $r6
nop
nop
sw $r2, 0x0701b($r10)
sw $r2, 0x0729a($r10)
sw $r2, 0x0729b($r10)
sw $r2, 0x0729d($r10)
sw $r2, 0x0729e($r10)
sw $r2, 0x0729f($r10)
sw $r2, 0x0751b($r10)
sw $r2, 0x0751c($r10)
sw $r2, 0x0751d($r10)
sw $r2, 0x0751e($r10)
sw $r2, 0x0751f($r10)
sw $r2, 0x07520($r10)
sw $r2, 0x0779b($r10)
sw $r2, 0x07a1b($r10)
sw $r2, 0x07c9b($r10)
sw $r2, 0x07f1b($r10)
sw $r2, 0x0819b($r10)
sw $r2, 0x077a0($r10)
sw $r2, 0x07a20($r10)
sw $r2, 0x07ca0($r10)
sw $r2, 0x07f20($r10)
sw $r2, 0x081a0($r10)
jr $r31
nop
nop

write_o:
add $r10, $r7, $r6
nop
nop
sw $r2, 0x06d9a($r10)
sw $r2, 0x06d9b($r10)
sw $r2, 0x06d9c($r10)
sw $r2, 0x06d9d($r10)
sw $r2, 0x06d9e($r10)
sw $r2, 0x06d9f($r10)
sw $r2, 0x07019($r10)
sw $r2, 0x0701a($r10)
sw $r2, 0x0701b($r10)
sw $r2, 0x0701e($r10)
sw $r2, 0x0701f($r10)
sw $r2, 0x07020($r10)
sw $r2, 0x07299($r10)
sw $r2, 0x072a0($r10)
sw $r2, 0x07518($r10)
sw $r2, 0x07519($r10)
sw $r2, 0x07520($r10)
sw $r2, 0x07521($r10)
sw $r2, 0x07798($r10)
sw $r2, 0x07799($r10)
sw $r2, 0x077a0($r10)
sw $r2, 0x077a1($r10)
sw $r2, 0x07a18($r10)
sw $r2, 0x07a19($r10)
sw $r2, 0x07a20($r10)
sw $r2, 0x07a21($r10)
sw $r2, 0x07c99($r10)
sw $r2, 0x07ca0($r10)
sw $r2, 0x07f19($r10)
sw $r2, 0x07f1a($r10)
sw $r2, 0x07f1e($r10)
sw $r2, 0x07f1f($r10)
sw $r2, 0x0819a($r10)
sw $r2, 0x0819b($r10)
sw $r2, 0x0819d($r10)
sw $r2, 0x0819e($r10)
sw $r2, 0x0819f($r10)
jr $r31
nop
nop

write_p:
add $r10, $r7, $r6
nop
nop
sw $r2, 0x06d9b($r10)
sw $r2, 0x06d9c($r10)
sw $r2, 0x06d9d($r10)
sw $r2, 0x06d9e($r10)
sw $r2, 0x06d9f($r10)
sw $r2, 0x0701b($r10)
sw $r2, 0x0701f($r10)
sw $r2, 0x0729b($r10)
sw $r2, 0x0729f($r10)
sw $r2, 0x0751b($r10)
sw $r2, 0x0751e($r10)
sw $r2, 0x0751f($r10)
sw $r2, 0x0779b($r10)
sw $r2, 0x0779c($r10)
sw $r2, 0x0779d($r10)
sw $r2, 0x0779e($r10)
sw $r2, 0x07a1b($r10)
sw $r2, 0x07c9b($r10)
sw $r2, 0x07f1b($r10)
sw $r2, 0x0819b($r10)
jr $r31
nop
nop

write_q:
add $r10, $r7, $r6
nop
nop
sw $r2, 0x06d9b($r10)
sw $r2, 0x06d9c($r10)
sw $r2, 0x06d9f($r10)
sw $r2, 0x0701b($r10)
sw $r2, 0x0701f($r10)
sw $r2, 0x0729b($r10)
sw $r2, 0x0729f($r10)
sw $r2, 0x0751b($r10)
sw $r2, 0x0751c($r10)
sw $r2, 0x0751f($r10)
sw $r2, 0x0779c($r10)
sw $r2, 0x0779d($r10)
sw $r2, 0x0779e($r10)
sw $r2, 0x0779f($r10)
sw $r2, 0x07a1f($r10)
sw $r2, 0x07c9f($r10)
sw $r2, 0x07f1f($r10)
sw $r2, 0x0819f($r10)
sw $r2, 0x081a0($r10)
jr $r31
nop
nop

write_r:
add $r10, $r7, $r6
nop
nop
sw $r2, 0x0701b($r10)
sw $r2, 0x0701d($r10)
sw $r2, 0x0701e($r10)
sw $r2, 0x0729b($r10)
sw $r2, 0x0729c($r10)
sw $r2, 0x0729d($r10)
sw $r2, 0x0729e($r10)
sw $r2, 0x0729f($r10)
sw $r2, 0x0751b($r10)
sw $r2, 0x0751c($r10)
sw $r2, 0x0751f($r10)
sw $r2, 0x0779b($r10)
sw $r2, 0x07a1b($r10)
sw $r2, 0x07c9b($r10)
sw $r2, 0x07f1b($r10)
sw $r2, 0x0819b($r10)
jr $r31
nop
nop

write_s:
add $r10, $r7, $r6
nop
nop
sw $r2, 0x06d9c($r10)
sw $r2, 0x06d9d($r10)
sw $r2, 0x06d9e($r10)
sw $r2, 0x06d9f($r10)
sw $r2, 0x0701b($r10)
sw $r2, 0x0729b($r10)
sw $r2, 0x0751b($r10)
sw $r2, 0x0779c($r10)
sw $r2, 0x0779d($r10)
sw $r2, 0x0779e($r10)
sw $r2, 0x07a1f($r10)
sw $r2, 0x07c9f($r10)
sw $r2, 0x07f1f($r10)
sw $r2, 0x0819b($r10)
sw $r2, 0x0819c($r10)
sw $r2, 0x0819d($r10)
sw $r2, 0x0819e($r10)
sw $r2, 0x0701c($r10)
sw $r2, 0x0751c($r10)
sw $r2, 0x07a1e($r10)
sw $r2, 0x07f1e($r10)
jr $r31
nop
nop

write_t:
add $r10, $r7, $r6
nop
nop
sw $r2, 0x0701c($r10)
sw $r2, 0x0729c($r10)
sw $r2, 0x0751a($r10)
sw $r2, 0x0751b($r10)
sw $r2, 0x0751c($r10)
sw $r2, 0x0751d($r10)
sw $r2, 0x0751e($r10)
sw $r2, 0x0779c($r10)
sw $r2, 0x07a1c($r10)
sw $r2, 0x07c9c($r10)
sw $r2, 0x07f1c($r10)
sw $r2, 0x0819c($r10)
jr $r31
nop
nop

write_u:
add $r10, $r7, $r6
nop
nop
sw $r2, 0x0751b($r10)
sw $r2, 0x0751f($r10)
sw $r2, 0x0779b($r10)
sw $r2, 0x0779f($r10)
sw $r2, 0x07a1b($r10)
sw $r2, 0x07a1f($r10)
sw $r2, 0x07c9b($r10)
sw $r2, 0x07c9f($r10)
sw $r2, 0x07f1b($r10)
sw $r2, 0x07f1c($r10)
sw $r2, 0x07f1e($r10)
sw $r2, 0x07f1f($r10)
sw $r2, 0x0819c($r10)
sw $r2, 0x0819d($r10)
sw $r2, 0x0819e($r10)
jr $r31
nop
nop

write_v:
add $r10, $r7, $r6
nop
nop
sw $r2, 0x0779a($r10)
sw $r2, 0x0779d($r10)
sw $r2, 0x07a1a($r10)
sw $r2, 0x07a1e($r10)
sw $r2, 0x07c9b($r10)
sw $r2, 0x07c9d($r10)
sw $r2, 0x07f1b($r10)
sw $r2, 0x07f1c($r10)
sw $r2, 0x07f1d($r10)
sw $r2, 0x0819c($r10)
jr $r31
nop
nop

write_w:
add $r10, $r7, $r6
nop
nop
sw $r2, 0x07799($r10)
sw $r2, 0x0779f($r10)
sw $r2, 0x07a19($r10)
sw $r2, 0x07a1f($r10)
sw $r2, 0x07c99($r10)
sw $r2, 0x07c9c($r10)
sw $r2, 0x07cdf($r10)
sw $r2, 0x07f1a($r10)
sw $r2, 0x07f1b($r10)
sw $r2, 0x07f1c($r10)
sw $r2, 0x07f1d($r10)
sw $r2, 0x07f1f($r10)
sw $r2, 0x0819a($r10)
sw $r2, 0x0819e($r10)
jr $r31
nop
nop

write_x:
add $r10, $r7, $r6
nop
nop
sw $r2, 0x06d99($r10)
sw $r2, 0x06d9f($r10)
sw $r2, 0x07019($r10)
sw $r2, 0x0701a($r10)
sw $r2, 0x0701e($r10)
sw $r2, 0x0701f($r10)
sw $r2, 0x0729a($r10)
sw $r2, 0x0729e($r10)
sw $r2, 0x0751b($r10)
sw $r2, 0x0751d($r10)
sw $r2, 0x0779c($r10)
sw $r2, 0x07a1b($r10)
sw $r2, 0x07a1d($r10)
sw $r2, 0x07c9a($r10)
sw $r2, 0x07c9e($r10)
sw $r2, 0x07f1a($r10)
sw $r2, 0x07f1e($r10)
sw $r2, 0x08199($r10)
sw $r2, 0x0819f($r10)
jr $r31
nop
nop

write_y:
add $r10, $r7, $r6
nop
nop
sw $r2, 0x0701a($r10)
sw $r2, 0x0701e($r10)
sw $r2, 0x0701f($r10)
sw $r2, 0x0729a($r10)
sw $r2, 0x0729e($r10)
sw $r2, 0x0729f($r10)
sw $r2, 0x0751a($r10)
sw $r2, 0x0751b($r10)
sw $r2, 0x0751e($r10)
sw $r2, 0x0751f($r10)
sw $r2, 0x0779a($r10)
sw $r2, 0x0779b($r10)
sw $r2, 0x0779c($r10)
sw $r2, 0x0779d($r10)
sw $r2, 0x0779f($r10)
sw $r2, 0x07a1f($r10)
sw $r2, 0x07c9a($r10)
sw $r2, 0x07c9e($r10)
sw $r2, 0x07c9f($r10)
sw $r2, 0x07f1a($r10)
sw $r2, 0x07f1b($r10)
sw $r2, 0x07f1c($r10)
sw $r2, 0x07f1d($r10)
sw $r2, 0x07f1e($r10)
jr $r31
nop
nop

write_z:
add $r10, $r7, $r6
nop
nop
sw $r2, 0x07019($r10)
sw $r2, 0x0701a($r10)
sw $r2, 0x0701b($r10)
sw $r2, 0x0701c($r10)
sw $r2, 0x0701d($r10)
sw $r2, 0x0701e($r10)
sw $r2, 0x0701f($r10)
sw $r2, 0x0729f($r10)
sw $r2, 0x0751d($r10)
sw $r2, 0x0751e($r10)
sw $r2, 0x0751f($r10)
sw $r2, 0x0779c($r10)
sw $r2, 0x0779d($r10)
sw $r2, 0x07a1b($r10)
sw $r2, 0x07a1c($r10)
sw $r2, 0x07c9a($r10)
sw $r2, 0x07c9b($r10)
sw $r2, 0x07f19($r10)
sw $r2, 0x07f1a($r10)
sw $r2, 0x08199($r10)
sw $r2, 0x0819a($r10)
sw $r2, 0x0819b($r10)
sw $r2, 0x0819c($r10)
sw $r2, 0x0819d($r10)
sw $r2, 0x0819e($r10)
sw $r2, 0x0819f($r10)
jr $r31
nop
nop

write_1:
add $r10, $r7, $r6
nop
nop
sw $r2, 0x06d9d($r10)
sw $r2, 0x0701c($r10)
sw $r2, 0x0701d($r10)
sw $r2, 0x0729d($r10)
sw $r2, 0x0751d($r10)
sw $r2, 0x0779d($r10)
sw $r2, 0x07a1d($r10)
sw $r2, 0x07c9d($r10)
sw $r2, 0x07f1c($r10)
sw $r2, 0x07f1d($r10)
sw $r2, 0x0819b($r10)
sw $r2, 0x0819c($r10)
sw $r2, 0x0819d($r10)
sw $r2, 0x0819e($r10)
jr $r31
nop
nop

write_2:
add $r10, $r7, $r6
nop
nop
sw $r2, 0x06d9c($r10)
sw $r2, 0x06d9d($r10)
sw $r2, 0x06d9e($r10)
sw $r2, 0x06d9f($r10)
sw $r2, 0x0701b($r10)
sw $r2, 0x0701c($r10)
sw $r2, 0x0701f($r10)
sw $r2, 0x07020($r10)
sw $r2, 0x0729a($r10)
sw $r2, 0x0729b($r10)
sw $r2, 0x0729f($r10)
sw $r2, 0x072a0($r10)
sw $r2, 0x0751e($r10)
sw $r2, 0x0751f($r10)
sw $r2, 0x0779d($r10)
sw $r2, 0x0779e($r10)
sw $r2, 0x07a1c($r10)
sw $r2, 0x07a1d($r10)
sw $r2, 0x07c9b($r10)
sw $r2, 0x07c9c($r10)
sw $r2, 0x07f1a($r10)
sw $r2, 0x07f1b($r10)
sw $r2, 0x0819a($r10)
sw $r2, 0x0819b($r10)
sw $r2, 0x0819c($r10)
sw $r2, 0x0819d($r10)
sw $r2, 0x0819e($r10)
sw $r2, 0x0819f($r10)
jr $r31
nop
nop

write_3:
add $r10, $r7, $r6
nop
nop
sw $r2, 0x06b1b($r10)
sw $r2, 0x06b1c($r10)
sw $r2, 0x06b1d($r10)
sw $r2, 0x06d9a($r10)
sw $r2, 0x06d9b($r10)
sw $r2, 0x06d9d($r10)
sw $r2, 0x06d9e($r10)
sw $r2, 0x0701e($r10)
sw $r2, 0x0701f($r10)
sw $r2, 0x0729f($r10)
sw $r2, 0x0751c($r10)
sw $r2, 0x0751d($r10)
sw $r2, 0x0751e($r10)
sw $r2, 0x0779c($r10)
sw $r2, 0x0779d($r10)
sw $r2, 0x0779e($r10)
sw $r2, 0x0779f($r10)
sw $r2, 0x07a1f($r10)
sw $r2, 0x07c9f($r10)
sw $r2, 0x07f1a($r10)
sw $r2, 0x07f1b($r10)
sw $r2, 0x07f1e($r10)
sw $r2, 0x0819e($r10)
sw $r2, 0x0819f($r10)
jr $r31
nop
nop

write_4:
add $r10, $r7, $r6
nop
nop
sw $r2, 0x06d9a($r10)
sw $r2, 0x06d9b($r10)
sw $r2, 0x06d9e($r10)
sw $r2, 0x06d9f($r10)
sw $r2, 0x0701a($r10)
sw $r2, 0x0701e($r10)
sw $r2, 0x0729a($r10)
sw $r2, 0x0729e($r10)
sw $r2, 0x0751a($r10)
sw $r2, 0x0751e($r10)
sw $r2, 0x0779a($r10)
sw $r2, 0x0779b($r10)
sw $r2, 0x0779c($r10)
sw $r2, 0x0779d($r10)
sw $r2, 0x0779e($r10)
sw $r2, 0x07a1e($r10)
sw $r2, 0x07c9e($r10)
sw $r2, 0x07f1e($r10)
sw $r2, 0x0819e($r10)
sw $r2, 0x0819f($r10)
jr $r31
nop
nop

write_5:
add $r10, $r7, $r6
nop
nop
sw $r2, 0x06d9a($r10)
sw $r2, 0x06d9b($r10)
sw $r2, 0x06d9c($r10)
sw $r2, 0x06d9d($r10)
sw $r2, 0x06d9e($r10)
sw $r2, 0x06d9f($r10)
sw $r2, 0x0701a($r10)
sw $r2, 0x0729a($r10)
sw $r2, 0x0751a($r10)
sw $r2, 0x0751b($r10)
sw $r2, 0x0751c($r10)
sw $r2, 0x0751d($r10)
sw $r2, 0x0779d($r10)
sw $r2, 0x0779e($r10)
sw $r2, 0x07a1e($r10)
sw $r2, 0x07a1f($r10)
sw $r2, 0x07c9f($r10)
sw $r2, 0x07c9a($r10)
sw $r2, 0x07f1a($r10)
sw $r2, 0x07f1b($r10)
sw $r2, 0x07f1d($r10)
sw $r2, 0x07f1e($r10)
sw $r2, 0x07f1f($r10)
sw $r2, 0x0819b($r10)
sw $r2, 0x0819c($r10)
sw $r2, 0x0819d($r10)
sw $r2, 0x0819e($r10)
jr $r31
nop
nop

write_6: 
add $r10, $r7, $r6
nop
nop
sw $r2, 0x06b1e($r10)
sw $r2, 0x06d9d($r10)
sw $r2, 0x06d9e($r10)
sw $r2, 0x0701c($r10)
sw $r2, 0x0701d($r10)
sw $r2, 0x0729b($r10)
sw $r2, 0x0729c($r10)
sw $r2, 0x0751a($r10)
sw $r2, 0x0751b($r10)
sw $r2, 0x0779a($r10)
sw $r2, 0x0779b($r10)
sw $r2, 0x0779c($r10)
sw $r2, 0x0779d($r10)
sw $r2, 0x0779e($r10)
sw $r2, 0x07a1a($r10)
sw $r2, 0x07a1e($r10)
sw $r2, 0x07a1f($r10)
sw $r2, 0x07c9a($r10)
sw $r2, 0x07c9f($r10)
sw $r2, 0x07f1a($r10)
sw $r2, 0x07f1b($r10)
sw $r2, 0x07f1e($r10)
sw $r2, 0x07f1f($r10)
sw $r2, 0x0819b($r10)
sw $r2, 0x0819c($r10)
sw $r2, 0x0819d($r10)
sw $r2, 0x0819e($r10)
jr $r31
nop
nop

write_7:
add $r10, $r7, $r6
nop
nop
sw $r2, 0x06d9a($r10)
sw $r2, 0x06d9b($r10)
sw $r2, 0x06d9c($r10)
sw $r2, 0x06d9d($r10)
sw $r2, 0x06d9e($r10)
sw $r2, 0x06d9f($r10)
sw $r2, 0x0701f($r10)
sw $r2, 0x0729e($r10)
sw $r2, 0x0729f($r10)
sw $r2, 0x0751d($r10)
sw $r2, 0x0751e($r10)
sw $r2, 0x0779c($r10)
sw $r2, 0x0779d($r10)
sw $r2, 0x07a1b($r10)
sw $r2, 0x07a1c($r10)
sw $r2, 0x07c9a($r10)
sw $r2, 0x07cdb($r10)
sw $r2, 0x07f1a($r10)
sw $r2, 0x0819a($r10)
jr $r31
nop
nop

write_8:
add $r10, $r7, $r6
nop
nop
sw $r2, 0x06d9b($r10)
sw $r2, 0x06d9c($r10)
sw $r2, 0x06d9d($r10)
sw $r2, 0x06d9e($r10)
sw $r2, 0x0701a($r10)
sw $r2, 0x0701f($r10)
sw $r2, 0x0729a($r10)
sw $r2, 0x0729b($r10)
sw $r2, 0x0729e($r10)
sw $r2, 0x0729f($r10)
sw $r2, 0x0751b($r10)
sw $r2, 0x0751c($r10)
sw $r2, 0x0751d($r10)
sw $r2, 0x0751e($r10)
sw $r2, 0x0779a($r10)
sw $r2, 0x0779b($r10)
sw $r2, 0x0779e($r10)
sw $r2, 0x0779f($r10)
sw $r2, 0x07a1a($r10)
sw $r2, 0x07a1f($r10)
sw $r2, 0x07c9a($r10)
sw $r2, 0x07c9f($r10)
sw $r2, 0x07f1a($r10)
sw $r2, 0x07f1b($r10)
sw $r2, 0x07f1e($r10)
sw $r2, 0x07f1f($r10)
sw $r2, 0x0819b($r10)
sw $r2, 0x0819c($r10)
sw $r2, 0x0819d($r10)
sw $r2, 0x0819e($r10)
jr $r31
nop
nop

write_9:
add $r10, $r7, $r6
nop
nop
sw $r2, 0x06d9b($r10)
sw $r2, 0x06d9c($r10)
sw $r2, 0x06d9d($r10)
sw $r2, 0x06d9e($r10)
sw $r2, 0x06d9f($r10)
sw $r2, 0x0701a($r10)
sw $r2, 0x0701f($r10)
sw $r2, 0x0729a($r10)
sw $r2, 0x0729b($r10)
sw $r2, 0x0729e($r10)
sw $r2, 0x0729f($r10)
sw $r2, 0x0751b($r10)
sw $r2, 0x0751c($r10)
sw $r2, 0x0751d($r10)
sw $r2, 0x0751e($r10)
sw $r2, 0x0751f($r10)
sw $r2, 0x0779f($r10)
sw $r2, 0x07a1f($r10)
sw $r2, 0x07c9f($r10)
sw $r2, 0x07f1f($r10)
sw $r2, 0x0819f($r10)
jr $r31
nop
nop


exit:
.data
a: .word 0x0000001C
b: .word 0x00000032
c: .word 0x00000021
d: .word 0x00000023
e: .word 0x00000024
f: .word 0x0000002B
g: .word 0x00000034
h: .word 0x00000033
i: .word 0x00000043
j: .word 0x0000003B
k: .word 0x00000042
l: .word 0x0000004B
m: .word 0x0000003A
n: .word 0x00000031
o: .word 0x00000044
p: .word 0x0000004D
q: .word 0x00000015
r: .word 0x0000002D
s: .word 0x0000001B
t: .word 0x0000002C
u: .word 0x0000003C
v: .word 0x0000002A
w: .word 0x0000001D
x: .word 0x00000022
y: .word 0x00000035
z: .word 0x0000001A
zero: .word 0x00000045
one: .word 0x00000016
two: .word 0x0000001E
three: .word 0x00000026
four: .word 0x00000025
five: .word 0x0000002E
six: .word 0x00000036
seven: .word 0x0000003D
eight: .word 0x0000003E
nine: .word 0x00000046
bignum: .word 0x00400031









