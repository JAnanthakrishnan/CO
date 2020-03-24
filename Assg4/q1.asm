section .data
acnt:  db 0
scnt:  db 0
wcnt:  db 0
dcnt:  db 0
stringlen:  db 0
msg1:  db "Enter a string :  "
size1:  equ $-msg1
msga:  db  "No: of Alphabets is  : "
sizea:  equ $-msga
msgs:  db "No: of special characters are : "
sizes:  equ $-msgs
msgw:  db "No: of words are : "
sizew:  equ $-msgw
msgd:  db  "No: of digits in the string are : "
sized: equ $-msgd
newline: db 10

section .bss
string:  resb 50
temp: resb 1
n: resd 1
num: resw 1
count: resb 1

section .text
global _start
_start:
mov eax,4
mov ebx,1
mov ecx,msg1
mov edx,size1
int 80h
mov ebx,string

reading:
push ebx
mov eax,3
mov ebx,0
mov ecx,temp
mov edx,1
int 80h
pop ebx
cmp byte[temp],10
je end_reading
inc byte[stringlen]
mov al,byte[temp]
mov byte[ebx],al
inc ebx
jmp reading

end_reading:
mov byte[ebx],0
mov ebx,string

counting:
mov al,byte[ebx]
cmp al, 0
je end_counting
cmp al,97
jnb check122
c1:
cmp al,65
jnb check90
c2:
cmp al,48
jnb check57
c3:
cmp al,32
je inc_wcnt
next:
inc ebx
jmp counting

check90:
cmp al,90
jna inc_acnt
jmp c2

check122:
cmp al,122
jna inc_acnt
jmp c1

check57:
cmp al,57
jna inc_dcnt
jmp c3

inc_acnt:
inc byte[acnt]
jmp next

inc_dcnt:
inc byte[dcnt]
jmp next

inc_wcnt:
inc byte[wcnt]
jmp next

end_counting:
inc byte[wcnt]
mov eax,4
mov ebx,1
mov ecx,msga
mov edx,sizea
int 80h
movzx ax,byte[acnt]
mov word[num],ax
call print_num

mov eax,4
mov ebx,1
mov ecx,msgd
mov edx,sized
int 80h
movzx ax,byte[dcnt]
mov word[num],ax
call print_num


mov eax,4
mov ebx,1
mov ecx,msgs
mov edx,sizes
int 80h
movzx ax,byte[acnt]
movzx bx,byte[wcnt]
movzx cx,byte[dcnt]
movzx dx,byte[stringlen]
sub dx,cx
sub dx,bx
sub dx,ax
mov word[num],dx
inc word[num]
call print_num

mov eax,4
mov ebx,1
mov ecx,msgw
mov edx,sizew
int 80h
movzx ax,byte[wcnt]
mov word[num],ax
call print_num

exit:
mov eax,1
mov ebx,0
int 80h


print_num:
mov byte[count],0
pusha
extract_num:
cmp word[num],0
je print_no
inc byte[count]
mov dx,0
mov ax,word[num]
mov bx,10
div bx
push dx
mov word[num],ax
jmp extract_num
print_no:
cmp byte[count], 0
je end_print
dec byte[count]
pop dx
mov byte[temp],dl
add byte[temp],30h
mov eax, 4
mov ebx, 1
mov ecx, temp
mov edx, 1
int 80h
jmp print_no

end_print:
mov eax,4
mov ebx,1
mov ecx,newline
mov edx,1
int 80h
popa
ret






