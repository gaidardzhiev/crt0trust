#!/bin/sh

MSG="this is a verification script that uses strace to trace and analyze system calls and detect the execution of a reverse shell spawning payload injected by the compromised crt0.o"
NC="prepare the listener on a separate terminal: nc -l -p 4444"
LOG="/tmp/strace_output.log"

printf "%s\n\n" "$MSG" | pv -qL 30

printf "\n%s\n\n" "$NC" | pv -qL 30

printf "press ENTER once listener is ready...\n\n"

read -r

strace -f -s 1000 -e trace=execve,socket,connect,dup2 -o "$LOG" ./reverse_shell &

STRACE_PID="$!"

sleep 10

kill "$STRACE_PID" 2>/dev/null

grep -E 'socket' "$LOG" && printf "socket syscall DETECTED...\n\n"

grep -E 'connect\(.*htons\([0-9]{2,5}\)' "$LOG" && printf "connect syscall DETECTED...\n\n"

grep -iE 'execve\(".*(/?(sh|bash|zsh|nc|netcat|python|perl|ruby))"' "$LOG" && printf "execvsyscall DETECTED...\n\n"

grep -E 'dup2\([0-9]+, ?[0-2]\)' "$LOG" && printf "dup2 syscall DETECTED...\n\n"

rm "$LOG"
