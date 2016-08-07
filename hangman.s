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
## $r11: location where you store length of word
## $r12: location where you store characters in word
## $r13: 4800
## $r14: NUM GUESSES LEFT
## $r15: flag register

.text
main:
addi $r2, $r0, 1     #initialize $r2 to 1
addi $r14, $r0, 6
add $r6, $r0, $r0    #initialize r6 (starting address) to 0 for now
addi $r13, $r13, 7200
lw $r9, 36($r0)     #load bignum into $r9

addi $r7, $r7, 144
##--------------------------Render initialization text on screen----"Enter length of word"-----------------##

jal write_e
addi $r7, $r7, 12
jal write_n
addi $r7, $r7, 12
jal write_t
addi $r7, $r7, 12
jal write_e
addi $r7, $r7, 12
jal write_r
addi $r7, $r7, 24 #Space
jal write_w
addi $r7, $r7, 12
jal write_o
addi $r7, $r7, 12
jal write_r
addi $r7, $r7, 12
jal write_d
addi $r7, $r7, 24
jal write_l
addi $r7, $r7, 12
jal write_e
addi $r7, $r7, 12
jal write_n
addi $r7, $r7, 12
jal write_g
addi $r7, $r7, 12
jal write_t
addi $r7, $r7, 12
jal write_h


########################################################################################################################
#############------------------------------Get length of word----------------------------------------------#############
########################################################################################################################
addi $r7, $r0, 144
addi $r7, $r7, 6400
jal wait_for_input    #Get length of word
jal render_character  #Render length of word - have to reset $r7 because it was rendering sentence above
#-----------Convert hex value to decimal ---------------------#

check_1a:
lw $r5, 27($r0)        #load 1
bne $r5, $r4, check_2a
addi $r11, $r0, 1
j store_length

check_2a:
lw $r5, 28($r0)        #load 2
bne $r5, $r4, check_3a
addi $r11, $r0, 2
j store_length

check_3a:
lw $r5, 29($r0)        #load 3
bne $r5, $r4, check_4a
addi $r11, $r0, 3
j store_length

check_4a:
lw $r5, 30($r0)        #load 4
bne $r5, $r4, check_5a
addi $r11, $r0, 4
j store_length

check_5a:
lw $r5, 31($r0)        #load 5
bne $r5, $r4, check_6a
addi $r11, $r0, 5
j store_length

check_6a:
lw $r5, 32($r0)        #load 6
bne $r5, $r4, check_7a
addi $r11, $r0, 6
j store_length

check_7a:
lw $r5, 33($r0)        #load 7
bne $r5, $r4, check_8a
addi $r11, $r0, 7
j store_length

check_8a:
lw $r5, 34($r0)        #load 8
bne $r5, $r4, check_9a
addi $r11, $r0, 8
j store_length

check_9a:
lw $r5, 35($r0)        #load 9
bne $r5, $r4, store_length
addi $r11, $r0, 9


#-----------------------------------------STORING LENGTH OF WORD----------------------------------#
store_length:
sw $r11, 100($r12)     #Store length of word at 100 in DMEM

#Change position of $r7 again!!

##--------------------------------------Render "Enter letters"----------------------------------##
addi $r7, $r7, 6400
loop_player1:
jal wait_for_input      #wait for each letter
jal render_character
addi $r12, $r12, 1      #increment where you're storing in memory
sw $r4, 100($r12)       #store it there
addi $r3, $r3, 1        #increment counter
addi $r7, $r7, 12       #increment offset
blt $r3, $r11, loop_player1

################################################################################################
#------------------------------------------PLAYER 2 STARTS!!----------------------------------##
################################################################################################
jal clear                #erase word from screen
addi $r2, $r0, 1


#---------------------------------------Player 2 Loop----------------------------------------#
player2_loop:
jal wait_for_input

#loop_return:
addi $r7, $r0, 19344    #init $r7 to proper location again
addi $r7, $r7, 27416
addi $r3, $r0, 0        #init loop counter
addi $r12, $r0, 101

j confirm_guess

return_place:
bne $r15, $r0, flag_set
j flag_not_set

flag_set:
sub $r14, $r14, $r2

flag_not_set:
addi $r15, $r0, 0       #resetting flag to 0
bne $r0, $r14, player2_loop

j exit


#---------------------------------------Confirm Loop----------------------------------------#
confirm_guess:
lw $r5, 0($r12)
bne $r4, $r5, confirm_guess_2
jal render_character          #render character
addi $r15, $r0, 1             #set flag
confirm_guess_2:
addi $r7, $r7, 12
addi $r3, $r3, 1              #increment counter
addi $r12, $r12, 1            #increment memory address
bne $r3, $r11, confirm_guess
j return_place


#----------------------------------------Wait for input helper method---------------------#
wait_for_input:
add $r8, $r0, $r0    #set debounce register to 0 repetitively
bne $r1, $r0, move_input   #branch if you detect something in $r1 that's not 0
j wait_for_input     #loop back and wait if still equal


move_input:
addi $r4, $r1, 0
j input_ready

input_ready:             
addi $r8, $r8, 1     #increment $r8
blt $r8, $r9, input_ready      #if $r8 is less than $r9, stall
jr $r31


#--------------------------Render stuff -------------------------#
render_character:
lw $r5, 0($r0)       #load A
bne $r5, $r4, check_b #this letter is not A
j write_a

check_b:
lw $r5, 1($r0)       #load B
bne $r5, $r4, check_c
j write_b

check_c:
lw $r5, 2($r0)        #load C
bne $r5, $r4, check_d
j write_c


check_d:
lw $r5, 3($r0)        #load D
bne $r5, $r4, check_e
j write_d

check_e:
lw $r5, 4($r0)        #load E
bne $r5, $r4, check_f
j write_e

check_f:
lw $r5, 5($r0)        #load F
bne $r5, $r4, check_g
j write_f

check_g:
lw $r5, 6($r0)        #load G
bne $r5, $r4, check_h
j write_g

check_h:
lw $r5, 7($r0)        #load H
bne $r5, $r4, check_i
j write_h

check_i:
lw $r5, 8($r0)        #load I
bne $r5, $r4, check_j
j write_i

check_j:
lw $r5, 9($r0)        #load J
bne $r5, $r4, check_k
j write_j

check_k:
lw $r5, 10($r0)        #load K
bne $r5, $r4, check_l
j write_k

check_l:
lw $r5, 11($r0)        #load L
bne $r5, $r4, check_m
j write_l

check_m:
lw $r5, 12($r0)        #load m
bne $r5, $r4, check_n
j write_m

check_n:
lw $r5, 13($r0)        #load n
bne $r5, $r4, check_o
j write_n

check_o:
lw $r5, 14($r0)        #load o
bne $r5, $r4, check_p
j write_o

check_p:
lw $r5, 15($r0)        #load p
bne $r5, $r4, check_q
j write_p

check_q:
lw $r5, 16($r0)        #load q
bne $r5, $r4, check_r
j write_q

check_r:
lw $r5, 17($r0)        #load r
bne $r5, $r4, check_s
j write_r

check_s:
lw $r5, 18($r0)        #load s
bne $r5, $r4, check_t
j write_s

check_t:
lw $r5, 19($r0)        #load t
bne $r5, $r4, check_u
j write_t

check_u:
lw $r5, 20($r0)        #load u
bne $r5, $r4, check_v
j write_u

check_v:
lw $r5, 21($r0)        #load v
bne $r5, $r4, check_w
j write_v

check_w:
lw $r5, 22($r0)        #load w
bne $r5, $r4, check_x
j write_w

check_x:
lw $r5, 23($r0)        #load x
bne $r5, $r4, check_y
j write_x

check_y:
lw $r5, 24($r0)        #load y
bne $r5, $r4, check_z
j write_y

check_z:
lw $r5, 25($r0)        #load z
bne $r5, $r4, check_0
j write_z

check_0:
lw $r5, 26($r0)        #load 0
bne $r5, $r4, check_1
j write_o

check_1:
lw $r5, 27($r0)        #load 1
bne $r5, $r4, check_2
j write_1

check_2:
lw $r5, 28($r0)        #load 2
bne $r5, $r4, check_3
j write_2

check_3:
lw $r5, 29($r0)        #load 3
bne $r5, $r4, check_4
j write_3

check_4:
lw $r5, 30($r0)        #load 4
bne $r5, $r4, check_5
j write_4

check_5:
lw $r5, 31($r0)        #load 5
bne $r5, $r4, check_6
j write_5

check_6:
lw $r5, 32($r0)        #load 6
bne $r5, $r4, check_7
j write_6

check_7:
lw $r5, 33($r0)        #load 7
bne $r5, $r4, check_8
j write_7

check_8:
lw $r5, 34($r0)        #load 8
bne $r5, $r4, check_9
j write_8

check_9:
lw $r5, 35($r0)        #load 9
bne $r5, $r4, exit
j write_9

#----------------------------Write character methods---------------------------#
write_a:
add $r10, $r7, $r6      #create it in the proper place
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

write_b:
add $r10, $r7, $r6
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

write_c:
add $r10, $r7, $r6
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

write_d:
add $r10, $r7, $r6
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

write_e:
add $r10, $r7, $r6
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

write_f:
add $r10, $r7, $r6
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

write_g:
add $r10, $r7, $r6
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

write_h:
add $r10, $r7, $r6
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

write_i:
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
sw $r2, 0x07c9d($r10)
sw $r2, 0x07f1d($r10)
sw $r2, 0x0819e($r10)
sw $r2, 0x0819d($r10)
sw $r2, 0x0819e($r10)
jr $r31

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

write_k:
add $r10, $r7, $r6
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

write_l:
add $r10, $r7, $r6
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

write_m:
add $r10, $r7, $r6
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

write_n:
add $r10, $r7, $r6
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

write_o:
add $r10, $r7, $r6
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

write_p:
add $r10, $r7, $r6
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

write_q:
add $r10, $r7, $r6
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

write_r:
add $r10, $r7, $r6
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

write_s:
add $r10, $r7, $r6
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

write_t:
add $r10, $r7, $r6
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

write_u:
add $r10, $r7, $r6
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

write_v:
add $r10, $r7, $r6
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

write_w:
add $r10, $r7, $r6
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

write_x:
add $r10, $r7, $r6
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

write_y:
add $r10, $r7, $r6
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

write_z:
add $r10, $r7, $r6
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

write_1:
add $r10, $r7, $r6
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

write_2:
add $r10, $r7, $r6
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

write_3:
add $r10, $r7, $r6
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

write_4:
add $r10, $r7, $r6
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

write_5:
add $r10, $r7, $r6
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

write_6: 
add $r10, $r7, $r6
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

write_7:
add $r10, $r7, $r6
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

write_8:
add $r10, $r7, $r6
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

write_9:
add $r10, $r7, $r6
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


#--------------------------------CLEAR FUNCTION ----------------------------#
clear:
add $r7, $r0, $r0       #set $r7 back to 0
addi $r7, $r7, 27416    #hex code offset
addi $r7, $r7, 12944     #location where you will start clearing
addi $r3, $r0, 0        #INITIALIZE COUNTER TO 0
addi $r2, $r0, 0        #Set color to black

clear_loop:
add $r10, $r7, $r6      #get address where you'll erase
sw $r2, 0($r10)         #COLOR IN BLACK
addi $r3, $r3, 1
addi $r7, $r7, 1      
blt $r3, $r13, clear_loop
jr $r31


#------------------------------EXIT FUNCTION--------------------------------#
exit:
addi $r7, $r7, 10
jal write_9
halt
jal write_9

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
