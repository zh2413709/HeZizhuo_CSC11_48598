.data
.balign 4
spot1 : .word 0
.balign 4
spot2 : .word 0
.balign 4
spot3 : .word 0
.balign 4
msg : .asciz "The  numbers are: %d %d %d\n "

.text
.balign 4
.global main
main:
 	push {lr}

	bl rantest1
	ldr r0, addr_of_spot1
	str r1, [r0]

	bl rantest2
        ldr r0, addr_of_spot2
        str r1, [r0]

	bl rantest3
        ldr r0, addr_of_spot3
        str r1, [r0]

	ldr r0, addr_of_msg
	ldr r1, addr_of_spot1
	ldr r1, [r1]
	ldr r2, addr_of_spot2
	ldr r2, [r2]
	ldr r3, addr_of_spot3
	ldr r3, [r3]
	bl printf

	pop {lr}
	bx lr
addr_of_spot1 : .word spot1
addr_of_spot2 : .word spot2
addr_of_spot3 : .word spot3
addr_of_msg : .word msg
.global printf
