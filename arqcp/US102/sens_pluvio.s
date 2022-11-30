.section .data

.section .text
	.global sens_pluvio
	
sens_pluvio:
movl $0, %eax

cmpb $23, %sil
jg back
cmpb $5, %sil
jl back

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

cmp $0, %dil
je ult_pNula
jmp end

normalizar:
movb %dl, %al
cbw 
movb $5, %cl
idivb %cl
movb %ah, %al
movb %al, %dl
jmp back

pNula:
movl $0, %eax
jmp end

ult_pNula:
cmpb $0, %sil
jl pNula

end:
ret
