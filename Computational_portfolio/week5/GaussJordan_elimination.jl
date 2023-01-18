# Gaussian elimination
using LinearAlgebra

function gaussianElimination(matrix::Matrix, vector=0::Vector, returnInverse=false::Bool)
    if returnInverse == false
        matrix = hcat(matrix, vector)
    else
        identity = Matrix(I, size(matrix))
        matrix = hcat(matrix, identity)
    end
    for pivot in 1:size(matrix, 1)
        solvabilityCheck(matrix[pivot, :])
        if matrix[pivot, pivot] == 0
            for row in pivot + 1:size(matrix, 1)
                if matrix[row, pivot] != 0
                    rowSwap(matrix, row, pivot)
                    break
                end
            end
        end
        matrix[pivot, :] *= 1/matrix[pivot, pivot]
        for row in 1:size(matrix, 1)
            if row != pivot
                matrix[row, :] -= matrix[row, pivot] * matrix[pivot, :]
            end
        end
    end
    if returnInverse == nothing
        return matrix[:, size(matrix, 2)]
    else
        halfway = Int(size(matrix, 2)/2)
        println("matrix: $(matrix)")
        return matrix[1:halfway, halfway+1:size(matrix, 2)]
    end
end


function solvabilityCheck(row::Vector)
    total = 0.0
    for index in 1:length(row) - 1
        total += row[index]
    end
    @assert !(total == 0 && total != last(row)) "This matrix has no solution"
end


function rowSwap(matrix::Matrix, row1Index::Integer, row2Index::Integer)
    temp = matrix[row1Index, :]
    matrix[row1Index, :] = matrix[row2Index, :]
    matrix[row2Index, :] = temp
end


matrix1 = [4.0 -3.0 1.0; -2.0 1.0 -3.0; 1.0 -1.0 2.0]
vector1 = [-8.0, 1.0, 3.0]

matrix2 = [1.0 2.0 3.0; 4.0 5.0 6.0; 7.0 8.0 10.0]
vector2 = [1; 2; 3]

matrix3 = [1 2 3; 2 4 7; 3 7 11]
vector3 = [1, 2, 2]

result1 = gaussianElimination(matrix3, vector3)
