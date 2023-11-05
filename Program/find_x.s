.include "macrolib.s"

.global find_x

find_x:
.data
	eps: .float 0.00000001	# Переменная определяющая точность вычисления
.text	
	# Сохранение адреса возврата
	addi 		sp, sp, -4
	sw 			ra, (sp)
	
	fmv.s		ft1 fa1		# a
	fmv.s		ft2 fa2		# a
	
	fun(fa1)				# f(a)
	fmv.s		ft3 fa0		# Сохранили f(a) в ft3
	fun(fa2)				# f(b)
	fmv.s		ft4 fa0		# Сохранили f(b) в ft4
	
	# Проверка, что в интервале есть решение
	fmul.s		fs0 ft3 ft4	# f(a)*f(b)
	li			s1 0
    fcvt.s.w	fs10 s1
	fle.s		t6 fs0 fs10 
	beqz 		t6 error	# if f(a)*f(b) > 0, то останавливаем программу
	
	# Поиск решения
	fmv.s		ft5 ft2		# xn = b
	fsub.s		ft6 ft1 ft2	# a - b
	fmv.s		fa0 ft6	
	abs(fa0)				# |a-b|
	fmv.s		ft6 fa0
	
	loop:	fun(fa1)			# f(a)
		fmv.s		ft3 fa0		# Сохранили f(a) в ft3
		fun(fa2)				# f(b)
		fmv.s		ft4 fa0		# Сохранили f(b) в ft4
		fmv.s		ft7 ft5		# x0 = xn
		
		# x = a - ((f(a)*(b - a)) / (f(b) - f(a)))
		# Находим числитель
		fsub.s		fs1 ft2 ft1	# (b - a)
		fmul.s 		fs1 ft3 fs1	# (f(a)*(b - a)
		# Находим знаменатель
		fsub.s 		fs2 ft4 ft3	#(f(b) - f(a))
		# Результат
		fdiv.s 		fs0 fs1 fs2	#((f(a)*(b - a)) / (f(b) - f(a)))
		fsub.s		fs0 ft1 fs0	#a - ((f(a)*(b - a)) / (f(b) - f(a)))
		
		fmv.s		fa0 fs0
		fun(fa0)
		fmv.s		ft8 fa0		# Сохраняем f(x) в ft8
		
		# Проверка для перехода к новой границе интервала
		fmul.s		fs5 ft3 ft8	# f(a)*f(x)
		li			s1 0
    	fcvt.s.w	fs10 s1
		flt.s		t6 fs5 fs10 
		bgtz 		t6 type1	# if f(a)*f(x) < 0
	back1:		
		fmul.s		fs5 ft4 ft8	# f(b)*f(x)
		li			s1 0
    	fcvt.s.w	fs10 s1
		flt.s		t6 fs5 fs10
		bgtz 		t6 type2	# if f(b)*f(x) < 0
	back2:	
	
		fmv.s		ft5 fs0
		fsub.s		ft6 ft5 ft7	# x - x0
		fmv.s		fa0 ft6
		abs(fa0)				# |x-x0|
		fmv.s		ft6 fa0
		
		# Проверка условия на выход из цикла
    	la			t6 eps
    	flw			fs9 (t6)
    	flt.s 		t6 fs9 ft6
    	bnez		t6 loop     # if eps < |x-x0|, цикл продолжается
    		
    		
	# Выход из подпрограммы
	fmv.s			fa0 ft5
	print_str("x = ")
	print_float(fa0)
	lw 				ra, (sp)
	addi 			sp, sp, 4
	ret

type1:
	fmv.s		ft2 fs0	
	j	back1
type2:
	fmv.s		ft1 fs0			
	j	back2
	
error:
	print_str("На интервале нет решения")
	# Выход из подпрограммы
	lw 			ra, (sp)
	addi 		sp, sp, 4
	ret