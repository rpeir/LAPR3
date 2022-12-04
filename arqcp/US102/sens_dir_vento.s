.section .data

.section .text
	.global sens_dir_vento
	
sens_dir_vento:
movl $0, %eax

cmpb $2, %sil
jg normalizar
cmpb $-2, %sil
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
movb $2, %cl
idivb %cl
movb %ah, %al
movb %al, %sil
jmp back

end:
ret
