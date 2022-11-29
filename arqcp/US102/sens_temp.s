.section .data

.section .text
	.global sens_temp
	
sens_temp:
cmpb $5, %sil
jg normalizar
cmpb $-5, %sil
jl normalizar
movb %sil, %al

back: 
movl $0, %eax
movb %dil, %al
addb %sil, %al
jmp end

normalizar:
movb %sil, %al
cbw 
movb $5, %cl
idivb %cl
movb %ah, %al
movb %al, %sil
jmp back

end:
ret
