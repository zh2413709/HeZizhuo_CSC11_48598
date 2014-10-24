.data
.balign 4
message1 : .asciz "Hey, tell me how many hours have you worked:"
.balign 4
message2 : .asciz "How much do you get paid for each hour:"
.balign 4
message3 : .asciz "You worked %d hr,you are paid $ %d per-hr, and your grosspay is $ %d\n"
.balign 4
message4 : .asciz "You are working too much!"
.balign 4
scan_pattern : .asciz "%d"
.balign 4
number_read1 : .word 0
.balign 4
number_read2 : .word 0

.text
calculation:
	push {lr}

	cmp r1, #60
	ble lesser_equal_sixty_hours
end:
	pop {lr}
	bx lr
lesser_equal_sixty_hours:
	cmp r1, #40
	ble lesser_equal_forty_hours
	mul r3, r1, #3
	sub r3, r3, #60
	mul r3, r2, r3
	b end
lesser_equal_forty_hours:
	cmp r1, #20
	ble lesser_equal_twenty_hours
	mul r3, r1, #2
	sub r3, r3, #20
	mul r3, r2, r3
	b end
lesser_euqal_twenty_hours:
	mul r3, r1, r2
	b end 
.global gross_pay
gross_pay:
	push {lr}

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
        ldr r1, [r0]
        ldr r0, address_of_number_read2
        ldr r2, [r0]
        bl calculation

	ldr r1, address_of_number_read1
	ldr r1, [r1]
	cmp r1, #60
	bgr work_too_much

	ldr r0, address_of_message3
	bl printf

	pop {lr}
	bx lr
work_too_much:
	ldr r0, address_of_message4
	printf
	b gross_pay

address_of_message1 : .word message1
address_of_message2 : .word message2
address_of_message3 : .word message3
address_of_message4 : .word message4
address_of_scan_pattern : .word scan_pattern
address_of_number_read1 : .word number_read1
address_of_number_read2 : .word number_read2

.global printf
.global scanf
