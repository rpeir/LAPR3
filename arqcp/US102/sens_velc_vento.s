.section .data

.section .text
	.global sens_velc_vento
	
sens_velc_vento:
movl $0, %eax
movb %dil, %al
addb %sil, %al
ret
