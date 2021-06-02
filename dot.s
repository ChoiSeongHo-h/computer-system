.globl dot

.text
# =======================================================
# FUNCTION: Dot product of 2 int vectors
# Arguments:
#   a0 is the pointer to the start of v0
#   a1 is the pointer to the start of v1
#   a2 is the length of the vectors
#   a3 is the stride of v0
#   a4 is the stride of v1
# Returns:
#   a0 is the dot product of v0 and v1
# =======================================================
dot:
    addi sp, sp, -4
    sw, s0, 0(sp)

    addi t0, x0, 0			#i = 0
    addi t1, a2, 0			#N = a2
    addi t2, a0, 0			#m1 = a0
    addi t3, a1, 0			#m2 = a1
    lw t4, 0(t2)			#t4 = m1[0]
    lw t5, 0(t3)			#t5 = m2[0]
    slli t6, a3, 2			#t6 = 4*a3(stride1)
    slli s0, a4, 2			#s0 = 4*a4(stride2)
    addi a0, x0, 0			#a0 = 0
    bgt t1, t0, loop_start	#if(N>0) loop_start
    j loop_end				#else loop_end

loop_start:
	mul t4, t4, t5  		#t4 = t4*t5
	add a0, a0, t4			#a0 = a0+t4
	addi t0, t0, 1			#i++
    add t2, t2, t6			#m1 = m1+t6(4*stride1)
    add t3, t3, s0			#m2 = m2+s0(4*stride2)
    lw t4, 0(t2)			#t4 = m1[0]
    lw t5, 0(t3)			#t5 = m2[0]
    bgt t1, t0, loop_start	#if(N>i) loop_start

loop_end:
	lw s0, 0(sp)
    addi sp, sp, 4
    ret
