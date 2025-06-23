#!/bin/sh

W="/tmp/strace_output.log"
X="this is a verification script that uses strace to trace and analyze system calls and detect the execution of a reverse shell spawning payload injected by the compromised crt0.o"
Y="prepare the listener on a separate terminal: nc -l -p 4444"
Z="press ENTER once listener is ready..."

printf "%s\n\n" "$X" | pv -qL 30

printf "\n%s\n\n" "$Y" | pv -qL 30

printf "%s\n\n" "$Z" | pv -qL 30

read -r

strace -f -s 1000 -e trace=execve,socket,connect,dup2 -o "$W" ./reverse_shell &

P="$!"

sleep 10

kill "$P" 2>/dev/null

grep -E 'socket' "$W" && printf "socket syscall DETECTED...\n\n"

grep -E 'connect\(.*htons\([0-9]{2,5}\)' "$W" && printf "connect syscall DETECTED...\n\n"

grep -iE 'execve\(".*(/?(sh|zsh|bash|dash))"' "$W" && printf "execv syscall DETECTED...\n\n"

grep -E 'dup2\([0-9]+, ?[0-2]\)' "$W" && printf "dup2 syscall DETECTED...\n\n"

rm "$W"
