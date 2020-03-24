section .bss
var: resb 1

section .data


section .text
global _start:
_start:
mov eax,3
mov ebx,0
mov ecx,var
mov edx,1
int 80h
sub byte[var],30h

mov eax,4
mov ebx,1
add byte[var],30h
mov ecx,var
mov edx,1
int 80h

mov eax,1
mov ebx,0
int 80h

