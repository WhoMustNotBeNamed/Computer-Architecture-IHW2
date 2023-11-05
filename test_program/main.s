.include "macrolib.s"

.global main

main:
.data	
	.align  2				# Выравнивание на границу слова
	A1: .float 2				# Левая граница интервала
	B1: .float 3				# Правая граница интервала
	A2: .float 0				# Левая граница интервала
	B2: .float 1				# Правая граница интервала
	A3: .float -1				# Левая граница интервала
	B3: .float 0				# Правая граница интервала
	A4: .float -3				# Левая граница интервала
	B4: .float -2				# Правая граница интервала
.text
	print_str("a = 2 \nb = 3")
	newline
	find_x(A1,B1)				# Поиск решения на заданном интервале (передаем адреса на переменные)
	
	print_str("\n____________")
	newline
	print_str("a = 0 \nb = 1")
	newline
	find_x(A2,B2)				# Поиск решения на заданном интервале (передаем адреса на переменные)
	
	print_str("\n____________")
	newline
	print_str("a = -1 \nb = 0")
	newline
	find_x(A3,B3)				# Поиск решения на заданном интервале (передаем адреса на переменные)
	
	print_str("\n____________")
	newline
	print_str("a = -3 \nb = -2")
	newline
	find_x(A4,B4)				# Поиск решения на заданном интервале (передаем адреса на переменные)
	end	
