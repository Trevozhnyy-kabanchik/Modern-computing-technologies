function solve_tridiagonal(upper_diag, main_diag, lower_diag, right_vector)
    α, β = straight(upper_diag, main_diag, lower_diag, right_vector)
    solution = back(α, β)
    return solution
end

function straight(upper_diag, main_diag, lower_diag, right_vector)
    len = length(main_diag)

    α = zeros(len)
    β = zeros(len+1)
    #β[1] = 0, т.к. учли границу в правой части (если я правильно поняла)


    α[2] = -upper_diag[1] / main_diag[1]
    β[2] = right_vector[1] / main_diag[1]

    for i in 2:(len-1)
        #танцы с бубном с индексацией i-1. Нужно чтобы потом β[end] красиво выглядел
        denominator = lower_diag[i-1] * α[i] + main_diag[i]

        α[i+1] = -upper_diag[i] / denominator
        β[i+1] = (right_vector[i] - lower_diag[i-1] * β[i]) / denominator
    end

    β[end] = (right_vector[end] - lower_diag[end] * β[end-1]) / (lower_diag[end] * α[end] + main_diag[end])
    
    return (α, β)
end

function back(α, β)
    len = length(α)
    solution = zeros(len)

    solution[end] = β[end]

    for i in (len-1):-1:1
        solution[i] = α[i+1] * solution[i+1] + β[i+1]
    end

    return solution
end