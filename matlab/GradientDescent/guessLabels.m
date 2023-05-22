function [predictions] = guessLabels(data, solution, offset)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    linearPredictions = data*solution + offset;
    sigmoidPredictions = sigmoid(linearPredictions);
    predictions = labelPredictions(sigmoidPredictions);
end