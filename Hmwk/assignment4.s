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
/*division function*/
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
        mov r4, r4, lsl#1 /*sclae factor*/
        mov r5, r5, lsl#1 /*subtraction factor*/
        cmp r1, r5 
        bge scaleLeft     /*end loop at overshoot*/
	mov r4, r4, lsr#1 /*scale factor back*/
	mov r5, r5, lsr#1 /*scale subtraction factor back*/
addSub:
        add r0, r0, r4    /*count the subtracted scale factor*/
        sub r1, r1, r5    /*subtract the scaled mod*/
scaleRight:               /*shift right until just under the remainder*/
        mov r4, r4, lsr#1
        mov r5, r5, lsr#1
        cmp r1, r5
        bmi scaleRight
        cmp r4, #1
        bge addSub        /*loop until division is complete*/
end:
	ldr lr, address_of_return2
	ldr lr, [lr]
	bx lr			/*return from main using lr*/
address_of_return2 : .word return2
case_equal:
        mov r0, #1
        b end

.global main
main:
	ldr r1, address_of_return
	str lr, [r1]

	ldr r0, address_of_message1      /*desplay the first message*/
	bl printf                        /*call to printf*/

	/* read the first input # */
	ldr r0, address_of_scan_pattern
	ldr r1, address_of_number_read1
	bl scanf

	ldr r0, address_of_message2  	/*desplay the second message*/
	bl printf			/*call to printf*/

	/* read the second input # */
	ldr r0, address_of_scan_pattern
	ldr r1, address_of_number_read2
	bl scanf

	/* store the two inputs into registers */
	ldr r0, address_of_number_read1
	ldr r2, [r0]
	ldr r0, address_of_number_read2
	ldr r3, [r0]
	bl division /* call the function */

	mov r3, r0 /*contains the value of the counters of the division*/
	mov r6, r1 /*contains the value of the remainder of the division*/
	ldr r1, address_of_number_read1 /*reload the first input #*/
	ldr r1, [r1]
	ldr r2, address_of_number_read2 /*reload the second input #*/
	ldr r2, [r2]
	ldr r0, address_of_message3 /*display the third message*/
	bl printf  /*call to printf*/

	mov r1, r6 /*move the remainder back to r1*/
	ldr r0, address_of_message4 /*desplay message4*/
	bl printf /*call to printf*/

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
