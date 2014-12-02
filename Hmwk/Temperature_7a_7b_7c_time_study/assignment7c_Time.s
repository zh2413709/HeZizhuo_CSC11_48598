.data
msg1: .asciz "=====================This is a temperature converter=====================\n"
msg2: .asciz "Please enter an integer  between and including 32 to 212 in farenheit:"
msg3: .asciz "The temperature you entered is: %f °F, which is: %f °C\n"
temp_read: .word 0
scan_format: .asciz "%d"
return1: .word 0
return2: .word 0
.text

/* Temperature converter function */
temp_convert:
	ldr r0, =return2
	str lr, [r0]

	vmov s8, r1 /* Bit copy from integer register r1 to s8 */
	vcvt.f64.s32 d0, s8 /* Converts r1 signed integer value to a double-precision value and stores in d0 */

	sub r1, r1, #32 /* r1-32 */
	vmov s9, r1 /* Bit copy from integer register r1 to s9 */
	vcvt.f64.s32 d2, s9 /* Converts r1 signed integer value to a double-precision value and stores in d2 */

	mov r2, #5 /* move integer 5 to r2 */
	vmov s10, r2 /* Bit copy from integer register r2 to s10 */
	vcvt.f32.s32 s10, s10 /* Converts s11 signed integer value to a single-precision value and stores it in s11 */

	mov r3, #9 /* move integer 9 to r3 */
	vmov s11, r3 /* Bit copy from integer register r3 to s11 */
	vcvt.f32.s32 s11, s11 /* Converts s11 signed integer value to a single-precision value and stores it in s11 */

	vdiv.f32 s12, s10, s11 /* s12=s10/s11 */

	vcvt.f64.f32 d3, s12 /* d3 has the value of 5/9 */

	vmul.f64 d1, d2, d3 /* d1 has the value of Temp C */

	ldr r0, =return2
	ldr lr, [r0]
	bx lr

.global main
main:
	ldr r0, =return1
	str lr, [r0]

	add sp, sp, #16

	ldr r0, =msg1
	bl printf

	ldr r0, =msg2
	bl printf

	ldr r0, =scan_format
	ldr r1, =temp_read
	bl scanf

	mov r6, #1 /*set up loop */
	ldr r7, =15000000 /* let the program loop 15000000 times */
loop:

	ldr r0, =temp_read
	ldr r1, [r0]
	bl temp_convert

	cmp r7, r6
	bgt scale


	ldr r0, =msg3
	vmov r2, r3, d0
	vstr d1, [sp]
	bl printf

	add sp, sp, #16

	ldr r0, =return1
	ldr lr, [r0]
	bx lr
scale:
	add r6, r6, #1
	b loop

.global scanf
.global printf
