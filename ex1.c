int source[] = {3, 1, 4, 1, 5, 9, 0};
int dest[10];

int fun(int x) {
	return -x * (x + 1);
}

int main() {
    int k;
    int sum = 0;
    for (k = 0; source[k] != 0; k++) {
        dest[k] = fun(source[k]);
        sum += dest[k];
    }
    return sum;
}



//1. The register representing the variable k.
//t0 represent k
//    addi t0, x0, 0      #k = 0
//    ...
//    slli s3, t0, 2      #s3 = k*4
//    add t1, s1, s3      #s1 : source
//    lw t2, 0(t1)        #t2 : source[k]
//    beq t2, x0, exit    #for condition

//2. The register representing the variable sum.
//s0 represent sum
//    add t2, x0, a0      #a0 : return of fun
//    add t3, s2, s3      #s3 : 4*k, s2 : dest
//    sw t2, 0(t3)        #dest[k] = fun(source[k])
//    add s0, s0, t2      #sum += dest[k]

//3. The registers acting as pointers to the source and dest arrays.
//s1 acts as pointer of sourse
//s2 acts as pointer of dest
//    la s1, source
//    la s2, dest

//4. The assembly code for the loop found in the C code.
//loop
//    loop:                  #for loop
//        slli s3, t0, 2     #s3 = k*4
//        add t1, s1, s3     #s1 : source
//        lw t2, 0(t1)       #t2 : source[k]
//        beq t2, x0, exit   #break condition(source[k] == 0)
//        ...
//        jal x0, loop       #goto loop
//    ...
//    exit:                  #break
//    ...

//5. How the pointers are manipulated in the assembly code.
//Assume that p is pointer. if want to access *(p+n), use n(p).
