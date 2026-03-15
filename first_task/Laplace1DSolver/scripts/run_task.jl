import Pkg
Pkg.activate(dirname(@__DIR__))

using Laplace1DSolver

f(x) = 25sin(3x)cos(4x) + 24cos(3x)sin(4x)
u(x) = sin(3x)cos(4x)

function main()

print("Введите натуральное число N: ")
N = parse(Int, readline())
grid = 1 / N

#Для устойчивости лучше умножать, а не делить 😎
F_vector = [f(i * grid) * grid^2 for i in 1:(N-1)]

left_boundary_condition = u(0.0)
right_boundary_condition = u(1.0)

F_vector[1] += left_boundary_condition
F_vector[end] += right_boundary_condition

main_diag = fill(2.0, N-1)
upper_diag = fill(-1.0, N-2)
lower_diag = fill(-1.0, N-2)

numerical_solution = solve_tridiagonal(upper_diag, main_diag, lower_diag, F_vector)
true_solution = [u(i * grid) for i in 1:(N-1)]

error_C = C_norm(true_solution, numerical_solution)
error_L2 = L2_norm(true_solution, numerical_solution, grid)

println("\nУбеждаемся что присутствует сходимость в С и L2 нормах:")
println("C-норма ошибки:  ", error_C)
println("L2-норма ошибки: ", error_L2)

end

main()