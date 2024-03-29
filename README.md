# Lab1: RISC-V ASM

Отчет по первой лабораторной работе

## Вариант задания

Вариант 2

Вариант задания | Передача параметров
--------------- | -------------
Найти индекс максимального элемента массива.<br>(N=4, M=3) | Через стек

## Сборка

Сборка Си файла выполняется с помощью GNU Make. Для этого необходимо выполнить команду

```
make
```

## Результаты работы

+ **lab1.S** - программа на языке ассемблера RISCV
+ **main.c** - программа на Си
+ **main.dump** - дамп-файл программы на Си
+ **makefile** - файл для сборки

## Выполнение работы

Корректность выполнения работы *lab1.S* можно проверить с помощью симулятора [Venus](https://www.kvakil.me/venus/), изменяя данные матрицы

```
matrix:
.word 10, -5, -3, -4
.word -5, -15, -7, -98
.word -9, -10, -11, 12
```
## Анализ дамп-файла

Начало вызываемой процедуры *findMax*

```
00010140 <findMax>:
   10140:   fd010113             addi  sp,sp,-48
```
Ниже сразу идет процедура *main*

```
00010210 <main>:
   10210:   fb010113             addi  sp,sp,-80
```
### Анализ main

В начале изменяется значение *sp*, значения из *s0* и *ra* сохраняются на стеке, а в конце восстанавливаются, так как callee обязан восстанавливать их в конце процедуры

```
   10210:   fb010113             addi  sp,sp,-80
   10214:   04112623             sw ra,76(sp)
   10218:   04812423             sw s0,72(sp)
```

```
   102d4:   04c12083             lw ra,76(sp)
   102d8:   04812403             lw s0,72(sp)
   102dc:   05010113             addi  sp,sp,80
```

---

Аргументы в findMax передаются через регистры *a0, a1, a2, a3*, где *a2, a3* содержат адреса ячеек, в которых находятся адреса первых элементов matrix и result

```
   1029c:   00070693             mv a3,a4
   102a0:   00078613             mv a2,a5
   102a4:   00300593             li a1,3
   102a8:   00400513             li a0,4
   102ac:   e95ff0ef             jal   ra,10140 <findMax>
```

### Анализ findMax

Как и в *main*, значения *sp* и *s0* изменяются в начале и восстанавливаются в конце

```
   10140:   fd010113             addi  sp,sp,-48
   10144:   02812623             sw s0,44(sp)
```

```
   10204:   02c12403             lw s0,44(sp)
   10208:   03010113             addi  sp,sp,48
```
---
Для перебора элементов массива и выбора наибольшего элемента используется три условных команды

+ Сравнение текущего максимального значения и текущего элемента массива

```
   101a4:   02e7d463             bge   a5,a4,101cc <findMax+0x8c>
```

+ Сравнение для перебора по элементам строки

```
   101e0:   f8f74ce3             blt   a4,a5,10178 <findMax+0x38>
```

+ Сравнение для перебора строк

```
   101f8:   f6f74ce3             blt   a4,a5,10170 <findMax+0x30>
```

## Вывод
Ожидание более часа, пока соберется компилятор, просто невероятно.
