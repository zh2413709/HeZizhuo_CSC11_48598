.data
Half: .float 0.5
Pho: .float 0.002376
Vel: .float 200.0
Pi: .float 3.141592
Rad: .float 6.0
Conv: .float 0.00694
Cd: .float 0.4
thirty_two: .float 32.0

msg: .asciz "Floating Dynamic Pressure = %f lbs\nCross Sectional Area x32 = %f ft^2\nFloating Drag x 32 = %f lbs\n"

return: .word 0

.text
.global main
.func main
main:
	ldr r1, addr_return
	str lr, [r1]

	sub sp, sp, #24

	mov r6, #1 /*set up loop */
	ldr r7, =15000000 /* let the program loop 15000000 times */
loop:

	/* Dynp calculation */
	ldr r0, addr_Half
	vldr s14, [r0]
	vcvt.f64.f32 d0, s14

	ldr r0, addr_Pho
	vldr s15, [r0]
	vcvt.f64.f32 d1, s15

	ldr r0, addr_Vel
	vldr s16, [r0]
	vcvt.f64.f32 d2, s16

	vmul.f64 d4, d0, d1
	vmul.f64 d4, d2, d4
	vmul.f64 d4, d2, d4 @d4 has the value of Dynp

	/* Area calculation */
	ldr r0, addr_Pi
	vldr s14, [r0]

	ldr r0, addr_Rad
	vldr s15, [r0]

	ldr r0, addr_Conv
	vldr s16, [r0]

	vmul.f32 s14, s15, s14
	vmul.f32 s14, s15, s14
	vmul.f32 s14, s16, s14

	vcvt.f64.f32 d5, s14 @d5 has the value of Area

	/* Drag calculation */
	ldr r0, addr_Cd
	vldr s14, [r0] @s14 has the value of Cd as single
	vcvt.f64.f32 d7, s14 @d7 has the value of Cd as double

	vmul.f64 d6, d4, d5 @d6=d4*d5
	vmul.f64 d6, d7, d6 @d6*=d7 now d6 has the value of Drag

	/* prepare Area for display */
	ldr r0, addr_thirty_two
	vldr s14, [r0]
	vcvt.f64.f32 d8, s14 @d8 has value of 32.00

	vmul.f64 d5, d8, d5 @Area x 32

	vmul.f64 d6, d8, d6 @Drag x 32

	cmp r7, r6
	bgt scale


	/* now, d4= Dynp, d5 = Area x 32, d6 = Drag x 32 */
	ldr r0, =msg
	vmov r2, r3, d4
	vstr d5, [sp]
	vstr d6, [sp, #+8]
	bl printf
	add sp, sp, #24

	ldr r0, addr_return
	ldr lr, [r0]
	bx lr

scale:
	add r6, r6, #1
	b loop

addr_Half: .word Half
addr_Pho: .word Pho
addr_Vel: .word Vel
addr_Pi: .word Pi
addr_Rad: .word Rad
addr_Conv: .word Conv
addr_Cd: .word Cd
addr_thirty_two: .word thirty_two

addr_return: .word return
.global printf
