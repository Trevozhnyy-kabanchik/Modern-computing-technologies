import Pkg
Pkg.activate(dirname(@__DIR__))

using Laplace1DSolver
using Plots

f(x) = 25sin(3x)cos(4x) + 24cos(3x)sin(4x)
u(x) = sin(3x)cos(4x)

function main()
    N_plot = 50
    grid = 1 / N_plot
    x_nodes = [i * grid for i in 1:(N_plot-1)]

    F_vector = [f(x) * grid^2 for x in x_nodes]
    F_vector[1] += u(0.0)
    F_vector[end] += u(1.0)

    main_diag = fill(2.0, N_plot-1)
    upper_diag = fill(-1.0, N_plot-2)
    lower_diag = fill(-1.0, N_plot-2)

    numerical_solution = solve_tridiagonal(upper_diag, main_diag, lower_diag, F_vector)
    true_solution = [u(x) for x in x_nodes]

    p1 = plot(x_nodes, true_solution, label="Аналитическое", linewidth=2, color=:blue, legend=:bottomleft)
    scatter!(p1, x_nodes, numerical_solution, label="Численное", markersize=4, color=:red, markerstrokewidth=0)
    title!(p1, "Решение (N = $N_plot)", titlefontsize=11)
    xlabel!(p1, "x")
    ylabel!(p1, "u(x)")

    N_values = [10, 20, 50, 100, 200, 500, 1000, 5000, 10000]
    errors_C = Float64[]
    errors_L2 = Float64[]

    for N in N_values
        h = 1.0 / N
        x_n = [i * h for i in 1:(N-1)]
        
        F = [f(x) * h^2 for x in x_n]
        F[1] += u(0.0)
        F[end] += u(1.0)
        
        md = fill(2.0, N-1)
        ud = fill(-1.0, N-2)
        ld = fill(-1.0, N-2)
        
        y_n = solve_tridiagonal(ud, md, ld, F)
        y_e = [u(x) for x in x_n]
        
        push!(errors_C, C_norm(y_e, y_n))
        push!(errors_L2, L2_norm(y_e, y_n, h))
    end

    ref_O2 = [errors_C[1] * (N_values[1] / N)^2 for N in N_values]

    p2 = plot(N_values, errors_C, label="C-норма", marker=:circle, linewidth=2, xaxis=:log10, yaxis=:log10)
    plot!(p2, N_values, errors_L2, label="L2-норма", marker=:square, linewidth=2)
    plot!(p2, N_values, ref_O2, label="O(h^2) эталон", linestyle=:dash, color=:black)
    title!(p2, "Сходимость метода", titlefontsize=11)
    xlabel!(p2, "Число узлов N")
    ylabel!(p2, "Ошибка")

    final_plot = plot(p1, p2, layout=(1, 2), size=(800, 400), left_margin=5Plots.mm, bottom_margin=5Plots.mm)
    
    savefig(final_plot, "plots_for_report.png")
end

main()