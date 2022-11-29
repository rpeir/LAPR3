.section .data
	.global state
	.global inc
	
.section .text
	.global pcg32_random_r
	
pcg32_random_r:
pushq %rbp
movq %rsp, %rbp

subq $16, %rsp  # reserve 16 bytes for local varible oldstate

movq state(%rip), %rsi
movq   %rsi, -8(%rbp) # oldstate = state 

movq -8(%rbp), %rax #oldstate to rax
movq $6364136223846793005ULL, %rbx
mulq %rbx

orq $00000001, inc(%rip) 

addq inc(%rip), %rax
movq %rax, state(%rip) 

movq  -8(%rbp), %rax
movq  -8(%rbp), %rbx
shrq $18, %rax
xorq %rbx, %rax

shrq $27, %rax
movl %eax, -12(%rbp)

movq -8(%rbp), %rcx
shrq $59, %rcx
movl %ecx, -16(%rbp)

movl -12(%rbp), %eax
movb -16(%rbp), %cl
shrl %cl, %eax


movl -12(%rbp), %edx
movl -16(%rbp), %ebx
negl %ebx
andl $31, %ebx
movb %bl, %cl
shll %cl, %edx

orl %edx, %eax

movq %rbp, %rsp
popq %rbp
ret

