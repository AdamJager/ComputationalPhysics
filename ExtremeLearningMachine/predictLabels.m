function [predictions] = predictLabels(data, outputWeights, initialWeights, biases, alpha)
    predictions = hiddenNodes(data, initialWeights, biases, alpha) * outputWeights;
end