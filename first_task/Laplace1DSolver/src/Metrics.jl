function C_norm(true_solution, numerical_solution)
    return maximum(abs.(true_solution .- numerical_solution))
end

function L2_norm(true_solution, numerical_solution, grid)
    return sqrt(grid * sum((true_solution .- numerical_solution).^2))
end