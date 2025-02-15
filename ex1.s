.data
source:
    .word   3
    .word   1
    .word   4
    .word   1
    .word   5
    .word   9
    .word   0
dest:
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0

.text
main:
    addi t0, x0, 0
    addi s0, x0, 0
    la s1, source
    la s2, dest
loop:
    slli s3, t0, 2
    add t1, s1, s3
    lw t2, 0(t1)
    beq t2, x0, exit
    add a0, x0, t2
    addi sp, sp, -8
    sw t0, 0(sp)
    sw t2, 4(sp)
    jal square
    lw t0, 0(sp)
    lw t2, 4(sp)
    addi sp, sp, 8
    add t2, x0, a0
    add t3, s2, s3
    sw t2, 0(t3)
    add s0, s0, t2
    addi t0, t0, 1
    jal x0, loop
square:
    add t0, a0, x0
    add t1, a0, x0
    addi t0, t0, 1
    addi t2, x0, -1
    mul t1, t1, t2
    mul a0, t0, t1
    jr ra
exit:
    add a0, x0, s0
    add a1, x0, x0
    ecall # Terminate ecall



#1. The register representing the variable k.
#t0 represent k
#    addi t0, x0, 0      #k = 0
#    ...
#    slli s3, t0, 2      #s3 = k*4
#    add t1, s1, s3      #s1 : source
#    lw t2, 0(t1)        #t2 : source[k]
#    beq t2, x0, exit    #for condition

#2. The register representing the variable sum.
#s0 represent sum
#    add t2, x0, a0      #a0 : return of fun
#    add t3, s2, s3      #s3 : 4*k, s2 : dest
#    sw t2, 0(t3)        #dest[k] = fun(source[k])
#    add s0, s0, t2      #sum += dest[k]

#3. The registers acting as pointers to the source and dest arrays.
#s1 acts as pointer of sourse
#s2 acts as pointer of dest
#    la s1, source
#    la s2, dest

#4. The assembly code for the loop found in the C code.
#loop
#    loop:                  #for loop
#        slli s3, t0, 2     #s3 = k*4
#        add t1, s1, s3     #s1 : source
#        lw t2, 0(t1)       #t2 : source[k]
#        beq t2, x0, exit   #break condition(source[k] == 0)
#        ...
#        jal x0, loop       #goto loop
#    ...
#    exit:                  #break
#    ...

#5. How the pointers are manipulated in the assembly code.
#Assume that p is pointer. if want to access *(p+n), use n(p).
