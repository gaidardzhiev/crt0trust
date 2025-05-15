.section .text
.global _start
_start:
sub sp, sp, #16
ldr r0, =binsh
str r0, [sp]
mov r1, sp
mov r2, #0
mov r7, #11
swi 0
ldr r0, [sp]
mov r1, sp
bl main
mov r7, #1
swi 0
.section .data
binsh:
.ascii "/bin/sh\0"
