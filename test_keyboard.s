##--------------------------------------------Register Definition-------------------------------------------##
## $r0 = 0
## $r1 = 1 always
## $r2: will hold the length of the word
## $r3: loop counter for each character of word (i)
## $r4 is the temporary register where you check input against data
## $r5 is the temporary register where you load letters
## $r6: register where you store address for writing vga
## $r7: address offset in the write loop
## $r30: where the input from keyboard ends up

.text
main:
addi $r1, $r0, 1
add $r6, $r0, $r0    #initialize r6 (starting address) to 0 for now

loop:
jal wait_for_input
nop
nop

add $r4, $r0, $r30    #Move inputted character to register 4
add $r30, $r0, $r0    #Set input register back to 0
jal render_character  #Go to render character method, r4 has character
nop
nop
addi $r7, $r7, 12     #increment 12 to the right


bne $r1, $r0, loop    #infinite loop

#--------------------------Wait for input ---------------------#
wait_for_input:
nop
nop
bne $r30, $r0, input_ready
nop
j wait_for_input     #loop back and wait if still equal

input_ready:
jr $r31              #go back and render input
nop


#--------------------------Render stuff -------------------------#
render_character:
lw $r5, 0($r0)       #load A
nop
nop
bne $r5, $r4, check_b #this letter is not A
nop
j write_a
nop
nop

check_b:
lw $r5, 1($r0)       #load B
nop
nop
bne $r5, $r4, check_c
nop
j write_b
nop
nop

check_c:
lw $r5, 2($r0)        #load C
nop
nop
bne $r5, $r4, check_d
nop
j write_c
nop
nop


check_d:
lw $r5, 3($r0)        #load D
nop
nop
bne $r5, $r4, check_e
nop
j write_d
nop
nop

check_e:
lw $r5, 4($r0)        #load E
nop
nop
bne $r5, $r4, check_f
nop
j write_e
nop
nop


check_f:
lw $r5, 5($r0)        #load F
nop
nop
bne $r5, $r4, check_g
nop
j write_f
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

check_h:
lw $r5, 7($r0)        #load H
nop
nop
bne $r5, $r4, check_i
nop
j write_h

check_i:
lw $r5, 8($r0)        #load I
nop
nop
bne $r5, $r4, check_j
nop
j write_i
nop
nop

check_j:
lw $r5, 9($r0)        #load J
nop
nop
bne $r5, $r4, check_k
nop
nop
j write_j
nop
nop

check_k:
lw $r5, 10($r0)        #load K
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
bne $r5, $r4, check_m
nop
j write_l
nop
nop

check_m:
lw $r5, 12($r0)        #load m
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
bne $r5, $r4, check_o
nop
j write_n
nop
nop

check_o:
lw $r5, 14($r0)        #load o
nop
nop
bne $r5, $r4, check_p
nop
j write_o
nop
nop

check_p:
lw $r5, 15($r0)        #load p
nop
nop
bne $r5, $r4, check_q
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
j write_q
nop
nop

check_r:
lw $r5, 17($r0)        #load r
nop
nop
bne $r5, $r4, check_s
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
j write_s
nop
nop

check_t:
lw $r5, 19($r0)        #load t
nop
nop
bne $r5, $r4, check_u
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
j write_u
nop
nop

check_v:
lw $r5, 21($r0)        #load v
nop
nop
bne $r5, $r4, check_w
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
j write_w
nop
nop

check_x:
lw $r5, 23($r0)        #load x
nop
nop
bne $r5, $r4, check_y
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
j write_y
nop
nop

check_z:
lw $r5, 25($r0)        #load z
nop
nop
bne $r5, $r4, check_0
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
j write_o
nop
nop

check_1:
lw $r5, 27($r0)        #load 1
nop
nop
bne $r5, $r4, check_2
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
j write_3
nop
nop

check_7:
lw $r5, 33($r0)        #load 7
nop
nop
bne $r5, $r4, check_8
nop
j write_3
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
add $r6, $r7, $r6      #create it in the proper place
nop
sw $r1, 0x06b1c($r6)
sw $r1, 0x06b1d($r6)
sw $r1, 0x06b1e($r6)
sw $r1, 0x06b1f($r6)
sw $r1, 0x06d9b($r6)
sw $r1, 0x06d9c($r6)
sw $r1, 0x06d9d($r6)
sw $r1, 0x06d9e($r6)
sw $r1, 0x06d9f($r6)
sw $r1, 0x06da0($r6)
sw $r1, 0x0701a($r6)
sw $r1, 0x0701b($r6)
sw $r1, 0x07020($r6)
sw $r1, 0x072a0($r6)
sw $r1, 0x0751b($r6)
sw $r1, 0x0751c($r6)
sw $r1, 0x0751d($r6)
sw $r1, 0x0751e($r6)
sw $r1, 0x0751f($r6)
sw $r1, 0x07520($r6)
sw $r1, 0x0751a($r6)
sw $r1, 0x0779a($r6)
sw $r1, 0x077a0($r6)
sw $r1, 0x07a19($r6)
sw $r1, 0x07a1a($r6)
sw $r1, 0x07a20($r6)
sw $r1, 0x07c99($r6)
sw $r1, 0x07c9a($r6)
sw $r1, 0x07ca0($r6)
sw $r1, 0x07f19($r6)
sw $r1, 0x07f1a($r6)
sw $r1, 0x07f1e($r6)
sw $r1, 0x07f1f($r6)
sw $r1, 0x07f20($r6)
sw $r1, 0x0819a($r6)
sw $r1, 0x0819b($r6)
sw $r1, 0x0819c($r6)
sw $r1, 0x0819d($r6)
sw $r1, 0x0819e($r6)
sw $r1, 0x0819f($r6)
sw $r1, 0x081a0($r6)
jr $r31                  #go back to render_character
nop
nop

write_b:
add $r6, $r7, $r6
nop
sw $r1, 0x06b1b($r6)
sw $r1, 0x06d9b($r6)
sw $r1, 0x0701b($r6)
sw $r1, 0x0729b($r6)
sw $r1, 0x0751b($r6)
sw $r1, 0x0779b($r6)
sw $r1, 0x0779c($r6)
sw $r1, 0x0779d($r6)
sw $r1, 0x0779e($r6)
sw $r1, 0x0779f($r6)
sw $r1, 0x07a1b($r6)
sw $r1, 0x07a1f($r6)
sw $r1, 0x07a20($r6)
sw $r1, 0x07c9b($r6)
sw $r1, 0x07c9f($r6)
sw $r1, 0x07ca0($r6)
sw $r1, 0x07f1b($r6)
sw $r1, 0x07f1f($r6)
sw $r1, 0x07f20($r6)
sw $r1, 0x0719b($r6)
sw $r1, 0x0719c($r6)
sw $r1, 0x0719d($r6)
sw $r1, 0x0719e($r6)
sw $r1, 0x0719f($r6)
sw $r1, 0x071a1($r6)
jr $r31
nop
nop

write_c:
add $r6, $r7, $r6
nop
sw $r1, 0x0751b($r6)
sw $r1, 0x0751c($r6)
sw $r1, 0x0751d($r6)
sw $r1, 0x0779a($r6)
sw $r1, 0x0779b($r6)
sw $r1, 0x07a1a($r6)
sw $r1, 0x07c9a($r6)
sw $r1, 0x07f1a($r6)
sw $r1, 0x07f1b($r6)
sw $r1, 0x0819a($r6)
sw $r1, 0x0819b($r6)
sw $r1, 0x0819c($r6)
sw $r1, 0x0819d($r6)
jr $r31
nop
nop

write_d:
add $r6, $r7, $r6
nop
sw $r1, 0x06b1e($r6)
sw $r1, 0x06d9c($r6)
sw $r1, 0x0701e($r6)
sw $r1, 0x0729e($r6)
sw $r1, 0x0751e($r6)
sw $r1, 0x0779a($r6)
sw $r1, 0x0779b($r6)
sw $r1, 0x0779c($r6)
sw $r1, 0x0779d($r6)
sw $r1, 0x0779e($r6)
sw $r1, 0x07a19($r6)
sw $r1, 0x07a1a($r6)
sw $r1, 0x07a1e($r6)
sw $r1, 0x07c99($r6)
sw $r1, 0x07c9e($r6)
sw $r1, 0x07f19($r6)
sw $r1, 0x07f1a($r6)
sw $r1, 0x07f1e($r6)
sw $r1, 0x08199($r6)
sw $r1, 0x0819a($r6)
sw $r1, 0x0819b($r6)
sw $r1, 0x0819c($r6)
sw $r1, 0x0819d($r6)
sw $r1, 0x0819e($r6)
jr $r31
nop
nop

write_e:
add $r6, $r7, $r6
nop
sw $r1, 0x0729c($r6)
sw $r1, 0x0729d($r6)
sw $r1, 0x0729e($r6)
sw $r1, 0x0751b($r6)
sw $r1, 0x0751f($r6)
sw $r1, 0x0779b($r6)
sw $r1, 0x0779c($r6)
sw $r1, 0x0779d($r6)
sw $r1, 0x0779e($r6)
sw $r1, 0x0779f($r6)
sw $r1, 0x07a1b($r6)
sw $r1, 0x07c9b($r6)
sw $r1, 0x07c9c($r6)
sw $r1, 0x07f1b($r6)
sw $r1, 0x07f1c($r6)
sw $r1, 0x07f1d($r6)
sw $r1, 0x07f1e($r6)
sw $r1, 0x07f1f($r6)
jr $r31
nop
nop

write_f:
add $r6, $r7, $r6
nop
sw $r1, 0x06b1b($r6)
sw $r1, 0x06b1c($r6)
sw $r1, 0x06b1d($r6)
sw $r1, 0x06d9b($r6)
sw $r1, 0x06d9d($r6)
sw $r1, 0x06d9e($r6)
sw $r1, 0x0701b($r6)
sw $r1, 0x0701e($r6)
sw $r1, 0x0729b($r6)
sw $r1, 0x0729e($r6)
sw $r1, 0x0751b($r6)
sw $r1, 0x0779a($r6)
sw $r1, 0x0779b($r6)
sw $r1, 0x0779c($r6)
sw $r1, 0x0779d($r6)
sw $r1, 0x0779e($r6)
sw $r1, 0x07a1b($r6)
sw $r1, 0x07c9b($r6)
sw $r1, 0x07f1b($r6)
sw $r1, 0x0819b($r6)
jr $r31
nop
nop

write_g:
add $r6, $r7, $r6
nop
sw $r1, 0x0729c($r6)
sw $r1, 0x0729d($r6)
sw $r1, 0x0729e($r6)
sw $r1, 0x0729f($r6)
sw $r1, 0x0751b($r6)
sw $r1, 0x0751f($r6)
sw $r1, 0x0779b($r6)
sw $r1, 0x0779f($r6)
sw $r1, 0x07a1b($r6)
sw $r1, 0x07a1c($r6)
sw $r1, 0x07a1d($r6)
sw $r1, 0x07a1e($r6)
sw $r1, 0x07a1f($r6)
sw $r1, 0x07c9f($r6)
sw $r1, 0x07f1f($r6)
sw $r1, 0x0819b($r6)
sw $r1, 0x0819c($r6)
sw $r1, 0x0819d($r6)
sw $r1, 0x0819e($r6)
sw $r1, 0x0819f($r6)
jr $r31
nop
nop

write_h:
add $r6, $r7, $r6
nop
sw $r1, 0x06b1b($r6)
sw $r1, 0x06d9b($r6)
sw $r1, 0x0701b($r6)
sw $r1, 0x0729b($r6)
sw $r1, 0x0751b($r6)
sw $r1, 0x0779b($r6)
sw $r1, 0x0779d($r6)
sw $r1, 0x0779e($r6)
sw $r1, 0x07a1b($r6)
sw $r1, 0x07a1c($r6)
sw $r1, 0x07a1d($r6)
sw $r1, 0x07a1e($r6)
sw $r1, 0x07a1f($r6)
sw $r1, 0x07c9b($r6)
sw $r1, 0x07c9f($r6)
sw $r1, 0x07f1b($r6)
sw $r1, 0x07f1f($r6)
sw $r1, 0x0819b($r6)
sw $r1, 0x0819f($r6)
jr $r31
nop
nop

write_i:
add $r6, $r7, $r6
nop
sw $r1, 0x06b1c($r6)
sw $r1, 0x06b1d($r6)
sw $r1, 0x06d9c($r6)
sw $r1, 0x06d9d($r6)
sw $r1, 0x0729d($r6)
sw $r1, 0x0751c($r6)
sw $r1, 0x0751d($r6)
sw $r1, 0x0779d($r6)
sw $r1, 0x07a1d($r6)
sw $r1, 0x07c9d($r6)
sw $r1, 0x07f1d($r6)
sw $r1, 0x0819e($r6)
sw $r1, 0x0819d($r6)
sw $r1, 0x0819e($r6)
jr $r31
nop
nop

write_j:
add $r6, $r7, $r6
sw $r1, 0x06b1c($r6)
sw $r1, 0x06b1d($r6)
sw $r1, 0x06d9c($r6)
sw $r1, 0x06d9d($r6)
sw $r1, 0x0729d($r6)
sw $r1, 0x0751c($r6)
sw $r1, 0x0751d($r6)
sw $r1, 0x0779d($r6)
sw $r1, 0x07a1d($r6)
sw $r1, 0x07c9a($r6)
sw $r1, 0x07c9d($r6)
sw $r1, 0x07f1a($r6)
sw $r1, 0x07f1c($r6)
sw $r1, 0x07f1d($r6)
sw $r1, 0x0819a($r6)
sw $r1, 0x0819b($r6)
sw $r1, 0x0819c($r6)
sw $r1, 0x0819d($r6)
jr $r31
nop
nop

write_k:
add $r6, $r7, $r6
nop
nop
sw $r1, 0x06b1b($r6)
sw $r1, 0x06d9b($r6)
sw $r1, 0x0701b($r6)
sw $r1, 0x0729b($r6)
sw $r1, 0x0729e($r6)
sw $r1, 0x0751b($r6)
sw $r1, 0x0751d($r6)
sw $r1, 0x0751e($r6)
sw $r1, 0x0779b($r6)
sw $r1, 0x0779c($r6)
sw $r1, 0x0779d($r6)
sw $r1, 0x07a1b($r6)
sw $r1, 0x07a1c($r6)
sw $r1, 0x07c9b($r6)
sw $r1, 0x07c9c($r6)
sw $r1, 0x07c9d($r6)
sw $r1, 0x07f1b($r6)
sw $r1, 0x07f1d($r6)
sw $r1, 0x07f1e($r6)
sw $r1, 0x0819b($r6)
sw $r1, 0x0819e($r6)
jr $r31
nop
nop

write_l:
add $r6, $r7, $r6
nop
nop
sw $r1, 0x06b1b($r6)
sw $r1, 0x06b1c($r6)
sw $r1, 0x06d9c($r6)
sw $r1, 0x0701c($r6)
sw $r1, 0x0729c($r6)
sw $r1, 0x0751c($r6)
sw $r1, 0x0779c($r6)
sw $r1, 0x07a1c($r6)
sw $r1, 0x07c9c($r6)
sw $r1, 0x07f1c($r6)
sw $r1, 0x0819b($r6)
sw $r1, 0x0819c($r6)
sw $r1, 0x0819d($r6)
jr $r31
nop
nop

write_m:
add $r6, $r7, $r6
nop
nop
sw $r1, 0x07019($r6)
sw $r1, 0x07298($r6)
sw $r1, 0x07299($r6)
sw $r1, 0x0729a($r6)
sw $r1, 0x0729b($r6)
sw $r1, 0x0729c($r6)
sw $r1, 0x0729d($r6)
sw $r1, 0x0729e($r6)
sw $r1, 0x0729f($r6)
sw $r1, 0x072a0($r6)
sw $r1, 0x07519($r6)
sw $r1, 0x0751a($r6)
sw $r1, 0x0751c($r6)
sw $r1, 0x0751d($r6)
sw $r1, 0x0751f($r6)
sw $r1, 0x07520($r6)
sw $r1, 0x07799($r6)
sw $r1, 0x07a19($r6)
sw $r1, 0x07c99($r6)
sw $r1, 0x07f19($r6)
sw $r1, 0x08199($r6)
sw $r1, 0x0779c($r6)
sw $r1, 0x07a1c($r6)
sw $r1, 0x07c9c($r6)
sw $r1, 0x07f1c($r6)
sw $r1, 0x0819c($r6)
sw $r1, 0x077a0($r6)
sw $r1, 0x07a20($r6)
sw $r1, 0x07ca0($r6)
sw $r1, 0x07f20($r6)
sw $r1, 0x081a0($r6)
jr $r31
nop
nop

write_n:
add $r6, $r7, $r6
nop
nop
sw $r1, 0x0701b($r6)
sw $r1, 0x0729a($r6)
sw $r1, 0x0729b($r6)
sw $r1, 0x0729d($r6)
sw $r1, 0x0729e($r6)
sw $r1, 0x0729f($r6)
sw $r1, 0x0751b($r6)
sw $r1, 0x0751c($r6)
sw $r1, 0x0751d($r6)
sw $r1, 0x0751e($r6)
sw $r1, 0x0751f($r6)
sw $r1, 0x07520($r6)
sw $r1, 0x0779b($r6)
sw $r1, 0x07a1b($r6)
sw $r1, 0x07c9b($r6)
sw $r1, 0x07f1b($r6)
sw $r1, 0x0819b($r6)
sw $r1, 0x077a0($r6)
sw $r1, 0x07a20($r6)
sw $r1, 0x07ca0($r6)
sw $r1, 0x07f20($r6)
sw $r1, 0x081a0($r6)
jr $r31
nop
nop

write_o:
add $r6, $r7, $r6
nop
nop
sw $r1, 0x06d9a($r6)
sw $r1, 0x06d9b($r6)
sw $r1, 0x06d9c($r6)
sw $r1, 0x06d9d($r6)
sw $r1, 0x06d9e($r6)
sw $r1, 0x06d9f($r6)
sw $r1, 0x07019($r6)
sw $r1, 0x0701a($r6)
sw $r1, 0x0701b($r6)
sw $r1, 0x0701e($r6)
sw $r1, 0x0701f($r6)
sw $r1, 0x07020($r6)
sw $r1, 0x07299($r6)
sw $r1, 0x072a0($r6)
sw $r1, 0x07518($r6)
sw $r1, 0x07519($r6)
sw $r1, 0x07520($r6)
sw $r1, 0x07521($r6)
sw $r1, 0x07798($r6)
sw $r1, 0x07799($r6)
sw $r1, 0x077a0($r6)
sw $r1, 0x077a1($r6)
sw $r1, 0x07a18($r6)
sw $r1, 0x07a19($r6)
sw $r1, 0x07a20($r6)
sw $r1, 0x07a21($r6)
sw $r1, 0x07c99($r6)
sw $r1, 0x07ca0($r6)
sw $r1, 0x07f19($r6)
sw $r1, 0x07f1a($r6)
sw $r1, 0x07f1e($r6)
sw $r1, 0x07f1f($r6)
sw $r1, 0x0819a($r6)
sw $r1, 0x0819b($r6)
sw $r1, 0x0819d($r6)
sw $r1, 0x0819e($r6)
sw $r1, 0x0819f($r6)
jr $r31
nop
nop

write_p:
add $r6, $r7, $r6
nop
nop
sw $r1, 0x06d9b($r6)
sw $r1, 0x06d9c($r6)
sw $r1, 0x06d9d($r6)
sw $r1, 0x06d9e($r6)
sw $r1, 0x06d9f($r6)
sw $r1, 0x0701b($r6)
sw $r1, 0x0701f($r6)
sw $r1, 0x0729b($r6)
sw $r1, 0x0729f($r6)
sw $r1, 0x0751b($r6)
sw $r1, 0x0751e($r6)
sw $r1, 0x0751f($r6)
sw $r1, 0x0779b($r6)
sw $r1, 0x0779c($r6)
sw $r1, 0x0779d($r6)
sw $r1, 0x0779e($r6)
sw $r1, 0x07a1b($r6)
sw $r1, 0x07c9b($r6)
sw $r1, 0x07f1b($r6)
sw $r1, 0x0819b($r6)
jr $r31
nop
nop

write_q:
add $r6, $r7, $r6
nop
nop
sw $r1, 0x06d9b($r6)
sw $r1, 0x06d9c($r6)
sw $r1, 0x06d9f($r6)
sw $r1, 0x0701b($r6)
sw $r1, 0x0701f($r6)
sw $r1, 0x0729b($r6)
sw $r1, 0x0729f($r6)
sw $r1, 0x0751b($r6)
sw $r1, 0x0751c($r6)
sw $r1, 0x0751f($r6)
sw $r1, 0x0779c($r6)
sw $r1, 0x0779d($r6)
sw $r1, 0x0779e($r6)
sw $r1, 0x0779f($r6)
sw $r1, 0x07a1f($r6)
sw $r1, 0x07c9f($r6)
sw $r1, 0x07f1f($r6)
sw $r1, 0x0819f($r6)
sw $r1, 0x081a0($r6)
jr $r31
nop
nop

write_r:
add $r6, $r7, $r6
nop
nop
sw $r1, 0x0701b($r6)
sw $r1, 0x0701d($r6)
sw $r1, 0x0701e($r6)
sw $r1, 0x0729b($r6)
sw $r1, 0x0729c($r6)
sw $r1, 0x0729d($r6)
sw $r1, 0x0729e($r6)
sw $r1, 0x0729f($r6)
sw $r1, 0x0751b($r6)
sw $r1, 0x0751c($r6)
sw $r1, 0x0751f($r6)
sw $r1, 0x0779b($r6)
sw $r1, 0x07a1b($r6)
sw $r1, 0x07c9b($r6)
sw $r1, 0x07f1b($r6)
sw $r1, 0x0819b($r6)
jr $r31
nop
nop

write_s:
add $r6, $r7, $r6
nop
nop
sw $r1, 0x06d9c($r6)
sw $r1, 0x06d9d($r6)
sw $r1, 0x06d9e($r6)
sw $r1, 0x06d9f($r6)
sw $r1, 0x0701b($r6)
sw $r1, 0x0729b($r6)
sw $r1, 0x0751b($r6)
sw $r1, 0x0779c($r6)
sw $r1, 0x0779d($r6)
sw $r1, 0x0779e($r6)
sw $r1, 0x07a1f($r6)
sw $r1, 0x07c9f($r6)
sw $r1, 0x07f1f($r6)
sw $r1, 0x0819b($r6)
sw $r1, 0x0819c($r6)
sw $r1, 0x0819d($r6)
sw $r1, 0x0819e($r6)
sw $r1, 0x0701c($r6)
sw $r1, 0x0751c($r6)
sw $r1, 0x07a1e($r6)
sw $r1, 0x07f1e($r6)
jr $r31
nop
nop

write_t:
add $r6, $r7, $r6
nop
nop
sw $r1, 0x0701c($r6)
sw $r1, 0x0729c($r6)
sw $r1, 0x0751a($r6)
sw $r1, 0x0751b($r6)
sw $r1, 0x0751c($r6)
sw $r1, 0x0751d($r6)
sw $r1, 0x0751e($r6)
sw $r1, 0x0779c($r6)
sw $r1, 0x07a1c($r6)
sw $r1, 0x07c9c($r6)
sw $r1, 0x07f1c($r6)
sw $r1, 0x0819c($r6)
jr $r31
nop
nop

write_u:
add $r6, $r7, $r6
nop
nop
sw $r1, 0x0751b($r6)
sw $r1, 0x0751f($r6)
sw $r1, 0x0779b($r6)
sw $r1, 0x0779f($r6)
sw $r1, 0x07a1b($r6)
sw $r1, 0x07a1f($r6)
sw $r1, 0x07c9b($r6)
sw $r1, 0x07c9f($r6)
sw $r1, 0x07f1b($r6)
sw $r1, 0x07f1c($r6)
sw $r1, 0x07f1e($r6)
sw $r1, 0x07f1f($r6)
sw $r1, 0x0819c($r6)
sw $r1, 0x0819d($r6)
sw $r1, 0x0819e($r6)
jr $r31
nop
nop

write_v:
add $r6, $r7, $r6
nop
nop
sw $r1, 0x0779a($r6)
sw $r1, 0x0779d($r6)
sw $r1, 0x07a1a($r6)
sw $r1, 0x07a1e($r6)
sw $r1, 0x07c9b($r6)
sw $r1, 0x07c9d($r6)
sw $r1, 0x07f1b($r6)
sw $r1, 0x07f1c($r6)
sw $r1, 0x07f1d($r6)
sw $r1, 0x0819c($r6)
jr $r31
nop
nop

write_w:
add $r6, $r7, $r6
nop
nop
sw $r1, 0x07799($r6)
sw $r1, 0x0779f($r6)
sw $r1, 0x07a19($r6)
sw $r1, 0x07a1f($r6)
sw $r1, 0x07c99($r6)
sw $r1, 0x07c9c($r6)
sw $r1, 0x07cdf($r6)
sw $r1, 0x07f1a($r6)
sw $r1, 0x07f1b($r6)
sw $r1, 0x07f1c($r6)
sw $r1, 0x07f1d($r6)
sw $r1, 0x07f1f($r6)
sw $r1, 0x0819a($r6)
sw $r1, 0x0819e($r6)
jr $r31
nop
nop

write_x:
add $r6, $r7, $r6
nop
nop
sw $r1, 0x06d99($r6)
sw $r1, 0x06d9f($r6)
sw $r1, 0x07019($r6)
sw $r1, 0x0701a($r6)
sw $r1, 0x0701e($r6)
sw $r1, 0x0701f($r6)
sw $r1, 0x0729a($r6)
sw $r1, 0x0729e($r6)
sw $r1, 0x0751b($r6)
sw $r1, 0x0751d($r6)
sw $r1, 0x0779c($r6)
sw $r1, 0x07a1b($r6)
sw $r1, 0x07a1d($r6)
sw $r1, 0x07c9a($r6)
sw $r1, 0x07c9e($r6)
sw $r1, 0x07f1a($r6)
sw $r1, 0x07f1e($r6)
sw $r1, 0x08199($r6)
sw $r1, 0x0819f($r6)
jr $r31
nop
nop

write_y:
add $r6, $r7, $r6
nop
nop
sw $r1, 0x0701a($r6)
sw $r1, 0x0701e($r6)
sw $r1, 0x0701f($r6)
sw $r1, 0x0729a($r6)
sw $r1, 0x0729e($r6)
sw $r1, 0x0729f($r6)
sw $r1, 0x0751a($r6)
sw $r1, 0x0751b($r6)
sw $r1, 0x0751e($r6)
sw $r1, 0x0751f($r6)
sw $r1, 0x0779a($r6)
sw $r1, 0x0779b($r6)
sw $r1, 0x0779c($r6)
sw $r1, 0x0779d($r6)
sw $r1, 0x0779f($r6)
sw $r1, 0x07a1f($r6)
sw $r1, 0x07c9a($r6)
sw $r1, 0x07c9e($r6)
sw $r1, 0x07c9f($r6)
sw $r1, 0x07f1a($r6)
sw $r1, 0x07f1b($r6)
sw $r1, 0x07f1c($r6)
sw $r1, 0x07f1d($r6)
sw $r1, 0x07f1e($r6)
jr $r31
nop
nop

write_z:
add $r6, $r7, $r6
nop
nop
sw $r1, 0x07019($r6)
sw $r1, 0x0701a($r6)
sw $r1, 0x0701b($r6)
sw $r1, 0x0701c($r6)
sw $r1, 0x0701d($r6)
sw $r1, 0x0701e($r6)
sw $r1, 0x0701f($r6)
sw $r1, 0x0729f($r6)
sw $r1, 0x0751d($r6)
sw $r1, 0x0751e($r6)
sw $r1, 0x0751f($r6)
sw $r1, 0x0779c($r6)
sw $r1, 0x0779d($r6)
sw $r1, 0x07a1b($r6)
sw $r1, 0x07a1c($r6)
sw $r1, 0x07c9a($r6)
sw $r1, 0x07c9b($r6)
sw $r1, 0x07f19($r6)
sw $r1, 0x07f1a($r6)
sw $r1, 0x08199($r6)
sw $r1, 0x0819a($r6)
sw $r1, 0x0819b($r6)
sw $r1, 0x0819c($r6)
sw $r1, 0x0819d($r6)
sw $r1, 0x0819e($r6)
sw $r1, 0x0819f($r6)
jr $r31
nop
nop

write_1:
add $r6, $r7, $r6
nop
nop
sw $r1, 0x06d9d($r6)
sw $r1, 0x0701c($r6)
sw $r1, 0x0701d($r6)
sw $r1, 0x0729d($r6)
sw $r1, 0x0751d($r6)
sw $r1, 0x0779d($r6)
sw $r1, 0x07a1d($r6)
sw $r1, 0x07c9d($r6)
sw $r1, 0x07f1c($r6)
sw $r1, 0x07f1d($r6)
sw $r1, 0x0819b($r6)
sw $r1, 0x0819c($r6)
sw $r1, 0x0819d($r6)
sw $r1, 0x0819e($r6)
jr $r31
nop
nop

write_2:
add $r6, $r7, $r6
nop
nop
sw $r1, 0x06d9c($r6)
sw $r1, 0x06d9d($r6)
sw $r1, 0x06d9e($r6)
sw $r1, 0x06d9f($r6)
sw $r1, 0x0701b($r6)
sw $r1, 0x0701c($r6)
sw $r1, 0x0701f($r6)
sw $r1, 0x07020($r6)
sw $r1, 0x0729a($r6)
sw $r1, 0x0729b($r6)
sw $r1, 0x0729f($r6)
sw $r1, 0x072a0($r6)
sw $r1, 0x0751e($r6)
sw $r1, 0x0751f($r6)
sw $r1, 0x0779d($r6)
sw $r1, 0x0779e($r6)
sw $r1, 0x07a1c($r6)
sw $r1, 0x07a1d($r6)
sw $r1, 0x07c9b($r6)
sw $r1, 0x07c9c($r6)
sw $r1, 0x07f1a($r6)
sw $r1, 0x07f1b($r6)
sw $r1, 0x0819a($r6)
sw $r1, 0x0819b($r6)
sw $r1, 0x0819c($r6)
sw $r1, 0x0819d($r6)
sw $r1, 0x0819e($r6)
sw $r1, 0x0819f($r6)
jr $r31
nop
nop

write_3:
add $r6, $r7, $r6
nop
nop
sw $r1, 0x06b1b($r6)
sw $r1, 0x06b1c($r6)
sw $r1, 0x06b1d($r6)
sw $r1, 0x06d9a($r6)
sw $r1, 0x06d9b($r6)
sw $r1, 0x06d9d($r6)
sw $r1, 0x06d9e($r6)
sw $r1, 0x0701e($r6)
sw $r1, 0x0701f($r6)
sw $r1, 0x0729f($r6)
sw $r1, 0x0751c($r6)
sw $r1, 0x0751d($r6)
sw $r1, 0x0751e($r6)
sw $r1, 0x0779c($r6)
sw $r1, 0x0779d($r6)
sw $r1, 0x0779e($r6)
sw $r1, 0x0779f($r6)
sw $r1, 0x07a1f($r6)
sw $r1, 0x07c9f($r6)
sw $r1, 0x07f1a($r6)
sw $r1, 0x07f1b($r6)
sw $r1, 0x07f1e($r6)
sw $r1, 0x0819e($r6)
sw $r1, 0x0819f($r6)
jr $r31
nop
nop

write_4:
add $r6, $r7, $r6
nop
nop
sw $r1, 0x06d9a($r6)
sw $r1, 0x06d9b($r6)
sw $r1, 0x06d9e($r6)
sw $r1, 0x06d9f($r6)
sw $r1, 0x0701a($r6)
sw $r1, 0x0701e($r6)
sw $r1, 0x0729a($r6)
sw $r1, 0x0729e($r6)
sw $r1, 0x0751a($r6)
sw $r1, 0x0751e($r6)
sw $r1, 0x0779a($r6)
sw $r1, 0x0779b($r6)
sw $r1, 0x0779c($r6)
sw $r1, 0x0779d($r6)
sw $r1, 0x0779e($r6)
sw $r1, 0x07a1e($r6)
sw $r1, 0x07c9e($r6)
sw $r1, 0x07f1e($r6)
sw $r1, 0x0819e($r6)
sw $r1, 0x0819f($r6)
jr $r31
nop
nop

write_5:
add $r6, $r7, $r6
nop
nop
sw $r1, 0x06d9a($r6)
sw $r1, 0x06d9b($r6)
sw $r1, 0x06d9c($r6)
sw $r1, 0x06d9d($r6)
sw $r1, 0x06d9e($r6)
sw $r1, 0x06d9f($r6)
sw $r1, 0x0701a($r6)
sw $r1, 0x0729a($r6)
sw $r1, 0x0751a($r6)
sw $r1, 0x0751b($r6)
sw $r1, 0x0751c($r6)
sw $r1, 0x0751d($r6)
sw $r1, 0x0779d($r6)
sw $r1, 0x0779e($r6)
sw $r1, 0x07a1e($r6)
sw $r1, 0x07a1f($r6)
sw $r1, 0x07c9f($r6)
sw $r1, 0x07c9a($r6)
sw $r1, 0x07f1a($r6)
sw $r1, 0x07f1b($r6)
sw $r1, 0x07f1d($r6)
sw $r1, 0x07f1e($r6)
sw $r1, 0x07f1f($r6)
sw $r1, 0x0819b($r6)
sw $r1, 0x0819c($r6)
sw $r1, 0x0819d($r6)
sw $r1, 0x0819e($r6)
jr $r31
nop
nop

write_6: 
add $r6, $r7, $r6
nop
nop
sw $r1, 0x06b1e($r6)
sw $r1, 0x06d9d($r6)
sw $r1, 0x06d9e($r6)
sw $r1, 0x0701c($r6)
sw $r1, 0x0701d($r6)
sw $r1, 0x0729b($r6)
sw $r1, 0x0729c($r6)
sw $r1, 0x0751a($r6)
sw $r1, 0x0751b($r6)
sw $r1, 0x0779a($r6)
sw $r1, 0x0779b($r6)
sw $r1, 0x0779c($r6)
sw $r1, 0x0779d($r6)
sw $r1, 0x0779e($r6)
sw $r1, 0x07a1a($r6)
sw $r1, 0x07a1e($r6)
sw $r1, 0x07a1f($r6)
sw $r1, 0x07c9a($r6)
sw $r1, 0x07c9f($r6)
sw $r1, 0x07f1a($r6)
sw $r1, 0x07f1b($r6)
sw $r1, 0x07f1e($r6)
sw $r1, 0x07f1f($r6)
sw $r1, 0x0819b($r6)
sw $r1, 0x0819c($r6)
sw $r1, 0x0819d($r6)
sw $r1, 0x0819e($r6)
jr $r31
nop
nop

write_7:
add $r6, $r7, $r6
nop
nop
sw $r1, 0x06d9a($r6)
sw $r1, 0x06d9b($r6)
sw $r1, 0x06d9c($r6)
sw $r1, 0x06d9d($r6)
sw $r1, 0x06d9e($r6)
sw $r1, 0x06d9f($r6)
sw $r1, 0x0701f($r6)
sw $r1, 0x0729e($r6)
sw $r1, 0x0729f($r6)
sw $r1, 0x0751d($r6)
sw $r1, 0x0751e($r6)
sw $r1, 0x0779c($r6)
sw $r1, 0x0779d($r6)
sw $r1, 0x07a1b($r6)
sw $r1, 0x07a1c($r6)
sw $r1, 0x07c9a($r6)
sw $r1, 0x07cdb($r6)
sw $r1, 0x07f1a($r6)
sw $r1, 0x0819a($r6)
jr $r31
nop
nop

write_8:
add $r6, $r7, $r6
nop
nop
sw $r1, 0x06d9b($r6)
sw $r1, 0x06d9c($r6)
sw $r1, 0x06d9d($r6)
sw $r1, 0x06d9e($r6)
sw $r1, 0x0701a($r6)
sw $r1, 0x0701f($r6)
sw $r1, 0x0729a($r6)
sw $r1, 0x0729b($r6)
sw $r1, 0x0729e($r6)
sw $r1, 0x0729f($r6)
sw $r1, 0x0751b($r6)
sw $r1, 0x0751c($r6)
sw $r1, 0x0751d($r6)
sw $r1, 0x0751e($r6)
sw $r1, 0x0779a($r6)
sw $r1, 0x0779b($r6)
sw $r1, 0x0779e($r6)
sw $r1, 0x0779f($r6)
sw $r1, 0x07a1a($r6)
sw $r1, 0x07a1f($r6)
sw $r1, 0x07c9a($r6)
sw $r1, 0x07c9f($r6)
sw $r1, 0x07f1a($r6)
sw $r1, 0x07f1b($r6)
sw $r1, 0x07f1e($r6)
sw $r1, 0x07f1f($r6)
sw $r1, 0x0819b($r6)
sw $r1, 0x0819c($r6)
sw $r1, 0x0819d($r6)
sw $r1, 0x0819e($r6)
jr $r31
nop
nop

write_9:
add $r6, $r7, $r6
nop
nop
sw $r1, 0x06d9b($r6)
sw $r1, 0x06d9c($r6)
sw $r1, 0x06d9d($r6)
sw $r1, 0x06d9e($r6)
sw $r1, 0x06d9f($r6)
sw $r1, 0x0701a($r6)
sw $r1, 0x0701f($r6)
sw $r1, 0x0729a($r6)
sw $r1, 0x0729b($r6)
sw $r1, 0x0729e($r6)
sw $r1, 0x0729f($r6)
sw $r1, 0x0751b($r6)
sw $r1, 0x0751c($r6)
sw $r1, 0x0751d($r6)
sw $r1, 0x0751e($r6)
sw $r1, 0x0751f($r6)
sw $r1, 0x0779f($r6)
sw $r1, 0x07a1f($r6)
sw $r1, 0x07c9f($r6)
sw $r1, 0x07f1f($r6)
sw $r1, 0x0819f($r6)
jr $r31
nop
nop


exit:
.data











