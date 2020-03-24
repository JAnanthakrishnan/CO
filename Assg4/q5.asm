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
pal: db "The string is a palindrome",10
pal_s: equ $-pal
npal: db "The string is not a palindrome",10
npal_s: equ $-npal
newline: db 10
space: db 32

section .bss
string:  resb 50
temp: resb 1
n: resd 1
num: resw 1
count: resb 1
counter: resb 1
output: resb 1

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
mov ecx,ebx
movzx eax,byte[stringlen]
add ecx,eax
dec ecx
movzx eax,byte[stringlen]
dec eax
mov word[counter],0
palind:
pusha
inc word[counter]
mov al,byte[ebx]
mov dl,byte[ecx]
cmp al,dl
jne notpalind
popa
inc ebx
dec ecx
cmp word[counter],ax
jb palind
mov eax,4
mov ebx,1
mov ecx,pal
mov edx,pal_s
int 80h
jmp exit
notpalind:
popa
mov eax,4
mov ebx,1
mov ecx,npal
mov edx,npal_s
int 80h







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

print_byte:
pusha
mov eax,4
mov ebx,1
mov ecx,output
mov edx,1
int 80h
mov eax,4
mov ebx,1
mov ecx,space
mov edx,1
int 80h
popa
ret






