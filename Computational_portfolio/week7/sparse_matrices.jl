# Sparse matrix structures

struct COO_SparseMatrix
    rows
    columns
    rowIndices
    columnIndices
    values

    function COO_SparseMatrix(values::Matrix)
        rows, columns = size(values)
        rowIndices, columnIndices, compressedValues = cooCompression(values)
        new(rows, columns, rowIndices, columnIndices, compressedValues)
    end

end


struct CSR_SparseMatrix
    rows
    columns
    rowPointers
    columnIndices
    values

    function CSR_SparseMatrix(values::Matrix)
        rows, columns = size(values)
        rowPointers, columnIndices, compressedValues = csrCompression(values)
        new(rows, columns, rowPointers, columnIndices, compressedValues)
    end

end


function cooCompression(matrix::Matrix)
    rowIndices = Any[]
    columnIndices = Any[]
    values = Any[]
    rows, columns = size(matrix)
    for col in 1:columns
        for row in 1:rows
            value = matrix[row, col]
            if value != 0
                push!(rowIndices, row)
                push!(columnIndices, col)
                push!(values, value)
            end
        end
    end
    return rowIndices, columnIndices, values
end


function csrCompression(matrix::Matrix)
    rowPointers = []
    columnIndices = []
    values = []
    rows, columns = size(matrix)
    currentRowPointer = 0
    for row in 1:rows
        for col in 1:columns
            value = matrix[row, col]
            if value != 0
                if currentRowPointer != row
                    push!(rowPointers, row)
                    currentRowPointer = row
                end
                push!(columnIndices, col)
                push!(values, value)
            end
        end
    end
    return rowPointers, columnIndices, values
end


function matrixMultiply(matrix1::CSR_SparseMatrix, matrix2::CSR_SparseMatrix)
    result = zeros(matrix1.columns, matrix2.rows)
    for value1 in matrix1.values
        for value2 in matrix2.values
            
        end
    end
end


function matrixMultiply(matrix1::COO_SparseMatrix, matrix2::COO_SparseMatrix)
    result = zeros(matrix1.columns, matrix2.rows)

    for m1Pointer in 1:length(matrix1.values)
        for m2Pointer in 1:length(matrix2.values)
            if matrix1.columnIndices[m1Pointer] == matrix2.rowIndices[m2Pointer]
                row = matrix1.rowIndices[m1Pointer]
                column = matrix2.columnIndices[m2Pointer]
                result[row, column] += matrix1.values[m1Pointer] * matrix2.values[m2Pointer]
            end
        end
    end
    return result
end


function generateSparseMatrix(rows::Integer, columns::Integer, density = 0.05::Number)
    @assert !(density > 1 || density <= 0) "This density is undefined for a matrix"

    sparceMatrix = zeros(rows, columns)

    for rowIndex in 1:rows
        for columnIndex in 1:columns
            randomNumber = rand()
            if density > randomNumber
                sparceMatrix[rowIndex, columnIndex] = rand(Int)
            end
        end
    end

    return sparceMatrix
end


#=
for dimensions in 10:10:1000
    matrix1 = COO_SparseMatrix(generateSparseMatrix(dimensions, dimensions))
    matrix2 = COO_SparseMatrix(generateSparseMatrix(dimensions, dimensions))
    @time matrixMultiply(matrix1, matrix2)
end
=#


matrix1 = [0 0 1 0; 0 2 1 0; 0 0 0 0; 0 0 1 0]
matrix2 = [0 1 1 0; 0 3 0 0; 0 0 0 3; 1 0 1 0]
coo_sparseMatrix1 = COO_SparseMatrix(matrix1)
coo_sparseMatrix2 = COO_SparseMatrix(matrix2)
csr_sparseMatrix1 = CSR_SparseMatrix(matrix1)
csr_sparseMatrix2 = CSR_SparseMatrix(matrix2)

matrixMultiply(sparseMatrix1, sparseMatrix2)