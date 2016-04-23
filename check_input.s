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
add $r30, $r0, $r0
jal wait_for_input
nop
nop
add $r4, $r0, $r30    #move to $r4
add $r30, $r0, $r0    #set input register back to 0
sw $r4, 0($r0)
j exit
nop
nop


#--------------------------Wait for input ---------------------#
wait_for_input:
nop
nop
bne $r30, $r0, input_ready
nop
nop
j wait_for_input     #loop back and wait if still equal

input_ready:
jr $r31              #go back and render input
nop
nop

exit:

.data