#!/bin/sh

TODO="write a verification script that uses strace to trace and analyze system calls and detect the execution of a reverse shell spawning payload injected by the compromised crt0.o"

NC="on a separate terminal prepare the listener: nc -l -o 4444"

REV="execute the reverse shell and analyze the syscalls: strace ./reverse_shell"

printf "%s\n\n" "$TODO"

printf "%s\n\n" "$NC"

printf "%s\n\n" "$REV"
