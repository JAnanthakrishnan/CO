section .bss
temp resb 1
num resw 1
count resw 1
n resd 1
row resd 1
column resd 1
array resw 50
array1 resw 50
array2 resw 50
array3 resw 50
j resd 1
key resw 1
temp1 resd 1


section .data
sizer: db 'Enter the row size :'
sizer_s: equ $-sizer
sizec: db 'Enter the column size :'
sizec_s: equ $-sizec
insr: db 'Enter the matrix :'
insr_s: equ $-insr
prn: db 'The entered array is :'
prn_s: equ $-prn
newline: db 10
space: db 32

section .text
global _start
_start:
mov eax,4
mov ebx,1
mov ecx,sizer
mov edx,sizer_s
int 80h
call read_num
mov ax,word[num]
mov word[row],ax
mov eax,4
mov ebx,1
mov ecx,sizec
mov edx,sizec_s
int 80h
call read_num
mov ax,word[num]
mov word[column],ax
mov eax,4
mov ebx,1
mov ecx,insr
mov edx,insr_s
int 80h
call read_matrix
mov eax,4
mov ebx,1
mov ecx,prn
mov edx,prn_s
int 80h
call print_matrix
;call insertion_sort
;call print_array

mov eax,1
mov ebx,0
int 80h

read_num:
pusha
mov word[num],0
loop_read:
mov eax,3
mov ebx,0
mov ecx,temp
mov edx,1
int 80h
cmp byte[temp],10
je end_read
cmp byte[temp],32
je end_read
mov ax,word[num]
mov bx,10
mul bx
mov bl,byte[temp]
sub bl,30h
mov bh,0
add ax,bx
mov word[num],ax
jmp loop_read
end_read:
popa
ret


print_num:
pusha
mov word[count],0
extract_num:
cmp word[num],0
je print
inc word[count]
mov dx,0
mov ax,word[num]
mov bx,10
div bx
push dx
mov word[num],ax
jmp extract_num
print:
cmp word[count],0
je end_print
dec word[count]
pop dx
add dl,30h
mov byte[temp],dl
mov eax,4
mov ebx,1
mov ecx,temp
mov edx,1
int 80h
jmp print
end_print:
mov eax,4
mov ebx,1
mov ecx,space
mov edx,1
int 80h
popa
ret

read_array:
pusha
mov eax,0
array_read:
cmp eax,dword[n]
je end_array
call read_num
mov cx,word[num]
mov word[array+2*eax],cx
inc eax
jmp array_read
end_array:
popa
ret

print_array:
pusha
mov eax,0
array_print:
cmp eax,dword[n]
je end_arrayp
mov cx,word[array+2*eax]
mov word[num],cx
call print_num
inc eax
jmp array_print
end_arrayp:
mov eax,4
mov ebx,1
mov ecx,newline
mov edx,1
int 80h
popa
ret


insertion_sort:
pusha
mov eax,1
main_loop:
mov bx,word[array+2*eax]
mov word[key],bx
mov dword[j],eax
dec dword[j]
sub_loop:
cmp word[j],0
jb next
mov cx,word[key]
mov ebx,dword[j]
cmp word[array+2*ebx],cx
jna next
mov ebx,dword[j]
mov cx,word[array+2*ebx]
mov word[array+2*ebx+2],cx
dec dword[j]
jmp sub_loop
next:
mov cx,word[key]
mov ebx,dword[j]
mov word[array+2*ebx+2],cx
inc eax
cmp eax,dword[n]
jb main_loop
end_insertion:
popa
ret

read_matrix:
pusha
mov eax,0
loop1:
mov ebx,0
    loop2:
    mov dword[temp1],eax
    mov ecx,dword[column]
    mul ecx
    call read_num
    mov dx,word[num]
    add eax,ebx
    mov word[array+2*eax],dx
    mov eax,dword[temp1]
    inc ebx
    cmp ebx,dword[column]
    jb loop2
inc eax
cmp eax,dword[row]
jb loop1
popa
ret

print_matrix:
pusha
mov eax,4
mov ebx,1
mov ecx,newline
mov edx,1
int 80h
mov eax,0
_loop1:
mov ebx,0
    _loop2:
    mov dword[temp1],eax
    mov ecx,dword[column]
    mul ecx
    add eax,ebx
    mov dx,word[array+2*eax]
    mov word[num],dx
    call print_num
    mov eax,dword[temp1]
    inc ebx
    cmp ebx,dword[column]
    jb _loop2
pusha
mov eax,4
mov ebx,1
mov ecx,newline
mov edx,1
int 80h
popa
inc eax
cmp eax,dword[row]
jb _loop1
popa
ret

