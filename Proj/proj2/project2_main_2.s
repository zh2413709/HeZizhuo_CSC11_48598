.data
/* saving 3 integers into an array, each integer takes 4 bytes,
 therefore align 3*4=12 bytes. Adding extra 4 bytes so 12+4=16 bytes */
.align 4
array: .skip 16
.align 4
message1: .asciz "========This is a Mastermind game========\n========Please enter 3 numbers between 0 and 6 for each,\n========Press 'enter' key after each number========\n"
.align 4
message2: .asciz "The result is RP: %d, WP: %d\n"
.align 4
scan_format: .asciz " %d %d %d"
/* prepare variables for user input */
.align 4
spot1_read: .word 0
.align 4
spot2_read: .word 0
.align 4
spot3_read: .word 0
.align 4
message3: .asciz "========You have guessed all the number correctly, congratulations!========\n"
.align 4
message4: .asciz "========This is the %d turns, you still have %d turns left========\n"
.align 4
message5: .asciz "========You lose!========\n"
.align 4
msg6: .asciz "Do you want to play the game again? Enter 'Y' for yes or 'N' for no:"
.align 4
scan_format2: .asciz " %c"
.align 4
option: .word 0
.align 4
msg7: .asciz "You entered an invalid value: %c\n"
.align 4
msg8: .asciz "You entered: %c. The game is about to restart!\n"
.align 4
msg9: .asciz "You entered: %c. Exiting the game, byebye!\n"

.text
.align 4
.global main
main:
 	push {lr}
start:
	ldr r0, =message1
	bl printf
/* generate three random number through utilizing floating numbers */
generate_random_number:
	mov r0, #3 /* load the # of items */
	ldr r1, =array /* load the address of array */
	bl init_array /* call function to fill array */

/* set up loop counter here to limit the # of times user can try */
	mov r9, #1 /* the turns counter */
	mov r10, #8 /* turns left counter */

guess:
	ldr r0, =scan_format /* load the scan format */
	ldr r1, =spot1_read /* load r1 address of variable4 */
	ldr r2, =spot2_read /* load r2 address of variable5 */
	ldr r3, =spot3_read /* load r3 address of variable6 */
	bl scanf /*call scanf */

	/* compare*/
	mov r0, #0 /* init 'right position counter' zero */
	mov r5, #0 /* init 'wrong position counter' zero */

	ldr r6, =array /* load the address of array */
	ldr r1, [r6] /* load r1 the first generated random number */

	mov r7, #1 /* increase the increment by 1 */
	ldr r2, [r6, r7, lsl #2] /* load r2 the second generated random number */

	mov r7, #2 /* increase the increment by 2 */
	ldr r3, [r6, r7, lsl #2] /* load r3 the third generated random number */

	ldr r4, =spot1_read /* load the address of the first entered # */
	ldr r4, [r4] /* load r4 the first number user entered */
	bl cmp1 /* call AI to compare */

	ldr r4, =spot2_read /* load the address of the second entered # */
	ldr r4, [r4] /* load r4 the second  number user entered */
	bl cmp2 /* call AI to compare */

	ldr r4, =spot3_read /* load the address of the third entered # */
	ldr r4, [r4] /* load r4 the third  number user entered */
	bl cmp3 /* call AI to compare */

	mov r4, r0 /* save a copy of 'RP' to r4 */
	mov r1, r0 /* save a copy of 'RP' to r1 */
	mov r2, r5 /* save a copy of 'WP' to r5 */
	ldr r0, =message2
	bl printf

	ldr r0, =message4
	mov r1, r9 /* move r9 to r1, to show how many turns the user has tried */
        sub r10, r10, #1 /*sub r10, to show how many turns left */
	mov r2, r10
	bl printf

	add r9, r9, #1 /*add 1 to turns counter after each try */
	cmp r9, #9
	beq lose /* The user loses when the loop reaches the 9th turns */
	cmp r4, #3 /* set up loop for second, third,... tries */
	beq win /* if 'RP' reaches 3 means the user wins */
	b guess /* loop back to input when user did not make the correct guess */
lose:
	ldr r0, =message5
	bl printf /* display losing message */
	b end
win:
	ldr r0, =message3
	bl printf /* display winning message */
end:

	ldr r0, =msg6
	bl printf

	ldr r0, =scan_format2
	ldr r1, =option
	bl scanf

	ldr r1, =option
	ldr r1, [r1]

	cmp r1, #'Y'
	beq case_Y
	cmp r1, #'y'
	beq case_y
	cmp r1, #'N'
	beq case_N
	cmp r1, #'n'
	beq case_n

	ldr r0, =msg7
	bl printf
	b end

exit:
	pop {lr}
	bx lr

case_Y:
	ldr r0, =msg8
        ldr r1, =option
        ldr r1, [r1]
        bl printf
	b start
case_y:
	ldr r0, =msg8
        ldr r1, =option
        ldr r1, [r1]
        bl printf
	b start
case_N:
	ldr r0, =msg9
	ldr r1, =option
	ldr r1, [r1]
	bl printf
	b exit
case_n:
	ldr r0, =msg9
        ldr r1, =option
        ldr r1, [r1]
        bl printf
        b exit

.global printf
.global scanf

