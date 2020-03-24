section .data
mes1: db "Enter Radius :"
len1: equ $-mes1
mes2: db "The area is :"
len2: equ $-mes2
format1: db "%lf" ,0
format2: db "%lf" ,10
float2 : dq 1
floatd : dq 2
newline: dw 10

section .bss
float1: resq 1
floatn: resq 1
y: resq 1
x: resq 1
count: resw 1

section .text
global main:
extern scanf
extern printf

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

main:

mov eax,4
mov ebx,1
mov ecx,mes1
mov edx,len1
int 80h
call read_float
fstp qword[float1]
fld qword[float1]
fstp qword[x]
fild qword[float2]
fstp qword[y]
mov word[count],0
fldz
loop1:
    
    inc word[count]
    fld qword[x]
    fadd qword[y]
    fild qword[floatd]
    fxch ST1
    fdiv ST1
    call print_float
    fstp qword[x]
    fld qword[float1]
    fdiv qword[x]
    fstp qword[y]
    cmp word[count],1000
    jb loop1

fldz
;call print_float
EXIT:
mov eax, 1
mov ebx, 0
int 80h

