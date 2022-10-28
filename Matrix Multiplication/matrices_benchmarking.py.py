# different matrix implementations

import time
import random

class Matrix2DArray:

    def __init__(self, rows, columns, values=[[None]]):
        if values != [[None]]:
            self.matrix = values
        else:
            self.matrix = [[random.random() for i in range(columns)] for i in range(rows)]

        self.rows = rows
        self.columns = columns



    def multiply(self, other):
        result = [[0 for i in range(self.rows)] for i in range(other.columns)]
        total = 0

        if self.columns != other.rows:
             return "Erorr: these matrices aren't compatible"

        for i in range(self.rows):
            for j in range(other.columns):
                for k in range(other.rows):
                    total += self.matrix[i][k] * other.matrix[k][j]

                result[i][j] = total
                total = 0

        return result


class Matrix1DArray:

    def __init__(self, rows, columns, values=[None]):
        if values != [None]:
            self.matrix = values
        else:
            self.matrix = [random.random() for i in range(rows * columns)]

        self.rows = rows
        self.columns = columns



    def multiply(self, other):
        result = [0 for i in range(self.rows * other.columns)]
        total = 0

        for i in range(self.rows):
            for j in range(other.columns):
                for k in range(other.rows):
                    total += self.matrix[self.rows*i + k] * other.matrix[other.columns*k + j]

                result[self.rows*i + j] = total
                total = 0

        return result
        

class Node:

    def __init__(self, value, pointer = None):
        self.value = value
        self.pointer = pointer


class LinkedList:

    def __init__(self):
        self.head = None
        self.lastNode = None
        self.size = 0

    def addNode(self, value):
        newNode = Node(value, None)

        if self.size == 0:
            self.head = newNode
        else:
            self.lastNode.pointer = newNode
        self.lastNode = newNode
        self.size += 1


    def getNodeVal(self, index):
        currentNode = self.head
        
        for i in range(index + 1):
            if i == index:
                return currentNode.value
            currentNode = currentNode.pointer


    def printList(self):
        currentNode = self.head
        
        while currentNode.pointer != None:
            print(currentNode.value)
            currentNode = currentNode.pointer
        print(currentNode.value)

    
class MatrixLinkedList(LinkedList):

    def __init__(self, rows, columns, values = [None]):
        self.matrix = LinkedList()
        self.rows = rows
        self.columns = columns
        
        if values != [None]:
            for value in values:
                self.matrix.addNode(value)

        else:
            for value in [random.random() for i in range(rows * columns)]:
                self.matrix.addNode(value)


    def getNodeVal(self, index):
        currentNode = self.matrix.head
        
        for i in range(index + 1):
            if i == index:
                return currentNode.value
            currentNode = currentNode.pointer


    def multiply(self, other):
        result = MatrixLinkedList(0,0)
        total = 0

        for i in range(self.rows):
            for j in range(other.columns):
                for k in range(other.rows):
                    total += self.matrix.getNodeVal(self.rows*i + k) * other.matrix.getNodeVal(other.columns*k + j)

                result.matrix.addNode(total)
                total = 0

        return result


matrix1 = MatrixLinkedList(2,2)
matrix2 = MatrixLinkedList(2,2)

print(f"matrix1: {matrix1.matrix.printList()}")
print(f"matrix2: {matrix2.matrix.printList()}")
matrix3 = matrix1.multiply(matrix2)
print(f"rows: {matrix3.rows}, columns: {matrix3.columns}, size: {matrix3.matrix.size}")
matrix3.matrix.printList()





















        



