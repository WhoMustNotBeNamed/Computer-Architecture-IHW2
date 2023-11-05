import math
from scipy.optimize import fsolve

# Уравнение
def f(x):
    return (x**2 + 1)**2 + x - 3

def ChordMethod(a, b):
    if f(a)*f(b) <= 0:
        xn = b
        eps = abs(a - b)
        while eps > math.pow(10, -10):
            x0 = xn
            x = a - ((f(a)*(b - a)) / (f(b) - f(a)))
            if f(a)*f(x) < 0:
                a = a
                b = x
            if f(b)*f(x) < 0:
                a = x
                b = b
            xn = x
            eps = abs(xn - x0)
        print("\nРезультат вычисления с помощью метода хорд: ")
        print(round(xn, 6))
        return 0
    print("На интервале нет решения")
    return 0

# Поиск решения с помощью математической библиотеки   
def MathLib():
    result = fsolve(f, 0)
    print("\nРезультат вычисления с помощью математической библиотеки:")
    print(round(*result, 6))
    return 0

a=float(input("a = "))
b=float(input("b = "))
ChordMethod(a, b)
MathLib()