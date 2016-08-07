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
## $r14: 6
## $r15: flag register
## $r16: number of current wrong guesses
## $r17: 1
## $r18: 2
## $r19: 3
## $r20: 4
## $r21: 5
## $r22: 6
## $r23: spare counter
## $r24: 10, 40, 70, 30

.text
main:
nop
nop
nop
addi $r17, $r0, 1    #initialize constants
nop
nop
addi $r18, $r0, 2
nop
nop
addi $r19, $r0, 3
nop
nop
addi $r20, $r0, 4
nop
nop
addi $r21, $r0, 5
nop
nop
addi $r22, $r0, 6
nop
nop
addi $r2, $r0, 1     #initialize $r2 to 1
nop
addi $r14, $r0, 6    #number of guesses you have
nop
nop
nop
add $r6, $r0, $r0    #initialize r6 (starting address) to 0 for now
nop
nop
nop
addi $r13, $r13, 7200
nop
nop
nop
nop
lw $r9, 36($r0)     #load bignum into $r9
nop
nop
nop

addi $r7, $r7, 144
##--------------------------Render initialization text on screen----"Enter length of word"-----------------##

nop
nop
jal write_e
nop
nop
nop
addi $r7, $r7, 12
jal write_n
nop
nop
nop
addi $r7, $r7, 12
jal write_t
nop
nop
nop
addi $r7, $r7, 12
jal write_e
nop
nop
nop
addi $r7, $r7, 12
jal write_r
nop
nop
nop
addi $r7, $r7, 24 #Space
jal write_w
nop
nop
nop
addi $r7, $r7, 12
jal write_o
nop
nop
nop
addi $r7, $r7, 12
jal write_r
nop
nop
nop
addi $r7, $r7, 12
jal write_d
nop
nop
nop
addi $r7, $r7, 24
jal write_l
nop
nop
nop
addi $r7, $r7, 12
jal write_e
nop
nop
nop
addi $r7, $r7, 12
jal write_n
nop
nop
nop
addi $r7, $r7, 12
jal write_g
nop
nop
nop
addi $r7, $r7, 12
jal write_t
nop
nop
nop
addi $r7, $r7, 12
jal write_h
nop
nop
nop
nop

########################################################################################################################
#############------------------------------Render hangy thing----------------------------------------------#############
########################################################################################################################

#for rope thing, 0x1AAEB, get to correct location
addi $r7, $r0, 30000
nop
nop
addi $r7, $r7, 30000
nop
nop
addi $r7, $r7, 30000
nop
nop
addi $r7, $r7, 19291
nop
nop
addi $r23, $r0, 0     #initiate counter register
addi $r24, $r0, 10
jal generate_rope
nop

addi $r7, $r0, 30000
nop
nop
addi $r7, $r7, 30000
nop
nop
addi $r7, $r7, 30000
nop
nop
addi $r7, $r7, 19291
nop
addi $r23, $r0, 0      #reset counter register
addi $r4, $r0, 40
nop
jal generate_hor
nop
nop
#for long stick, 0x1AB13

addi $r7, $r0, 30000
nop
nop
addi $r7, $r7, 30000
nop
nop
addi $r7, $r7, 30000
nop
nop
addi $r7, $r7, 19331
addi $r23, $r0, 0      #reset counter register
addi $r24, $r0, 70
nop
jal generate_vert
nop
nop


jal generate_bottom
nop
nop
#where you start drawing o: 0x1c3e6


########################################################################################################################
#############------------------------------Get length of word----------------------------------------------#############
########################################################################################################################
addi $r7, $r0, 144
nop
nop
nop
nop
nop
addi $r7, $r7, 6400
nop
nop
nop
jal wait_for_input    #Get length of word
nop
nop
nop
nop
jal render_character  #Render length of word - have to reset $r7 because it was rendering sentence above
nop
nop
nop
#-----------Convert hex value to decimal ---------------------#

check_1a:
lw $r5, 27($r0)        #load 1
nop
nop
bne $r5, $r4, check_2a
nop
nop
nop
addi $r11, $r0, 1
nop
nop
j store_length
nop
nop
nop

check_2a:
lw $r5, 28($r0)        #load 2
nop
nop
nop
bne $r5, $r4, check_3a
nop
nop
addi $r11, $r0, 2
nop
nop
j store_length
nop
nop
nop

check_3a:
lw $r5, 29($r0)        #load 3
nop
nop
bne $r5, $r4, check_4a
nop
addi $r11, $r0, 3
nop
nop
j store_length
nop
nop

check_4a:
lw $r5, 30($r0)        #load 4
nop
nop
bne $r5, $r4, check_5a
nop
nop
addi $r11, $r0, 4
nop
nop
j store_length
nop
nop

check_5a:
nop
nop
nop
lw $r5, 31($r0)        #load 5
nop
nop
bne $r5, $r4, check_6a
nop
addi $r11, $r0, 5
nop
nop
j store_length
nop
nop

check_6a:
lw $r5, 32($r0)        #load 6
nop
nop
bne $r5, $r4, check_7a
nop
addi $r11, $r0, 6
nop
nop
j store_length
nop
nop

check_7a:
lw $r5, 33($r0)        #load 7
nop
nop
bne $r5, $r4, check_8a
nop
addi $r11, $r0, 7
nop
nop
j store_length
nop
nop

check_8a:
lw $r5, 34($r0)        #load 8
nop
nop
bne $r5, $r4, check_9a
nop
addi $r11, $r0, 8
nop
nop
j store_length
nop
nop

check_9a:
lw $r5, 35($r0)        #load 9
nop
nop
bne $r5, $r4, store_length
nop
addi $r11, $r0, 9
nop
nop


#-----------------------------------------STORING LENGTH OF WORD----------------------------------#
store_length:
nop
nop
sw $r11, 100($r12)     #Store length of word at 100 in DMEM
nop
nop
nop
nop

#Change position of $r7 again!!

##--------------------------------------Render "Enter letters"----------------------------------##
addi $r7, $r7, 6400
nop
nop
loop_player1:
jal wait_for_input      #wait for each letter
nop
nop
nop
jal render_character
nop
nop
nop
addi $r12, $r12, 1      #increment where you're storing in memory
nop
nop
nop
sw $r4, 100($r12)       #store it there
addi $r3, $r3, 1        #increment counter
nop
nop
nop
nop
addi $r7, $r7, 12       #increment offset
nop
nop
blt $r3, $r11, loop_player1
nop
nop
nop

################################################################################################
#------------------------------------------PLAYER 2 STARTS!!----------------------------------##
################################################################################################
jal clear              #erase word from screen
nop
nop																							#Add bars here
nop
addi $r2, $r0, 1
nop


##--------------------------------------Draw lines-------------------------------------------#
addi $r7, $r0, 21982     #location a little below where words start rendering
nop
nop
nop
addi $r7, $r7, 27416
nop
nop
nop
addi $r7, $r7, 6400
nop
nop
nop
addi $r7, $r7, 24
nop
nop
addi $r7, $r7, 27416
nop
nop
nop
addi $r3, $r0, 0
nop
nop
nop
jal generate_lines
nop
nop


#---------------------------------------Player 2 Loop----------------------------------------#
player2_loop:
jal wait_for_input
nop
nop

#loop_return:
addi $r7, $r0, 19422    #init $r7 to proper location again
nop
nop
nop
addi $r7, $r7, 24
nop
nop
nop
addi $r7, $r7, 27416
addi $r3, $r0, 0        #init loop counter
addi $r12, $r0, 101

j confirm_guess
nop
nop

return_place:
nop
nop
bne $r15, $r0, right_guess
nop
nop
nop
j wrong_guess
nop
nop
nop

right_guess:
nop
nop
j end_of_loop

wrong_guess:
nop
nop
addi $r16, $r16, 1     #add 1 to wrong guesses
nop
nop
nop

check_head:
bne $r16, $r17, check_body          #r17 = 1
nop
jal generate_head
nop
nop

check_body:
bne $r16, $r18, check_rightarm      #r18 = 2
nop
nop
jal generate_body
nop

check_rightarm:
bne $r16, $r19, check_leftarm       #r19 = 3
nop
nop
jal generate_rightarm
nop

check_leftarm:
bne $r16, $r20, check_rightleg      #r20 = 4 wrong
nop
nop
jal generate_leftarm

check_rightleg:                     #r21 = 5
bne $r16, $r21, check_leftleg
nop
nop
jal generate_rightleg
nop
nop

check_leftleg:
bne $r16, $r22, end_of_loop         #r22 = 6
nop
nop
jal generate_leftleg
nop
nop

end_of_loop:
nop
nop
addi $r15, $r0, 0      #set flag back to 0
nop
nop
nop
blt $r16, $r14, player2_loop
nop
nop
nop

j exit


#---------------------------------------Confirm Loop----------------------------------------#
confirm_guess:
lw $r5, 0($r12)
nop
nop
nop
bne $r4, $r5, confirm_guess_2
nop
nop
jal render_character          #render character
nop
nop
addi $r15, $r0, 1             #set flag
nop
nop
confirm_guess_2:
addi $r7, $r7, 12
addi $r3, $r3, 1              #increment counter
nop
addi $r12, $r12, 1            #increment memory address
nop
nop
nop
bne $r3, $r11, confirm_guess
nop
nop
j return_place
nop
nop
nop


#----------------------------------------Wait for input helper method---------------------#
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
bne $r5, $r4, exit
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
sw $r2, 0x077a0($r10)
sw $r2, 0x07a20($r10)
sw $r2, 0x07ca0($r10)
sw $r2, 0x07f20($r10)
sw $r2, 0x0819b($r10)
sw $r2, 0x0819c($r10)
sw $r2, 0x0819d($r10)
sw $r2, 0x0819e($r10)
sw $r2, 0x0819f($r10)
sw $r2, 0x081a0($r10)
sw $r2, 0x07a1b($r10)
sw $r2, 0x07a1c($r10)
sw $r2, 0x07c9b($r10)
sw $r2, 0x07f1b($r10)
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
sw $r2, 0x07019($r10)
sw $r2, 0x0701a($r10)
sw $r2, 0x0701b($r10)
sw $r2, 0x0701c($r10)
sw $r2, 0x0701d($r10)
sw $r2, 0x0701e($r10)
sw $r2, 0x0701f($r10)
sw $r2, 0x07020($r10)
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
sw $r2, 0x07f1b($r10)
sw $r2, 0x07f1c($r10)
sw $r2, 0x0819b($r10)
sw $r2, 0x0819c($r10)
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
nop
nop
nop
nop
nop
jr $r31
nop
nop


#--------------------------------CLEAR FUNCTION ----------------------------#
clear:
nop
nop
add $r7, $r0, $r0       #set $r7 back to 0
nop
nop
addi $r7, $r7, 27416    #hex code offset
nop
nop
nop
addi $r7, $r7, 12944     #location where you will start clearing
addi $r3, $r0, 0        #INITIALIZE COUNTER TO 0
nop
addi $r2, $r0, 0        #Set color to black

clear_loop:
add $r10, $r7, $r6      #get address where you'll erase
nop
nop
sw $r2, 0($r10)         #COLOR IN BLACK
nop
nop
addi $r3, $r3, 1
nop
nop
addi $r7, $r7, 1      
nop
blt $r3, $r13, clear_loop
nop
nop
addi $r2, $r0, 1
nop
nop
jr $r31
nop
nop
nop


#--------------------------------Generate body parts------------------------#
generate_rope:
nop
addi $r2, $r0, 1
nop
nop
sw $r2, 0($r7)
addi $r7, $r7, 640      #go one pixel down
addi $r23, $r23, 1      #increment counter
blt $r23, $r24, generate_rope    #loop 10 times
nop
jr $r31
nop
nop

generate_hor:
nop
addi $r2, $r0, 1
nop
nop
nop
sw $r2, 0($r7)
nop
nop
addi $r7, $r7, 1
nop
addi $r23, $r23, 1
nop
nop
blt $r23, $r24, generate_hor     #loop 40 times now
nop
nop
jr $r31
nop

generate_vert:
nop
addi $r2, $r0, 1
nop
nop
sw $r2, 0($r7)
nop
addi $r7, $r7, 640
nop
nop
addi $r23, $r23, 1
nop
nop
blt $r23, $r24, generate_vert      #loop 70 times
nop
nop
addi $r23, $r0, 0           #reset counter plz thanks
nop
nop
jr $r31
nop
nop


generate_head:
nop
nop
addi $r2, $r0, 1
nop
addi $r10, $r0, 30000
nop
nop
addi $r10, $r10, 30000
nop
addi $r10, $r10, 28270
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
nop
nop
jr $r31
nop
nop

generate_body:
nop
addi $r2, $r0, 1
nop
addi $r10, $r0, 30000
nop
nop
addi $r10, $r10, 30000
nop
nop
addi $r10, $r10, 30000
nop
nop
addi $r10, $r10, 30000
nop
nop
addi $r10, $r10, 2091
nop
addi $r24, $r0, 20
addi $r23, $r0, 0
nop
body_loop:
nop
sw $r2, 0($r10)
nop
addi $r10, $r10, 640
nop
addi $r23, $r23, 1
nop
nop
blt $r23, $r24, body_loop
nop
nop
jr $r31
nop
nop

generate_rightarm:
nop
addi $r2, $r0, 1
nop
addi $r10, $r0, 30000
nop
nop
addi $r10, $r10, 30000
nop
nop
addi $r10, $r10, 30000
nop
nop
addi $r10, $r10, 30000
nop
nop
addi $r10, $r10, 8491
nop
sw $r2, 0($r10)
sw $r2, 1($r10)
sw $r2, 2($r10)
sw $r2, 3($r10)
sw $r2, 4($r10)
sw $r2, 5($r10)
sw $r2, 6($r10)
sw $r2, 7($r10)
sw $r2, 8($r10)
sw $r2, 9($r10)
nop
nop
nop
nop
jr $r31
nop
nop

generate_leftarm:
nop
addi $r2, $r0, 1
nop
addi $r10, $r0, 30000
nop
nop
addi $r10, $r10, 30000
nop
nop
addi $r10, $r10, 30000
nop
nop
addi $r10, $r10, 30000
nop
nop
addi $r10, $r10, 8481
nop
sw $r2, 0($r10)
sw $r2, 1($r10)
sw $r2, 2($r10)
sw $r2, 3($r10)
sw $r2, 4($r10)
sw $r2, 5($r10)
sw $r2, 6($r10)
sw $r2, 7($r10)
sw $r2, 8($r10)
sw $r2, 9($r10)
nop
nop
jr $r31
nop
nop

generate_rightleg:
nop
nop
addi $r2, $r0, 1
nop
addi $r10, $r0, 30000
nop
nop
addi $r10, $r10, 30000
nop
nop
addi $r10, $r10, 30000
nop
nop
addi $r10, $r10, 30000
nop
nop
addi $r10, $r10, 14891
nop
nop
nop
sw $r2, 0($r10)
sw $r2, 1($r10)
sw $r2, 2($r10)
sw $r2, 3($r10)
sw $r2, 4($r10)
sw $r2, 5($r10)
sw $r2, 6($r10)
sw $r2, 7($r10)
sw $r2, 8($r10)
sw $r2, 9($r10)
nop
nop
nop
jr $r31
nop
nop

generate_leftleg:
nop
nop
nop
nop
addi $r2, $r0, 1
nop
addi $r10, $r0, 30000
nop
nop
addi $r10, $r10, 30000
nop
nop
addi $r10, $r10, 30000
nop
nop
addi $r10, $r10, 30000
nop
nop
addi $r10, $r10, 14881
nop
sw $r2, 0($r10)
sw $r2, 1($r10)
sw $r2, 2($r10)
sw $r2, 3($r10)
sw $r2, 4($r10)
sw $r2, 5($r10)
sw $r2, 6($r10)
sw $r2, 7($r10)
sw $r2, 8($r10)
sw $r2, 9($r10)
nop
nop
jr $r31
nop
nop

generate_bottom:
nop
nop
nop
addi $r2, $r0, 1
nop
addi $r10, $r0, 30000
nop
nop
addi $r10, $r10, 30000
nop
nop
addi $r10, $r10, 30000
nop
nop
addi $r10, $r10, 30000
nop
nop
addi $r10, $r10, 30000
nop
nop
addi $r10, $r10, 4111
nop
nop
sw $r2, 0($r10)
sw $r2, 1($r10)
sw $r2, 2($r10)
sw $r2, 3($r10)
sw $r2, 4($r10)
sw $r2, 5($r10)
sw $r2, 6($r10)
sw $r2, 7($r10)
sw $r2, 8($r10)
sw $r2, 9($r10)
sw $r2, 10($r10)
sw $r2, 11($r10)
sw $r2, 12($r10)
sw $r2, 13($r10)
sw $r2, 14($r10)
sw $r2, 15($r10)
sw $r2, 16($r10)
sw $r2, 17($r10)
sw $r2, 18($r10)
sw $r2, 19($r10)
sw $r2, 20($r10)
sw $r2, 21($r10)
sw $r2, 22($r10)
sw $r2, 23($r10)
sw $r2, 24($r10)
sw $r2, 25($r10)
sw $r2, 26($r10)
sw $r2, 27($r10)
sw $r2, 28($r10)
sw $r2, 29($r10)
sw $r2, 20($r10)
sw $r2, 21($r10)
sw $r2, 22($r10)
sw $r2, 23($r10)
sw $r2, 24($r10)
sw $r2, 25($r10)
sw $r2, 26($r10)
sw $r2, 27($r10)
sw $r2, 28($r10)
sw $r2, 29($r10)
sw $r2, 30($r10)
sw $r2, 31($r10)
sw $r2, 32($r10)
sw $r2, 33($r10)
sw $r2, 34($r10)
sw $r2, 35($r10)
sw $r2, 36($r10)
sw $r2, 37($r10)
sw $r2, 38($r10)
sw $r2, 39($r10)
nop
nop
nop
nop
jr $r31
nop
nop

#------------------------------Generate lines------------------------------#
generate_lines:
addi $r2, $r0, 1
nop
nop
add $r10, $r7, $r6
nop
nop
nop
nop
nop
sw $r2, 0($r10)         #draw ten pixels
sw $r2, 1($r10)
sw $r2, 2($r10)
sw $r2, 3($r10)
sw $r2, 4($r10)
sw $r2, 5($r10)
sw $r2, 6($r10)
sw $r2, 7($r10)
sw $r2, 8($r10)
sw $r2, 9($r10)
nop
nop
addi $r7, $r7, 12       #increment by 22
nop
nop
addi $r3, $r3, 1
nop
nop
nop
nop
blt $r3, $r11, generate_lines
nop
nop
nop
jr $r31                  #return
nop
nop
nop

#####################################################################################
#-------------------------------------EXIT FUNCTION--------------------------------#
########################################################################################
exit:
nop
nop
addi $r7, $r7, 10
nop
nop
nop
nop
nop
addi $r3, $r0, 0
nop
nop
addi $r12, $r0, 101
nop
nop
#----Stuff for location
addi $r7, $r0, 19422    #init $r7 to proper location again
nop
nop
nop
addi $r7, $r7, 24
nop
nop
nop
addi $r7, $r7, 27416

nop

render_rest:
lw $r4, 0($r12)               #load word into $r4
nop
nop
nop
jal render_character          #render the word
nop
nop
addi $r12, $r12, 1
nop
nop
addi $r3, $r3, 1
nop
nop
addi $r7, $r7, 12
nop
nop
blt $r3, $r11, render_rest
nop
nop


render_goodbye:
nop
addi $r7, $r0, 19422    #init $r7 to proper location again
nop
nop
nop
addi $r7, $r7, 24
nop
nop
nop
addi $r7, $r7, 27416
nop
nop
nop
addi $r7, $r7, 19200    #move one line down again
nop
nop
nop
jal write_g
nop
nop
nop
addi $r7, $r7, 12
jal write_o
nop
nop
nop
addi $r7, $r7, 12
jal write_o
nop
nop
addi $r7, $r7, 12
jal write_d
nop
nop
nop
addi $r7, $r7, 12
jal write_b
nop
nop
nop
addi $r7, $r7, 12
jal write_y
nop
nop
nop
addi $r7, $r7, 12
jal write_e
nop
nop
nop
halt
nop
nop
nop

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
