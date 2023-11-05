.global fun

fun:	
	# Сохранение адреса возврата
	addi 		sp, sp, -4
	sw 			ra, (sp)
	
	fmv.s		ft0 fa0

	#y = 2**(x**2 + 1) + x - 3
	li			s1 1
    fcvt.s.w	fs2 s1
	fmadd.s		fs1, ft0, ft0, fs2 		#(x^2 + 1)
	li			s1 2
    fcvt.s.w	fs3 s1
	fmadd.s		fs2, fs1, fs1, ft0 		#(x^2 + 1)^2 + x
	li			s1 -3
    fcvt.s.w	fs1 s1
    fadd.s		ft10 fs2 fs1			#(x^2 + 1)^2 + x -3
    	
    # Выход из подпрограммы
    fmv.s		fa0 ft10				# Возврат переменной согласно общепринятому соглашению
    lw 			ra, (sp)
	addi 		sp, sp, 4
    ret