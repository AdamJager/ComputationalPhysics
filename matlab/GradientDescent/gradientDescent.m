function [solution, offset, accuracyResults, costFunctionResults] = gradientDescent(data, labels, learningRate, iterations)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    solution = zeros(size(data, 2), 1);
    accuracyResults = zeros(iterations, 1);
    costFunctionResults = zeros(iterations, 1);
    offset = 0;
    for iteration = 1:iterations
        [solution, offset, ~, sigmoid] = gradientDescentStep(data, labels, learningRate, solution, offset);
        labelPredictions = guessLabels(data, solution, offset);
        accuracy = getAccuracy(labelPredictions, labels);
        accuracyResults(iteration, 1) = accuracy;
        costFunctionResults(iteration, 1) = crossEntropyLoss(labels, sigmoid);
    end
end