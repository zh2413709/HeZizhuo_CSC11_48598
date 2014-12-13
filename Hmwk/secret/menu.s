.data
@.align 4
message1 : .asciz "\nCSC-11-Fall-48598-Final\n\nPlease Enter '1', '2', '3', or '4' to choose program to run\n(1)'Guess the Number' game\n(2)Future Value\n(3)Square Root Function\n(4)Quadratic Equation\n(*)Choose '0' to exit!\n"
@.align 4
message2 : .asciz "You entered invalid option \n"
@.align 4
scan_format : .asciz "%d"
@.align 4
msg :.asciz "You have entered %d "
@.align 4
read_switch : .word 0


switch:
	push {r4, lr}

	cmp r1, #0
	beq end_switch

	cmp r1, #1
	beq case1

	cmp r1, #2
	beq case2

	cmp r1, #3
	beq case3

	cmp r1, #4
	beq case4

	ldr r0, =message2
	bl printf
end_switch:
	pop {r4, lr}
	bx lr

case1:
	ldr r0, =msg
	bl printf
	bl guess
	b end_switch
case2:
        ldr r0, =msg
        bl printf
	bl future
	b end_switch
case3:
        ldr r0, =msg
        bl printf
	bl square
        b end_switch
case4:
        ldr r0, =msg
        bl printf
	bl quadratic
        b end_switch
.text
.global main
main:
	push {r4, lr}

switch_loop:
	ldr r0, =message1
	bl printf

	ldr r0, =scan_format
	ldr r1, =read_switch
	bl scanf

	ldr r1, =read_switch
	ldr r1, [r1]

	bl switch

	cmp r1, #0
	beq end

	b switch_loop

end:
	pop {r4, lr}
	bx lr
