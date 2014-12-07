.data
.text
.global init_array
init_array:
	push {r4, lr}

	mov r4, #0
	mov r6, r1
	mov r5, r0

	mov r0,#0                    /* Set time(0) */
    	bl time                      /* Call time */
	bl srand                     /* Call srand */

	b check_loop_array
loop_array:
	bl rand                      /* Call rand */
	mov r2, r0, lsr #7             /* Left shit r0 7 times to make sure the float does not overflow */
	
	vmov s1, r2
	vcvt.f32.s32 s1, s1

	mov r2, #7
	vmov s2, r2
	vcvt.f32.s32 s2, s2

	vdiv.f32 s3, s1, s2

	vcvt.s32.f32 s3, s3
	vmov r3, s3

	vmov s4, r3
	vcvt.f32.s32 s4, s4
	vmul.f32 s5, s4, s2
	vsub.f32 s6, s1, s5

	vcvt.s32.f32 s6, s6
	vmov r1, s6

	str r1, [r6, r4, lsl #2]

	add r4, r4, #1
check_loop_array:
	cmp r4, r5
	bne loop_array

	pop {r4, lr}
	bx lr
