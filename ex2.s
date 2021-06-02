.data
.word 2, 4, 6, 8
n: .word 9

.text
main:   add     t0, x0, x0
        addi    t1, x0, 1
        la      t3, n
        lw      t3, 0(t3)
fib:    beq     t3, x0, finish
        add     t2, t1, t0
        mv      t0, t1
        mv      t1, t2
        addi    t3, t3, -1
        j       fib
finish: addi    a0, x0, 1
        addi    a1, t0, 0
        ecall # print integer ecall
        addi    a0, x0, 10
        ecall # terminate ecall



#1.
#.data means data section that is set of statically allocated data
#.word means that to allocate 4byte data
#.text means text section that used by program(excutable machine instructions).

#2.
#34, 9th fib num (0-indexed)

#3.
#0x10000010

#4.
#The value of memory address 0x10000010 was modified from (09 00 00 00) to (13 00 00 00). The output is 233
