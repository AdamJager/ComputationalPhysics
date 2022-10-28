using Parameters
using Random


mutable struct Node
    value::AbstractFloat
    pointer
end


Base.@kwdef mutable struct LinkedList
    head = nothing
    lastNode = nothing
    size::Int = 0
end


function addNode(list, value)
    newNode = Node(value, nothing)

    if list.size == 0
        list.head = newNode
    else
        list.lastNode.pointer = newNode
    end
    list.lastNode = newNode
    list.size += 1

end


function getNodeVal(list, index)
    currentNode = list.head

    for i in 1:index
        if i == index
            return currentNode.value
        end
        currentNode = currentNode.pointer
    end
end

function printList(list)
    currentNode = list.head

    while currentNode.pointer != nothing
        println(currentNode.value)
        currentNode = currentNode.pointer
    end
    print(currentNode.value)
end


Base.@kwdef mutable struct MatrixLinkedList
    matrix::LinkedList = LinkedList()
    rows::Int
    columns::Int
end

function addValuesToMatrix(matrix::MatrixLinkedList, values::Array)
    for value in values
        addNode(matrix.matrix, value)
    end
end

function randomFillMatrix(matrix::MatrixLinkedList)
    for value in rand(matrix.rows * matrix.columns)
        addNode(matrix.matrix, value)
    end
end

function multiply(matrix1::MatrixLinkedList, matrix2::MatrixLinkedList)
    result = MatrixLinkedList(rows = matrix1.rows, columns = matrix2.columns)
    total = 0

    for rows1 in 1:matrix1.rows
        for columns2 in 1:matrix2.columns
            for rows2 in 1:matrix2.rows
                total += getNodeVal(matrix1.matrix, matrix1.rows*(rows1-1) + rows2) *
                         getNodeVal(matrix2.matrix, matrix2.columns*(rows2-1) + columns2)
            end
            addNode(result.matrix, total)
            total = 0
        end
    end
    return result
end

for dimension in 10:100:1000
    matrix1 = MatrixLinkedList(rows = dimension, columns = dimension)
    matrix2 = MatrixLinkedList(rows = dimension, columns = dimension)
    randomFillMatrix(matrix1)
    randomFillMatrix(matrix2)
    @time multiply(matrix1, matrix2)
    sleep(0.1)
end
