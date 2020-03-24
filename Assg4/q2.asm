section .data
mes1: db "Enter Radius :"
len1: equ $-mes1
mes2: db "The area is :"
len2: equ $-mes2
format1: db "%lf" ,0
format2: db "%lf" ,10
float2 : dq 1
newline: dw 10

section .bss
float1: resq 1

section .text
global main:
extern scanf
extern printf

main:

mov eax,4
mov ebx,1
mov ecx,mes1
mov edx,len1
int 80h
call read_float
;call print_float
fstp qword[float1]
fld qword[float1]
;fild qword[float2]
fldpi
fmul ST1
fmul ST1

mov eax,4
mov ebx,1
mov ecx,mes2
mov edx,len2
int 80h
call print_float

ffree ST0
ffree ST1
ffree ST2
EXIT:mov eax, 1
mov ebx, 0
int 80h

read_float:
push ebp
mov ebp, esp
sub esp, 8
lea eax, [esp]
push eax
push format1
call scanf
fld qword[ebp - 8]
mov esp, ebp
pop ebp
ret

print_float:
push ebp
mov ebp, esp
sub esp, 8
fst qword[ebp - 8]
push format2
call printf
mov esp, ebp
pop ebp
ret

print_newline:
pusha
mov eax, 4
mov ebx, 1
mov ecx, newline
mov edx, 1
int 80h
popa
ret