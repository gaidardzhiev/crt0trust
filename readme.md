# Introduction

 The purpose of this repository is to explore and demonstrate the concept of the "Trusting Trust" attack originally described by Ken Thompson in his seminal Turing Award lecture. Specifically, this project focuses on implementing a proof of concept backdoor embedded within the `crt0.s` startup assembly code, which spawns a hidden reverse shell upon program execution.
 This repository is intended for educational and research purposes only. It serves to illustrate the dangers of trusting compiled binaries and compilers without verifying their source code and build chain integrity.

# Background

 In 1984, Ken Thompson revealed a subtle and powerful attack vector where a compiler can be maliciously modified to insert backdoors into the binaries it compiles, including itself, thus perpetuating the backdoor even if source code appears clean. The "Trusting Trust" attack exploits the trust placed in the compiler and toolchain.
 This project revisits that idea by putting a reverse shell spawning payload directly into the C runtime startup assembly code responsible for initializing the program before `main()` is called. By doing so, any program linked with this modified `crt0.o` will execute the backdoor code before normal execution.

# Basic theory

 The "Trusting Trust" attack operates at a profoundly low level by subverting the compiler's binary itself to insert malicious code during the compilation process, creating a self propagating backdoor that escapes detection through source code inspection. At its core, the attack modifies the compiler so that when it compiles a hidden payload is injected directly into the generated machine code, even though the source code of the target program remains clean.
 More insidiously, the compromised compiler is also programmed to recognize when it is compiling its own source code and to insert the malicious injection into the newly compiled compiler binary, thereby perpetuating the backdoor indefinitely. This bootstrapping mechanism relies on the compiler's ability to detect compilation contexts and trigger payload insertion conditionally, effectively creating a binary level Trojan horse that cannot be eradicated by simply auditing or recompiling the compiler source.
 The attack transcends language or platform specifics because it manipulates the final code generation phase, typically at the assembly or machine code level. This level of subversion exploits implicit trust in the entire build chain, illustrating how a compromised toolchain can undermine system security from the ground up without leaving any trace in source repositories for traditional code reviews.

# How does it work

 Crt0 is a set of low level assembly execution startup routines linked first into every C program that sets up the runtime environment, initializes the stack, prepares argc, argv, and environment pointers and then calls the program’s `main()` function, acting as the very first code executed when the program starts. It generally takes the form of an object file called `crt0.o`, written in assembly language, which is automatically included by the linker into every executable file it builds.
 This malicious `crt0.s` contains assembly instructions that spawn a reverse shell before calling the program's `main()` function. When a program is compiled and linked with this `crt0.o`, the resulting binary will execute the shell spawning code immediately upon startup. This backdoor is invisible in the C source code of the program itself and resides solely in the startup assembly, illustrating how trust in the toolchain can be exploited.
 By compromising `crt0.o`, which is linked into every compiled user space program and runs before `main()`, an attacker effectively inserts a hidden payload that executes before the program’s logic, mirroring the self propagating and stealthy nature of the original trusting trust attack.

# Contents

- **crt0.s**
a minimal armv8l 32-bit linux C runtime startup example that demonstrates how a backdoor reverse shell could be introduced at the lowest level of program initialization

- **main.c**
dummy program to test the backdoor injection and execution

- **verify.sh**
verification script that uses strace to trace and analyze system calls and detect the execution of the reverse shell spawning payload injected by the compromised `crt0.o`

- **Makefile**
build instructions

# References

- Ken Thompson "Reflections on Trusting Trust" Communications of the ACM, Volume 27, Issue 8, August 1984

- Karger, P.A., and Schell, R.R. Multics Security Evaluation: Vulnerability Analysis. ESD-TR-74-193, Vol II, June 1974, p 52.

# Disclamer

 This repository and its contents are provided solely for educational, research, and awareness purposes to illustrate the risks associated with compromised compilers and toolchains. The techniques demonstrated herein involve creating and exploiting backdoors at a low level in software build processes, which can
cause serious security breaches if misused.
 Unauthorized use, distribution, or deployment of these methods against systems, networks, or software without explicit permission is illegal, unethical, and strictly prohibited! The author assume no responsibility for any damages, legal consequences, or harm resulting from misuse of this material.
 Users are strongly encouraged to apply this knowledge responsibly, within controlled environments, and to promote improved security practices and awareness in software development and supply chain integrity.
