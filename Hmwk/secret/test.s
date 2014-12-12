/* Example code to calculate the dynamic pressure 
   Dr. Mark E. Lehr
   December 1st, 2014  */
   
.data
vel:         .float 0        @Velocity (ft/sec)
half:        .float 0.5      @Just 1/2 constant
rho:         .float 600  @Density  slugs/ft^3
dynP:        .float 0        @Dynamic Pressure (lbs/ft^2)
msg_vel_in:  .asciz "Enter the Velocity in (ft/sec) \n"
msg_vel_out: .asciz "The Velocity = %f (ft/sec) \n"
fmt_flt:     .asciz "%f"

/* Start Main */
.text
.global main 
.func main 
main: 
	push {r4,lr}           @ Align with 8 bytes

	/* Prompt for the Velocity */
	ldr r0,ad_msg_vel_in   @Message for velocity input
	bl printf

	/* Input the Velocity */
	ldr r0,ad_fmt_flt      @Single float format
	ldr r1,ad_vel          @Load the velocity address
	bl scanf               @Store value in the velocity address

	/* Test Convert the Velocity to a double format */
	ldr  r1,ad_vel
	vldr s0,[r1]
	ldr r1, =half
	vldr s1, [r1]
	ldr r1, =rho
	vldr s2, [r1]
	mov r4, #0
	b check_loop
loop:
	vdiv.f32 s4, s0, s2 /* s6 = s1/s2; S/xi */
	vadd.f32 s4, s4, s2 /* s6+= s2; xi + S/xi */
	vmul.f32 s4, s4, s1 /* s6*=s3; (1/2)*(x0 + S/xi) */
	vcvt.f64.f32 d10,s4
	vmov s2, s4
	add r4, r4, #1
check_loop:
	cmp r4, #10
	bne loop
	/* Output the Velocity in double format */
	ldr r0,ad_msg_vel_out
	vmov r2,r3,d10
	bl printf

	/* Exit stage right */
	pop {r4,lr}
	bx lr

.global printf
.global scanf

ad_msg_vel_in: .word msg_vel_in
ad_msg_vel_out:.word msg_vel_out
ad_fmt_flt:    .word fmt_flt
ad_vel:        .word vel
ad_half:       .word half
ad_rho:        .word rho
ad_dynP:       .word dynP
