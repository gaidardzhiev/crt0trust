.section .text
.global _start
_start:
sub sp, sp, #16
mov r7, #112
swi 0
ldr r0, =dev_tty1
mov r1, #0
mov r7, #5
swi 0
mov r4, r0
mov r0, r4
mov r1, #0
mov r7, #63
swi 0
mov r0, r4
mov r1, #1
mov r7, #63
swi 0
mov r0, r4
mov r1, #2
mov r7, #63
swi 0
mov r0, r4
mov r7, #6
swi 0
mov r7, #2
swi 0
cmp r0, #0
beq c
bgt p
b exit
c:
ldr r0, =binsh
mov r1, sp
mov r2, #0
str r0, [sp]
mov r3, #0
str r3, [sp, #4]
mov r7, #11
swi 0
b exit
p:
mov r7, #1
mov r0, #0
swi 0
exit:
mov r7, #1
mov r0, #1
swi 0
.section .data
binsh:
.ascii "/bin/sh\0"
dev_tty1:
.ascii "/dev/tty1\0"
