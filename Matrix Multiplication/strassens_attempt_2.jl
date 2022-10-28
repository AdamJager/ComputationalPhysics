import Base

mutable struct Matrix1DArray
    rows::Integer
    columns::Integer
    values::Array{Any, 1}
end


function split(matrix::Matrix1DArray)
    #println("bad value: $(matrix.values)")
    topLeftValues = []
    topRightValues = []
    bottomLeftValues = []
    bottomRightValues = []

    for row in 1:matrix.rows/2
        for column in 1:matrix.columns/2
            append!(topLeftValues, matrix.values[trunc(Int, matrix.columns*(row - 1) + column)])
            append!(topRightValues, matrix.values[trunc(Int, matrix.columns*(row - 1) + column + matrix.columns/2)])
            append!(bottomLeftValues, matrix.values[trunc(Int, matrix.columns*(row - 1) + column +
                                                                                (matrix.rows/2 * matrix.columns))])
            append!(bottomRightValues, matrix.values[trunc(Int, matrix.columns*(row - 1) + column + matrix.columns/2 +
                                                                                (matrix.rows/2 * matrix.columns))])
        end
    end

    topLeft = Matrix1DArray(matrix.rows/2, matrix.columns/2, topLeftValues)
    topRight = Matrix1DArray(matrix.rows/2, matrix.columns/2, topRightValues)
    bottomLeft = Matrix1DArray(matrix.rows/2, matrix.columns/2, bottomLeftValues)
    bottomRight = Matrix1DArray(matrix.rows/2, matrix.columns/2, bottomRightValues)

    return topLeft, topRight, bottomLeft, bottomRight
end

function Base.:+(matrix1::Matrix1DArray, matrix2::Matrix1DArray)
    values = matrix1.values .+ matrix2.values
    result = Matrix1DArray(matrix1.rows, matrix1.columns, values)
    return result
end


function Base.:-(matrix1::Matrix1DArray, matrix2::Matrix1DArray)
    values = matrix1.values .- matrix2.values
    result = Matrix1DArray(matrix1.rows, matrix1.columns, values)
    return result
end


function mergeMatrixQuadrants(topLeft::Matrix1DArray,
                              topRight::Matrix1DArray,
                              bottomLeft::Matrix1DArray,
                              bottomRight::Matrix1DArray)

    result = Matrix1DArray(topLeft.rows + bottomLeft.rows,
                         topLeft.columns + topRight.columns, [])

    for row in 1:topLeft.rows
        index = (topLeft.columns*(row - 1))
        topLeftValues = [topLeft.values[i] for i in index + 1:index + topLeft.columns]
        topRightValues = [topRight.values[i] for i in index + 1:index + topRight.columns]

        append!(result.values, topLeftValues)
        append!(result.values, topRightValues)
    end

    for row in 1:bottomLeft.rows
        index = (bottomLeft.columns*(row - 1))
        bottomLeftValues = [bottomLeft.values[i] for i in index + 1:index + bottomLeft.columns]
        bottomRightValues = [bottomRight.values[i] for i in index + 1:index + bottomRight.columns]

        append!(result.values, bottomLeftValues)
        append!(result.values, bottomRightValues)
    end

    return result
end


function strassensMultiply(matrix1::Matrix1DArray, matrix2::Matrix1DArray)
    if matrix1.rows < 2
        value = matrix1.values[1]*matrix2.values[1]
        return Matrix1DArray(1, 1, [value])
    end
    topLeft1, topRight1, bottomLeft1, bottomRight1 = split(matrix1)
    topLeft2, topRight2, bottomLeft2, bottomRight2 = split(matrix2)

    m1 = strassensMultiply(topLeft1 + bottomRight1, topLeft2 + bottomRight2)
    m2 = strassensMultiply(bottomLeft1 + bottomRight1, topLeft2)
    m3 = strassensMultiply(topLeft1, topRight2 - bottomRight2)
    m4 = strassensMultiply(bottomRight1, bottomLeft2 - topLeft2)
    m5 = strassensMultiply(topLeft1 + topRight1, bottomRight2)
    m6 = strassensMultiply(bottomLeft1 - topLeft1, topLeft2 + topRight2)
    m7 = strassensMultiply(topRight1 - bottomRight1, bottomLeft2 + bottomRight2)

    topLeftResult = m1 + m4 - m5 + m7
    topRightResult = m3 + m5
    bottomLeftResult = m2 + m4
    bottomRightResult = m1 - m2 + m3 + m6

    result = mergeMatrixQuadrants(topLeftResult, topRightResult,
                                  bottomLeftResult, bottomRightResult)

    return result
end


function randomFillMatrix(matrix)
    randomValues = rand(matrix.rows * matrix.columns)
    append!(matrix.values, randomValues)
end


matrix1 = Matrix1DArray(4, 4, [1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4])
matrix2 = Matrix1DArray(4, 4, [1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4])

dimensions = [2^n for n in 1:10]
for dimension in dimensions
    local matrix1 = Matrix1DArray(dimension, dimension, [])
    local matrix2 = Matrix1DArray(dimension, dimension, [])
    randomFillMatrix(matrix1)
    randomFillMatrix(matrix2)
    println(dimension)
    @time strassensMultiply(matrix1, matrix2)
end
