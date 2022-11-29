.section .data

.section .text
	.global sens_dir_vento
	
sens_dir_vento:
movl $0, %eax

cmpb $5, %sil
jg normalizar
cmpb $-5, %sil
jl normalizar
movb %sil, %al

back: 
movl $0, %eax
movb %dil, %al
addb %sil, %al

cmpw $359, %ax
jg maior
cmpw $0, %ax
jl menor
jmp end

menor:
movw $0, %ax
jmp end

maior:
movw $359, %ax
jmp end

normalizar:
movb %sil, %al
cbw 
movb $5, %cl
idivb %cl
mov %ah, %sil
jmp back

end:
ret
