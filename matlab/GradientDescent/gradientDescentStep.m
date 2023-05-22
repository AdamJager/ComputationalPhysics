function [solution, offset, linearPredictions, sigmoidPredictions] = gradientDescentStep(data, labels, learningRate, solution, offset)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

    linearPredictions = data*solution + offset;
    sigmoidPredictions = sigmoid(linearPredictions);
    
    weightsGradient = dLdW(data, labels, sigmoidPredictions);
    biasGradient = dLdWo(labels, sigmoidPredictions);
    
    solution = solution - learningRate.*weightsGradient';
    offset = offset - learningRate*biasGradient;
end