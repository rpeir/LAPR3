.section .data

.section .text
	.global sens_humd_atm
	
sens_humd_atm:
movl $0, %eax

cmpb $0, %sil
jne back

testarNormalizacao:
cmpb $5, %dl
jg normalizar
cmpb $-5, %dl
jl normalizar
movb %dl, %al

back: 
movl $0, %eax
movb %dil, %al
addb %dl, %al
jmp end

normalizar:
movb %dl, %al
cbw 
movb $5, %cl
idivb %cl
mov %ah, %dl
jmp back

end:
ret
