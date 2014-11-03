.data
.balign 4
spot1 : .word 0
.balign 4
spot2 : .word 0
.balign 4
spot3 : .word 0
.balign 4
message1 : .asciz "========This is a Mastermind game========\n========Please enter 3 numbers between 0 and 6 for each,\n========Press 'enter' key after each number========\n"
.balign 4
message2 : .asciz "The result is RP: %d, WP: %d\n"
.balign 4
scan_format : .asciz " %d %d %d"
.balign 4
spot1_read : .word 0
.balign 4
spot2_read : .word 0
.balign 4
spot3_read : .word 0
.balign 4
message3 : .asciz "========You have guessed all the number correctly, congratulations!========\n"
.balign 4
message4 : .asciz "========This is the %d turns, you still have %d turns left========\n"
.balign 4
message5 : .asciz "========You lose!========"
.text
.balign 4
.global main
main:
 	push {lr}

generate_random_number:
	bl rantest1 /* generate the first random number */
	ldr r0, addr_of_spot1 /*load r0 address of the first variable */
	str r1, [r0] /* store the first random number into the first variable */

	bl rantest2 /* generate the second random number */
        ldr r0, addr_of_spot2  /*load r0 address of the second variable */
        str r1, [r0]  /* store the second random number into the second variable */

	bl rantest3 /* generate the third random number */
        ldr r0, addr_of_spot3  /*load r0 address of the third variable */
        str r1, [r0]  /* store the third random number into the third variable */

	mov r6, #1 /* the turns counter */
	mov r7, #8 /* turns left counter */
guess:
	ldr r0, addr_of_message1
	bl printf

	ldr r0, addr_of_scan_format /* load the scan format */
	ldr r1, addr_of_spot1_read /* load r1 address of variable4 */
	ldr r2, addr_of_spot2_read /* load r2 address of variable5 */
	ldr r3, addr_of_spot3_read /* load r3 address of variable6 */
	bl scanf /*call scanf */
	/* compare*/
	mov r0, #0 /* int 'right position counter' zero */
	mov r5, #0 /* int 'wrong position counter' zero */
	ldr r1, addr_of_spot1
	ldr r1, [r1] /* load r1 the first generated random number */
	ldr r2, addr_of_spot2
	ldr r2, [r2] /* load r2 the second generated random number */
	ldr r3, addr_of_spot3
	ldr r3, [r3] /* load r3 the third generated random number */

	ldr r4, addr_of_spot1_read
	ldr r4, [r4] /* load r4 the first number user entered */
	bl cmp1 /* call AI to compare */

	ldr r4, addr_of_spot2_read
	ldr r4, [r4] /* load r4 the second  number user entered */
	bl cmp2 /* call AI to compare */

	ldr r4, addr_of_spot3_read
	ldr r4, [r4] /* load r4 the third  number user entered */
	bl cmp3 /* call AI to compare */

	mov r4, r0 /* save a copy of 'RP' to r4 */
	mov r1, r0 /* save a copy of 'RP' to r1 */
	mov r2, r5 /* save a copy of 'WP' to r5 */
	ldr r0, addr_of_message2
	bl printf

	ldr r0, addr_of_message4
	mov r1, r6
        sub r7, r7, #1 /*sub r7, to show how many turns left */
	mov r2, r7
	bl printf

	add r6, r6, #1 /*add 1 to turns counter after each try */
	cmp r6, #9
	beq lose
	cmp r4, #3 /* set up loop */
	beq win /* if 'RP' reaches 3 means the user wins */
	b guess /* loop back to input when user did not make the correct guess */
lose:
	ldr r0, addr_of_message5
	bl printf
	b end
win:
	ldr r0, addr_of_message3
	bl printf
end:
	pop {lr}
	bx lr

addr_of_spot1 : .word spot1
addr_of_spot2 : .word spot2
addr_of_spot3 : .word spot3
addr_of_spot1_read : .word spot1_read
addr_of_spot2_read : .word spot2_read
addr_of_spot3_read : .word spot3_read
addr_of_message1 : .word message1
addr_of_message2 : .word message2
addr_of_message3 : .word message3
addr_of_scan_format : .word scan_format
addr_of_message4 : .word message4
addr_of_message5 : .word message5
.global printf
.global scanf
