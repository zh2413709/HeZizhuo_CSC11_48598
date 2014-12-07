.data
msg2: .asciz "the number is: %d\n"

.text
.global main
main:
	push {lr}

	mov r0,#0                    /* Set time(0) */
    	bl time                      /* Call time */
	bl srand                     /* Call srand */
	bl rand                      /* Call rand */
	mov r2,r0, lsr #7             /* In case random return is negative */

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
	ldr r0, =msg2
	bl printf

	pop {lr}
	bx lr
.global printf
.global scanf
.global time
.global srand
.global rand

