/*
the program first calls fork syscall to create a child process
 the child then calls setsid syscall to start a new session
 and forks again to create a grandchild that executes /bin/dash via
 execve syscall the child process immediately exits using exit
 syscall #1 to avoid zombies the original parent waits for the child
 and finally calls main before exiting effectively spawning a detached
 shell process through a double-fork and session detachment technique
*/

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
	and sp, sp, #0xFFFFFFF8
	ldr r4,[sp]
	add r5,sp,#4
	ldr r5,[r5]
	add r6,sp,#8
	ldr r6,[r6]
	mov r7,#2
	svc #0
	cmp r0,#0
	bgt x
p:
	mov r0,#0
	mov r7,#112
	svc #0
	mov r7,#2
	svc #0
	cmp r0,#0
	bgt e
q:
	ldr r0,=b
	ldr r1,=a
	mov r2,#0
	mov r7,#11
	svc #0
	mov r0,#1
	mov r7,#1
	svc #0
e:
	mov r0,#0
	mov r7,#1
	svc #0
x:
	mov r0,r4
	mov r1,r5
	mov r2,r6
	bl main
	mov r7,#1
	svc #0
