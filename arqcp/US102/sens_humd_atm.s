.section .data

.section .text
	.global sens_humd_atm
	
sens_humd_atm:
movl $0, %eax

cmpb $0, %sil
je back

testarNormalizacao:
cmpb $2, %dl
jg normalizar
cmpb $-2, %dl
jl normalizar
movb %dl, %al

back: 
movl $0, %eax
movb %dil, %al
cmpb $0, %dl
jl negativo
addb %dl, %al
jmp end
negativo:
notb %dl
incb %dl
subb %dl, %al
cmpb $100, %al
jbe fim
movb $100, %al
fim:
jmp end

normalizar:
movb %dl, %al
cbw 
movb $2, %cl
idivb %cl
movb %ah, %al
movb %al, %dl
jmp back

end:
ret
