import matplotlib.pyplot as plt
import numpy as np

data = np.genfromtxt('results.csv', delimiter=',', skip_header=1)

N = data[:, 0]
h = data[:, 1]
C_norm = data[:, 2]
L2_norm = data[:, 3]
Prec_time = data[:, 4]
Iter_time = data[:, 5]

plt.figure(figsize=(8, 6))

plt.loglog(h, C_norm, 'o-', linewidth=2, label='C-norm (max error)')
plt.loglog(h, L2_norm, 's-', linewidth=2, label='L2-norm (integral error)')

ideal_h2 = L2_norm[0] * (h / h[0])**2
plt.loglog(h, ideal_h2, 'k--', label='Теоретическая сходимость $O(h^2)$')

plt.xlabel('Шаг сетки $h$', fontsize=12)
plt.ylabel('Ошибка', fontsize=12)
plt.title('График сходимости метода', fontsize=14)
plt.grid(True, which="both", ls="--", alpha=0.7)
plt.legend(fontsize=12)

plt.savefig('convergence_plot.png', bbox_inches='tight')
plt.show()

plt.figure(figsize=(8, 6))

N_system = (N - 1)**2 

plt.plot(N_system, Prec_time, 'o-', color='blue', linewidth=2, label='Время сборки ILU2')
plt.plot(N_system, Iter_time, 's-', color='red', linewidth=2, label='Время итераций BiCGStab')

plt.xlabel('Размер системы СЛАУ $(N-1)^2$', fontsize=12)
plt.ylabel('Время (секунды)', fontsize=12)
plt.title('Зависимость времени решения от размера задачи', fontsize=14)
plt.grid(True, ls="--", alpha=0.7)
plt.legend(fontsize=12)

plt.savefig('time_plot.png', bbox_inches='tight')
plt.show()