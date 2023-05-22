function [output] = hiddenNodes(xTrain, inputWeights, biases, alpha)
    linearFit = alpha*(xTrain*inputWeights + biases);
    output = ReLu(linearFit);
end