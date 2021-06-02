.globl factorial

.data
n: .word 8

.text
main:
    la t0, n
    lw a0, 0(t0)
    jal ra, factorial

    addi a1, a0, 0
    addi a0, x0, 1
    ecall # Print Result

    addi a1, x0, '\n'
    addi a0, x0, 11
    ecall # Print newline

    addi a0, x0, 10
    ecall # Exit

factorial:
    add t0, a0, x0  ## a = parameter
    addi t1, x0, 1  ## b = 1
    addi t2, x0, 1  ## const int t2 = 1
    beq t0, x0, end ## if(a == 0) return b = 1
    beq t0, t1, end ## if(a == 1) return b = 1
loop:               ## if(a > 1)
    mul t1, t1, t0  ## b = b*a
    addi t0, t0, -1 ## a--
    beq t0, t2, end ## if(a == 1) return b = a!
    jal x0, loop    ## else goto loop
end:                ## return part
    add a0, t1, x0
    jr ra



#3! = 6, 7! = 5040, 8! = 40320
#Additionally, 0! = 1, 1! = 1
