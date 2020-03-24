section .bss
nod: resb 1
num: resw 1
temp: resb 1
counter: resw 1
num1: resw 1
num2: resw 1
smallest: resw 1
largest: resw 1
average: resw 1
count_avg: resw 1
element: resw 1
n: resd 10
array: resw 50
matrix: resw 1
count: resb 10

section .data 
newline: db 10
ensize: db 'Enter the size of array :'
ensize_s:equ $-ensize
enarr: db 'Enter the array : '
enarr_s:equ $-enarr
prnarr: db 'The entered array is : '
prnarr_s: equ $-prnarr
avg: db 'The average is :'
avg_s: equ $-avg
abv_avg:db 'The number of elements above average is :'
abv_s: equ $-abv_avg
elem:db 'Enter the element to be searched :'
elem_s: equ $-elem
small:db 'The smallest element in the array : ' 
small_s:equ $-small
large:db 'The largest element in the array : '
large_s:equ $-large
space: db 32


section .text
global _start
_start:
mov eax, 4
mov ebx, 1
mov ecx, ensize
mov edx, ensize_s
int 80h
call read_num
mov cx,word[num]
mov word[n],cx
mov eax, 4
mov ebx, 1
mov ecx, enarr
mov edx, enarr_s
int 80h
mov ebx,array
mov eax,0
call read_array

mov ebx,array
mov eax,0
mov dx,word[ebx+2*eax]
mov word[largest],dx

linear:
cmp eax,dword[n]
je prn
mov dx,word[ebx+2*eax]
cmp dx,word[largest]
ja endlinear
inc eax
jmp linear
endlinear:
mov word[largest],dx
jmp linear

prn:
mov eax,4
mov ebx,1;
mov ecx,large
mov edx,large_s
int 80h
mov ax,word[largest]
mov word[num],ax
call print_num
mov eax,4
mov ebx,1;
mov ecx,newline
mov edx,1
int 80h

mov ebx,array
mov eax,0
mov dx,word[ebx+2*eax]
mov word[smallest],dx

linear1:
cmp eax,dword[n]
je prn1
mov dx,word[ebx+2*eax]
cmp dx,word[smallest]
jb endlinear1
inc eax
jmp linear1
endlinear1:
mov word[smallest],dx
jmp linear1

prn1:
mov eax,4
mov ebx,1;
mov ecx,small
mov edx,small_s
int 80h
mov ax,word[smallest]
mov word[num],ax
call print_num



exit:
mov eax,4
mov ebx,1;
mov ecx,newline
mov edx,1
int 80h
mov eax,1
mov ebx,0
int 80h

read_array:
pusha
read_loop:
cmp eax,dword[n]
je end_read5
call read_num
mov cx,word[num]
mov word[ebx+2*eax],cx
inc eax
jmp read_loop
end_read5:
popa
ret

print_array:
pusha
print_loop:
cmp eax,dword[n]
je end_print1
mov cx,word[ebx+2*eax]
mov word[num],cx
call print_num
inc eax
jmp print_loop
end_print1:
popa
ret


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
cmp byte[temp], 32
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
mov ecx,space
mov edx,1
int 80h
popa
ret