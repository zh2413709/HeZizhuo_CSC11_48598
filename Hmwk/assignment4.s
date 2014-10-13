.data
.balign 4
message1 : .asciz "Hey, type a number as numerator:"
.balign 4
message2 : .asciz "Now, type a number as denominator:"
.balign 4
message3 : .asciz "%d divide by %d is %d\n"
.balign 4
message4 : .asciz "The remainder is %d\n"
.balign 4
scan_pattern : .asciz "%d"
.balign 4
number_read1 : .word 0
.balign 4
number_read2 : .word 0
.balign 4
return : .word 0
.balign 4
return2 : .word 0

.text
division:
	ldr r1, address_of_return2
	str lr, [r1]

        mov r0, #0
        mov r4, #1
        mov r5, r3
        mov r1, r2
divMod:
        cmp r1, r3
        beq case_equal
        bmi end @end it if r1<r3
scaleLeft:
        mov r4, r4, lsl#1 @division counter
        mov r5, r5, lsl#1 @Mod/Remainder subtraction
        cmp r1, r5
        bge scaleLeft
	mov r4, r4, lsr#1
	mov r5, r5, lsr#1
addSub:
        add r0, r0, r4
        sub r1, r1, r5
scaleRight:
        mov r4, r4, lsr#1
        mov r5, r5, lsr#1
        cmp r1, r5
        bmi scaleRight
        cmp r4, #1
        bge addSub
end:
	ldr lr, address_of_return2
	ldr lr, [lr]
	bx lr
address_of_return2 : .word return2
case_equal:
        mov r0, #1
        b end

.global main
main:
	ldr r1, address_of_return
	str lr, [r1]

	ldr r0, address_of_message1
	bl printf

	ldr r0, address_of_scan_pattern
	ldr r1, address_of_number_read1
	bl scanf

	ldr r0, address_of_message2
	bl printf

	ldr r0, address_of_scan_pattern
	ldr r1, address_of_number_read2
	bl scanf

	ldr r0, address_of_number_read1
	ldr r2, [r0]
	ldr r0, address_of_number_read2
	ldr r3, [r0]
	bl division

	mov r3, r0
	mov r6, r1
	ldr r1, address_of_number_read1
	ldr r1, [r1]
	ldr r2, address_of_number_read2
	ldr r2, [r2]
	ldr r0, address_of_message3
	bl printf

	mov r1, r6
	ldr r0, address_of_message4
	bl printf

	ldr lr, address_of_return
	ldr lr, [lr]
	bx lr
address_of_message1 : .word message1
address_of_message2 : .word message2
address_of_message3 : .word message3
address_of_message4 : .word message4
address_of_scan_pattern : .word scan_pattern
address_of_number_read1 : .word number_read1
address_of_number_read2 : .word number_read2
address_of_return :.word return

.global printf
.global scanf
