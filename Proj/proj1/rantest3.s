/* -- randTest.s */
.data

@message: .asciz "The random function returned %d\n"

.text

.global rantest3
rantest3:
    push {lr}                 /* Push lr onto the top of the stack */

        mov r0,#0                    /* Set time(0) */
        bl time                      /* Call time */
        bl srand                     /* Call srand */
        bl rand                      /* Call rand */
        mov r1,r0,ASR #3             /* In case random return is negative */
	mov r3, #4
	mul r1, r1, r3
        mov r2,#7                   /* Move 90 to r2 */
                                         /* We want rand()%90+10 so cal divMod with rand()%90 */
        bl divMod                    /* Call divMod function to get remainder */
        add r1,#0                   /* Remainder in r1 so add 10 giving between 10 and 99 -> 2 digits */

        @ldr r0, address_of_message   /* Set &message2 as the first parameter of printf */
        @bl printf                    /* Call printf */
        pop {lr}                     /* Pop the top of the stack and put it in lr */
        bx lr                        /* Leave main */

@address_of_message: .word message

/*External Functions*/
@.global printf
.global time
.global srand
.global rand

