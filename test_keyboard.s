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
addi $r1, $r, 1
add $r6, $r0, $r0    #initialize r6 (starting address) to 0 for now

jal wait_for_input
nop
nop

add $r4, $r0, $r30    #Move inputted character to register 4
add $r30, $r0, $r0    #Set input register back to 0
jal render_character  #Go to render character method, r4 has character
nop
addi $r7, $r7, 50     #increment 50 to the right


bne $r1, $r0, main    #infinite loop

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

check_b:
lw $r5, 1($r0)       #load B
nop
nop
bne $r5, $r4, check_c
nop
j write_b

check_c:
lw $r5, 2($r0)        #load C
nop
nop
bne $r5, $r4, exit
nop
j write_c


#----------------------------Write character methods---------------------------#
write_a:
add $r6, $r7, $r6      #create it in the proper place
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

write_b:
add $r6, $r7, $r6
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

write_c:
add $r6, $r7, $r6
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

exit:
.data











