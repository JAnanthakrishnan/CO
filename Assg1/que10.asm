section .data 
newline: db 10
get1: db 'Enter first side:'
get1_s : equ $-get1
get2: db 'Enter second side:'
get2_s : equ $-get2
print1: db 'The perimetre is :'
print1_s: equ $-print1
print2: db 'The area is :'
print2_s: equ $-print2

section .bss 
num1:resw 10
num2: resw 10
temp:resb 10
num:resw 10
nod:resb 10
count:resb 10

section .text 
global _start
_start:
mov eax,4
mov ebx,1
mov ecx,get1
mov edx,get1_s
int 80h
call  read_num 
mov cx,word[num] 
mov word[num1],cx 
mov eax,4
mov ebx,1
mov ecx,get2
mov edx,get2_s
int 80h
call  read_num 
mov cx,word[num] 
mov word[num2],cx 
mov ax,word[num1] 
mov bx,word[num2]

add ax,bx
mov cx,2
mul cx
mov word[num],ax
mov eax,4
mov ebx,1
mov ecx,print1
mov edx,print1_s
int 80h
call print_num

mov ax,word[num1]
mov bx,word[num2]
mul bx
mov word[num],ax
mov eax,4
mov ebx,1
mov ecx,print2
mov edx,print2_s
int 80h
call print_num



;exit:
mov eax,1 
mov ebx,0 
int 80h

read_num:
pusha
mov word[num], 0
loop_read:
mov eax,3
mov ebx,0
mov ecx,temp
mov edx,1
int 80h
cmp byte[temp], 10
je end_read
mov ax,word[num]
mov bx, 10
mul bx
mov bl, byte[temp]
sub bl, 30h
mov bh, 0
add ax, bx
mov word[num],ax
jmp loop_read
end_read:
popa
ret

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
mov ebx,1;
mov ecx,newline
mov edx,1
int 80h
popa
ret

