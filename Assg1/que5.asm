
section .data 
newline: db 10
get1: db 'Enter the number: '
get1_s : equ $-get1
print1: db 'The number is a palindrome',0Ah
ps1:equ $-print1
print2: db 'The number is a not a palindrome',0Ah
ps2:equ $-print2


section .bss 
num1:resw 10
num2 resw 10
temp:resb 10
tempnew: resw 10
num:resw 10
pov:resw 10
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
mov ax,word[num]
mov word[num1],ax

call reverse_num
mov bx,word[num]
mov word[num2],bx

mov ax,word[num1]

mov bx,word[num2]

cmp ax,bx
jne exit
mov eax,4
mov ebx,1
mov ecx,print1
mov edx,ps1
int 80h
mov eax,1 
mov ebx,0 
int 80h

exit:
mov eax,4
mov ebx,1
mov ecx,print2
mov edx,ps2
int 80h
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


reverse_num:
mov byte[count],0
pusha
extract:
cmp word[num],0
je initial
inc byte[count]
mov dx,0
mov ax,word[num]
mov bx,10
div bx
push dx
mov word[num],ax
jmp extract
initial:
mov word[num],0
mov word[pov],1
rev_no:
cmp byte[count], 0
je end
dec byte[count]
pop dx
mov word[tempnew],dx
mov ax,word[tempnew]
mov bx,word[pov]
mul bx
mov cx,word[num]
add ax,cx
mov word[num],ax
mov ax,word[pov]
mov bx,10
mul bx
mov word[pov],ax
jmp rev_no

end:
popa
ret












