.section .data
msg:
.ascii "/bin/dash\0"

argv:
.word msg
.word 0

.section .text
.global _start
_start:
    ldr r0, =msg
    ldr r1, =argv
    mov r2, #0

    mov r7, #11
    svc #0

    mov r0, #1
    mov r7, #1
    svc #0
