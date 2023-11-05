.macro print_float(%x)
	fmv.s	fa0 %x
	li	a7 2
	ecall
.end_macro

.macro read_int(%x)
        push     (a0)
        li       a7, 5
        ecall
        mv       %x, a0
        pop      (a0)
.end_macro

.macro print_str(%x)
   .data
str:
   .asciz %x
   .text
   push (a0)
   li a7, 4
   la a0, str
   ecall
   pop	(a0)
.end_macro

.macro print_char(%x)
   li a7, 11
   li a0, %x
   ecall
.end_macro

.macro newline
   print_char('\n')
.end_macro

.macro push(%x)
	addi	sp, sp, -4
	sw	%x, (sp)
.end_macro

.macro pop(%x)
	lw	%x, (sp)
	addi	sp, sp, 4
.end_macro

# Очистка регистра
.macro clean(%x)
	li	%x 0
.end_macro

# Чтение a и b
.macro read_a_and_b(%a, %b)
	.text	
		print_str("a = ")
        li a7, 6
   		ecall
   		la	t1 %a
   		fsw	fa0 (t1)
   		
   		print_str("b = ")
   		li a7, 6
   		ecall
   		la	t2 %b
   		fsw	fa0 (t2)    
.end_macro

# Поиск решения
.macro find_x(%a, %b)
	la	t1 %a
	la	t2 %b
	flw	fa1 (t1)		# Передаем переменные через регистр a, согласно общепринятому соглашению
	flw	fa2 (t2)		# Передаем переменные через регистр a, согласно общепринятому соглашению
	jal	find_x
.end_macro

# Поиск f(x)
.macro fun(%x)
	fmv.s	fa0 %x
	jal	fun
.end_macro

# Модуль числа
.macro abs(%x)
	li			s1 0
    fcvt.s.w	fs10 s1
	fle.s		t6 %x fs10 
	beqz 		t6 exit			# if x > 0, то возвращаемся
	fneg.s 		%x %x			# Находим модуль числа
exit:
.end_macro

# Повтор программы
.macro repeat
	print_str("\nЕсли хотите выйти введите 0. В противном случае другое число   ")
	read_int(t1)		        # Чтение ответа
	newline
	bnez 	t1 main				# Повторный запуск	
.end_macro

.macro end
	li  a7 10       # Завершаем выполнение программы
	ecall
.end_macro
