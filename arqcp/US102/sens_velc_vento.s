.section .data

.section .text
	.global sens_velc_vento
	
sens_velc_vento:
cmpb $2, %sil
jg normalizar
cmpb $-2, %sil
jl normalizar
movb %sil, %al

back: 
movl $0, %eax
movb %dil, %al
cmpb $0, %sil
jl negativo
addb %sil, %al
jmp end
negativo:
notb %sil
incb %sil
subb %sil, %al
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
