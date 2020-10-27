.data
N:
.word 4

M:
.word 3

matrix:
.word 10, -5, -3, -4
.word -5, -15, -7, -98
.word -9, -10, -11, 12

result:
.word 0
.word 0

.text
main:
lw s1, N
lw s2, M
la s3, matrix
la s4, result
addi sp,sp, -16 
sw s1, 0(sp) # сохранение N на стеке
sw s2, 4(sp) # сохранение M на стеке
sw s3, 8(sp) # сохранение адреса первого элемента матрицы на стеке
sw s4, 12(sp) # сохранение адреса результата
call findMax
addi sp, sp, 16
mv a2, s4
call print
call exit

print:
lw a1, 0(a2) # вывести номер строки
addi a0, x0, 1
ecall

addi a0, x0, 11 # пробел
addi a1, x0, 32
ecall

lw a1, 4(a2) # вывести номер строки
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
lw t3, 0(t2) # первый элемент матрицы
lw t4, 12(sp) #result
li t5, 0 #текущая строка

init:
li t6, 0 # текущий столбец

loop:
lw a2, 0(t2) # текущий элемент
bge t3, a2, cont # если максимальный элемент больше текущего, то пропустить
mv t3, a2 # сохранение самого элемента и индекса
sw t5, 0(t4)
sw t6, 4(t4)

cont:
addi t2, t2, 4 # адрес следующего элемента
addi t6, t6, 1 
blt t6, t0, loop
addi t5, t5, 1
blt t5, t1, init
ret
