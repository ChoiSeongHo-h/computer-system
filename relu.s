.globl relu

.text
# ==============================================================================
# FUNCTION: Performs an inplace element-wise ReLU on an array of ints
# Arguments:
# 	a0 is the pointer to the array
#	a1 is the # of elements in the array
# Returns:
#	None
# ==============================================================================
relu:
    addi t0, x0, 0			#i = 0
    addi t1, a1, 0			#N = a1
    addi t2, a0, 0			#m = a0
    bgt t1, t0, loop_start	#if(N>0) loop_start
    j loop_end				#else loop_end

loop_start:
	lw t3, 0(t2)				#m[i]
    bgt t3, x0, loop_continue	#if(m[i]>0) loop_continue
    sw x0, 0(t2)				#else m[i] = 0

loop_continue:
	addi t0, t0, 1			#i++
    addi t2, t2, 4			#m = m+4
    bgt t1, t0, loop_start	#if(N>i) loop_start

loop_end:
	ret