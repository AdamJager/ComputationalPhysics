using Parameters
using Random



Base.@kwdef mutable struct Matrix2DArray
    rows::Int
    columns::Int
    matrix::Array{Float64, 2} = rand(rows, columns)
end

function multiply_2d(A::Matrix2DArray, B::Matrix2DArray)
    result = zeros(A.rows, B.columns)
    total = 0.0

    for rows in 1:A.rows
        for columns in 1:B.columns
            for brows in 1:B.rows
                total += A.matrix[rows, brows] * B.matrix[brows, columns]
            end
            result[rows, columns] = total
            total = 0
        end
    end
    return result
end


Base.@kwdef mutable struct Matrix1DArray
    rows::Integer
    columns::Integer
    matrix::Array{Float64, 1} = rand(rows * columns)
end

function multiply_1d(A::Matrix1DArray, B::Matrix1DArray)
    result = zeros(A.rows * B.columns)
    total = 0

    for i in 1:A.rows
        for j in 1:B.columns
            for k in 1:B.rows
                total += A.matrix[A.rows*(i-1) + k] * B.matrix[B.columns*(k-1) + j]
            end
            result[A.rows*(i-1) + j] = total
            total = 0
        end
    end
    return result
end

"""
function matrix_mult_benchmark(matrix_struct, mulitply_function)
    for dimensions in 1:10:1000
        matrix1 = matrix_struct(rows = dimensions, columns = dimensions)
        matrix2 = matrix_struct(rows = dimensions, columns = dimensions)
        @time mulitply_function(matrix1, matrix2)
    end
end


for dimensions in 10:10:1000
    matrix1 = Matrix1DArray(rows = dimensions, columns = dimensions)
    matrix2 = Matrix1DArray(rows = dimensions, columns = dimensions)
    @time multiply_1d(matrix1, matrix2)
end
"""

#matrix_mult_benchmark(Matrix2DArray, multiply)
