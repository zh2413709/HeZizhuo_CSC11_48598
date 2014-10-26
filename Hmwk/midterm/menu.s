.data
.balign 4
message1 : .asciz "\nCSC-11-Fall-48598-Midterm\n\nPlease Enter '1', '2',or '3' to choose program to run\n(1)Gross pay for employees\n(2)ISP packages\n(3)Fibonacci Sequence\n(4)Choose '0' to exit\n"
.balign 4
message2 : .asciz "You enter an unrecognized option \n"
.balign 4
scan_format : .asciz "%d"
.balign 4
msg :.asciz "You have entered %d "
.balign 4
read_switch : .word 0

.text
switch:
	push {lr}

	cmp r1, #0
	beq end_switch

	cmp r1, #1
	beq case1

	cmp r1, #2
	beq case2

	cmp r1, #3
	beq case3

	ldr r0, address_of_message2
	bl printf
end_switch:
	pop {lr}
	bx lr

case1:
	push {lr}
	ldr r0, address_of_msg
	bl printf
	bl gross_pay
	pop {lr}
	bx lr

case2:
        push {lr}
        ldr r0, address_of_msg
        bl printf
	bl package
        pop {lr}
        bx lr

case3:
        push {lr}
        ldr r0, address_of_msg
        bl printf
	bl fibonacci
        pop {lr}
        bx lr

.global main
main:
	push {lr}

switch_loop:
	ldr r0, address_of_message1
	bl printf

	ldr r0, address_of_scan_format
	ldr r1, address_of_read_switch
	bl scanf

	ldr r1, address_of_read_switch
	ldr r1, [r1]

	bl switch

	cmp r1, #0
	beq end

	b switch_loop

end:
	pop {lr}
	bx lr

address_of_message1 : .word message1
address_of_message2 : .word message2
address_of_scan_format : .word scan_format
address_of_read_switch : .word read_switch
address_of_msg : .word msg
.global printf
.global scanf
