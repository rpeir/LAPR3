.section .data

.section .text
	.global sens_pluvio
	
sens_pluvio:
movl $0, %eax

# cmpb $23, %sil
# jg back
# cmpb $5, %sil
# jl back

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
jmp continue
negativo:
notb %dl
incb %dl
subb %dl, %al
continue:

cmp $0, %dil
je ult_pNula
jmp end

normalizar:
movb %dl, %al
cbw 
movb $2, %cl
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

normalizar2:
movb %dl, %al
cbw
movb $2, %cl
idivb %cl
movb %ah, %al
movb %al, %dl
jmp back
