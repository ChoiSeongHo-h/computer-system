.globl argmax

.text
# =================================================================
# FUNCTION: Given a int vector, return the index of the largest
#	element. If there are multiple, return the one
#	with the smallest index.
# Arguments:
# 	a0 is the pointer to the start of the vector
#	a1 is the # of elements in the vector
# Returns:
#	a0 is the first index of the largest element
# =================================================================
argmax:
    addi t0, x0, 0			#i = 0
    addi t1, a1, -1			#N = a1-1
    addi t2, a0, 0			#m = a0
    lw t3, 0(t2)			#max = m[0]
    addi t5, x0, 0			#max_id = 0
    bge t1, t0, loop_start	#if(N>=0) loop_start
    j loop_end				#else loop_end

loop_start:
	lw t4, 4(t2)				#m[i+1]
    bge t3, t4, loop_continue	#if(max>=m[i+1]) loop_continue
    addi t3, t4, 0				#else max = m[i+1]
    addi t5, t0, 1				#max_id = i+1

loop_continue:
	addi t0, t0, 1			#i++
    addi t2, t2, 4			#m = m+4
    bgt t1, t0, loop_start	#if(N>i) loop_start

loop_end:
	addi a0, t5, 0			#return max
	ret
