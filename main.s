##--------------------------------------------Register Definition-------------------------------------------##
## $r0 = 0
## $r1 = 1 always
## $r2: will hold the length of the word
## $r3: loop counter for each character of word (i)
## $r4 is the temporary register where you check it against data
## $r30: where the input from keyboard ends up



main:
addi $r1, $r0, 1               ##Initialize $r1 = 1 at the very beginning

##----------------------------------Initialization: length of word, character storage------------------------##

##TODO: Display some "Enter length of word" on VGA for player 1

jal wait_for_input             ##Go to wait_for_input method, waiting for player 1's word length
add $r2, $r30, $r0             ##Store length of word into $r2


##Loop through to get characters
get_characters:
jal wait_for_input             ##Wait for each character

##TODO: store character from register 30 somewhere
add $r4, $r0, $r30             ##Move character to register four
add $r30, $r0, $r0             ##Set input register back to 0
jal render_character           ##Go to render character method


addi $r3, $r3, 1               ##Increment counter
blt $r3, $r2, get_characters   ##Go back through for-loop because $r3 < length of word


##-----------------------------------------Rest of program-------------------------------------------------##




##-----------------------------------------Get Input Method------------------------------------------------##
wait_for_input:
addi $r0, $r0, $r0             ##random commands to stall, prob not necessary
addi $r0, $r0, $r0
bne $r0, $r30, input_ready     ##Keyboard input will make $r30 != 0. jumps back if not branch
jump wait_for_input            ##loop back, waiting

input_ready:
addi $r30, $r0, 0              ##set $r30 back to 0 for the next time wait_for_input gets called
jr $r31                        ##Go back to whatever called this


##-----------------------------------Creating characters section-----------------------------------------------##
render character:
lw $r2, 0($r0)                 #load A
nop
























