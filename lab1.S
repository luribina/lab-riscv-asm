.data
N:
.word 4

M:
.word 3

matrix:
.word -10, -5, -3, -4
.word -5, -15, -7, -8
.word -9, -10, -11, -12

result:
.word 0

.text
main:
lw s2, N
lw s3, M
la s4, matrix
addi sp,sp, -12 
sw s2, 0(sp) # сохранение N на стеке
sw s3, 4(sp) # сохранение M на стеке
sw s4, 8(sp) # сохранение адреса первого элемента матрицы на стеке
call findMax
addi sp, sp, 12
mv a1, a0
call print
call exit

print:
addi a0, x0, 1
ecall
ret

exit:
addi a0, x0, 10
ecall

findMax:
lw t0, 0(sp) #N
lw t1, 4(sp) #M
lw t2, 8(sp) #matrix
lw t3, 0(t2) #result

init:
li t4, 0 # текущий столбец

loop:
lw t5, 0(t2) # текущий элемент
blt t5, t3, cont
mv t3, t5

cont:
addi t2, t2, 4
addi t4, t4, 1
blt t4, t0, loop
addi t1, t1, -1
bgtz t1, init
mv a0, t3
ret

