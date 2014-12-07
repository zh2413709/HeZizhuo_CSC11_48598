.data
.text
.global init_array
init_array:
	/* r0: # of items
	   r1: address of array */
	push {r4, lr}

	mov r4, #0 /* the loop counter */
	mov r6, r1 /* save a copy of address of array */
	mov r5, r0 /* save a copy of # of items */

	mov r0,#0                    /* Set time(0) */
    	bl time                      /* Call time */
	bl srand                     /* Call srand */

	b check_loop_array
loop_array:
	bl rand       	 /* Call rand */
	mov r2, r0, lsr #7	 /* Left shit r0 7 times to make sure the float does not overflow */

/* The calculation part start from here */
/* concept:
	Since the idea behind utilizing DivMod is to get the remainder as the needed 1 bit decimal  random number, the same calculation can be represent by float.
	Let #1 represents the random number generated from rand function.
	Let #2.#3 represents the result of dividing #1 by 7.
	#2 will be the integer part of the reuslt, while #3 is the fractional part.
	The remainder is from subtracting the original number #1 by the result of multing the integer part #2 with 7.
	Let #4 be the remainder, #4 equals #1-#2*7; #4=#1-#2*7.
	In the following calculation:
	1. Convert the random number from rand function to a single-precision float (s_float).
	2. Use the div command to divide by float 7.
	3. Convert the s_float to s_integer, which should only keep the integer part of it.
	4. Then convert the ineger back to s_float again, multiply by 7.
	5. Finally, subtract the original number by it to get the remainder. */

	vmov s1, r2	/* Bit copy from integer register r2 to s1 */
	vcvt.f32.s32 s1, s1 /* Converts s1 signed integer value to a single-precision value and stores it in s1 */

	mov r2, #7	 /* The goal is to generate 7 intege so the denominator is 7 */
	vmov s2, r2 	/* Bit copy from integer register r2 to s2 */
	vcvt.f32.s32 s2, s2 	/* Converts s2 signed integer value to a single-precision value and stores it in s2 */

	vdiv.f32 s3, s1, s2 /* s3 is the result of dividing by 7; s3=s1/s2 */

	vcvt.s32.f32 s3, s3 /* Converts s3 single-precision value to a signed integer and stores it in s3, in other words only keep the integer part of the float */
	vmov r3, s3 /*Bit copy from s3 to r3 */

	vmov s4, r3 /* Bit copy from integer register r3 to s4 */
	vcvt.f32.s32 s4, s4 /* Converts s4 signed integer value to a single-precision value and stores it in s4 */
	vmul.f32 s5, s4, s2 /* multiply the integer part of the float of division with float 7' s5=s4*s2 */
	vsub.f32 s6, s1, s5 /* subtract the integer part of the float of division will leave us the remainder; s6=s1*s5 */

	vcvt.s32.f32 s6, s6 /* Convert s6 single-precision value to a signed integer and stores it in s6 */
	vmov r1, s6 /* Bit copy from s6 to r1 */
	str r1, [r6, r4, lsl #2] /* store the integer into array */

	add r4, r4, #1 /* increase the loop counter by 1 */
check_loop_array:
	cmp r4, r5 /* compare with # of items */
	bne loop_array /* if not equal branch back */

	pop {r4, lr}
	bx lr
