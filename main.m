//--------------------------------------------Register Definition-------------------------------------------//
// $r0 = 0
// $r1 = 1
// $r2: will hold the length of the word
// $r3: loop counter for each character of word (i)
// $r29: where the input from keyboard ends up
// $r30: is 1 after keyboard input is read, is 0 while waiting for keyboard input


main:
addi $r1, $r0, 1               //Initialize $r1 = 1 at the very beginning

//----------------------------------Initialization: length of word, character storage------------------------//

//TODO: Display some "Enter length of word" on VGA for player 1

jal wait_for_input             //Go to wait_for_input method, waiting for player 1's word length
add $r2, $r29, $r0             //Store length of word into $r2


//Loop through to get characters
get_characters:
jal wait_for_input             //Wait for each character

//TODO: store character from register 29 somewhere

addi $r3, $r3, 1               //Increment counter
blt $r3, $r2, get_characters   //Go back through for-loop because $r3 < length of word


//-----------------------------------------Rest of program-------------------------------------------------//




//-----------------------------------------Get Input Method------------------------------------------------//
wait_for_input:
addi $r0, $r0, $r0             //random commands to stall, prob not necessary
addi $r0, $r0, $r0
bne $r1, $r30, wait_for_input  //$r1 always holds the value 1. Keyboard input will make $r30 = 1. Branches back if $r30 != 1.
addi $r30, $r0, 0              //set $r30 back to 0 for the next time wait_for_input gets called
jr $r31                        //Go back to whatever called this

exit: