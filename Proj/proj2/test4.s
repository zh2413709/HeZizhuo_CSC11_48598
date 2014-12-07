.data

.align 4
msg: .asciz "The number is: %d\n"
.align 4
array: .skip 16

.text
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
	mov r2, r0, lsr #10             /* In case random return is negative */
@	mov r3, r4, lsl #2
@	add r2, r2, r3

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

print_array:
	push {r4, r5, r6, lr}

	mov r4, #0
	mov r5, r0
	mov r6, r1
	b check_loop_print_array
loop_print_array:
	ldr r0, =msg
	ldr r1, [r6, r4, lsl #2]
	bl printf

	add r4, r4, #1
check_loop_print_array:
	cmp r4, r5
	bne loop_print_array

	pop {r4, r5, r6, lr}
	bx lr

.global main
main:
	push {r4, lr}

	mov r0, #3
	ldr r1, =array
	bl init_array

	mov r0, #3
	ldr r1, =array
	bl print_array

	pop {r4, lr}
	bx lr

.global printf
.global scanf
.global time
.global srand
.global rand

