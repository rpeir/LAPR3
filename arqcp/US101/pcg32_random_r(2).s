.section .data
    .global state
    .global inc

.section .text

    .global pcg32_random_r

pcg32_random_r:
pushq %rbp
movq %rsp, %rbp

# alocar as duas variaveis
movq state(%rip), %rcx        # oldstate
movq $6364136223846793005, %rax


mulq %rcx                    # oldstate * 6364136223846793005
orq $00000001, inc(%rip)    # (inc|1)
addq inc(%rip), %rax                # oldstate * 6364136223846793005 + (inc|1)
movq %rax, state(%rip)        # state = oldstate * 6364136223846793005 + (inc|1)
movl $0, %eax                # rax vai ser reutilizado
movq %rcx, %rax            # rax = oldstste
shrq $18, %rax                # oldstate >> 18
xorq %rcx, %rax                # (oldstate >> 18) ^ oldstate) -> '^' significa 'XOR'
shrq $27, %rax                # xorshifted = ((oldstate >> 18) ^ oldstate) >> 27
shrq $59, %rcx                # rot = oldstate >> 59
andq $31, %rcx                # rot = rcx = (rot) & 31
rorl %cl, %eax                # (xorshifted >> rot) | (xorshifted << ((rot) & 31)

movq %rbp, %rsp
popq %rbp

ret