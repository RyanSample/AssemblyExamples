;nasm -f elf hello.asm
;ld -s -o lab1 lab1.o
			;stackoverflow.com/questions/11270118/multiplying-two-values-and-printing them to screen nasm linux
sys_exit	equ	1
sys_write	equ 4
stdout		equ 1
kernel		equ 0x80

section .stack			;stack section

section .data			;data section

section .bss			;beter save space segment
printValue:
		resd 1			;reserve 1 byte in memory declare uninitialized pointer

global _start			;define _start (entry point)
section .text
_start:					;main
				
	mov ax,100h			;number to print
	call print			;call print function
		
	mov eax, sys_exit		;syscall for exit
	int kernel			;call kernel
ret						;end _start

print:					;start of print
	mov cx, 5			;print 5 digits		;mov message to si
	mov bx, 10			; 10 is for division
	
;loop1:
	
	mov 	edx, 0		;clear edxtdout
	mov 	ecx, 0x0A	;mov 10 to divisor
	idiv	ecx
	mov eax, edx
	push eax
	push edx
	push ecx
	add eax,'0'				;convert to ascii
	;push eax				;push to stack so values aren't backwards
	;loop loop1				;move back to loop 1
	mov [printValue], eax	;mov eax to print value
	mov ecx, printValue		;mov number to ecx to print
	mov eax, sys_write		;move write call to eax
	mov edx, 1				;message size
	mov ebx, stdout			;fd
	int kernel
	
	
	;mov edx, length		;mov message size to edx
	;mov ecx, array			;mov message to exc
	;mov ebx, stdout		;mov fd to ebx
	;mov eax, sys_write		;mov syscall for write to eax
	;int kernel				;call kernel
	;mov eax,ecx			;mov message back into eax
	pop eax
	pop edx
	pop ecx
ret							;ret from function
		
	
