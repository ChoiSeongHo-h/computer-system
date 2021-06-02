.globl matmul

.text
# =======================================================
# FUNCTION: Matrix Multiplication of 2 integer matrices
#   d = matmul(m0, m1)
#   If the dimensions don't match, exit with exit code 2
# Arguments:
#   a0 is the pointer to the start of m0
#   a1 is the # of rows (height) of m0
#   a2 is the # of columns (width) of m0
#   a3 is the pointer to the start of m1
#   a4 is the # of rows (height) of m1
#   a5 is the # of columns (width) of m1
#   a6 is the pointer to the the start of d
# Returns:
#   None, sets d = matmul(m0, m1)
# =======================================================
matmul:
    bne a2, a4, mismatched_dimensions   #if(m0.col != m1.row) mismatched_dimensions
    addi sp, sp, -12
    sw ra, 8(sp)
    sw s0, 4(sp)
    sw s1, 0(sp)

    addi t1, x0, 0                      #i = 0
    addi t2, x0, 0                      #j = 0
    addi t3, a0, 0                      #m0
    addi t4, a3, 0                      #m1
    addi t5, a1, 0                      #m0.h = d.h
    addi t6, a5, 0                      #m1.w = d.w
    addi s0, a2, 0                      #len
    addi s1, a6, 0                      #d

    bgt t5, t1, outer_loop_start        #if(m0.h > 0) outer_loop_start
    j outer_loop_end                    #else loop_end

outer_loop_start:
    bgt t6, t2, inner_loop_start        #if(m1.w > 0) inner_loop_start

inner_loop_start:
    addi a0, t3, 0      #   a0 is the pointer to the start of v0
    addi a1, t4, 0      #   a1 is the pointer to the start of v1
    addi a2, s0, 0      #   a2 is the length of the vectors
    addi a3, x0, 1      #   a3 is the stride of v0
    addi a4, t6, 0      #   a4 is the stride of v1

    addi sp, sp, -24
    sw t1, 20(sp)
    sw t2, 16(sp)
    sw t3, 12(sp)
    sw t4, 8(sp)
    sw t5, 4(sp)
    sw t6, 0(sp)

    jal ra dot

    lw t1, 20(sp)
    lw t2, 16(sp)
    lw t3, 12(sp)
    lw t4, 8(sp)
    lw t5, 4(sp)
    lw t6, 0(sp)
    addi sp, sp, 24

    sw a0, 0(s1)        #d[i, j]

    addi s1, s1, 4      #d = d+4
    addi t4, t4, 4      #m1 = m1+4
    addi t2, t2, 1      #j = j+1

    bgt t6, t2, inner_loop_start        #if(m1.w > j) inner_loop_start
                                        #else
    slli t2, t2, 2
    neg t2, t2
    add t4, t4, t2      #m1 init
    addi t2, x0, 0      #j = 0

inner_loop_end:
    slli t0, s0, 2      #t0 = 4*len
    add t3, t3, t0      #m0 next row
    addi t1, t1, 1      #i = i+1
    ble t5, t1, outer_loop_end      #if !(m0.h > i) outer_loop_end
    j outer_loop_start

outer_loop_end:
    lw ra, 8(sp)
    lw s0, 4(sp)
    lw s1, 0(sp)
    addi sp, sp, 12
    ret

mismatched_dimensions:
    li a1 2
    jal exit2