.data
.align 4
array: .skip 16
.align 4
message1: .asciz "========This is a Mastermind game========\n========Please enter 3 numbers between 0 and 6 for each,\n========Press 'enter' key after each number========\n"
.align 4
message2: .asciz "The result is RP: %d, WP: %d\n"
.align 4
scan_format: .asciz " %d %d %d"
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
message5: .asciz "========You lose!========"

.text
.balign 4
.global main
main:
 	push {lr}

generate_random_number:
	mov r0, #3
	ldr r1, =array
	bl init_array

	mov r9, #1 /* the turns counter */
	mov r10, #8 /* turns left counter */
guess:
	ldr r0, =message1
	bl printf

	ldr r0, =scan_format /* load the scan format */
	ldr r1, =spot1_read /* load r1 address of variable4 */
	ldr r2, =spot2_read /* load r2 address of variable5 */
	ldr r3, =spot3_read /* load r3 address of variable6 */
	bl scanf /*call scanf */
	
	/* compare*/
	mov r0, #0 /* init 'right position counter' zero */
	mov r5, #0 /* init 'wrong position counter' zero */

	ldr r6, =array
	ldr r1, [r6] /* load r1 the first generated random number */

	mov r7, #1 
	ldr r2, [r6, r7, lsl #2] /* load r2 the second generated random number */

	mov r7, #2
	ldr r3, [r6, r7, lsl #2] /* load r3 the third generated random number */

	ldr r4, =spot1_read
	ldr r4, [r4] /* load r4 the first number user entered */
	bl cmp1 /* call AI to compare */

	ldr r4, =spot2_read
	ldr r4, [r4] /* load r4 the second  number user entered */
	bl cmp2 /* call AI to compare */

	ldr r4, =spot3_read
	ldr r4, [r4] /* load r4 the third  number user entered */
	bl cmp3 /* call AI to compare */

	mov r4, r0 /* save a copy of 'RP' to r4 */
	mov r1, r0 /* save a copy of 'RP' to r1 */
	mov r2, r5 /* save a copy of 'WP' to r5 */
	ldr r0, =message2
	bl printf

	ldr r0, =message4
	mov r1, r9
        sub r10, r10, #1 /*sub r7, to show how many turns left */
	mov r2, r10
	bl printf

	add r9, r9, #1 /*add 1 to turns counter after each try */
	cmp r9, #9
	beq lose
	cmp r4, #3 /* set up loop */
	beq win /* if 'RP' reaches 3 means the user wins */
	b guess /* loop back to input when user did not make the correct guess */
lose:
	ldr r0, =message5
	bl printf
	b end
win:
	ldr r0, =message3
	bl printf
end:
	pop {lr}
	bx lr
.global printf
.global scanf

