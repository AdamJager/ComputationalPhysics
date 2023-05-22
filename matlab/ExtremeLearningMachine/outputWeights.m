function [outputWeights, initialWeights, biases] = outputWeights(xTrain, labels, inputLayerSize, hiddenLayerSize, alpha)
    initialWeights = normrnd(0, 0.5, inputLayerSize, hiddenLayerSize);
    biases = normrnd(0, 0.5, hiddenLayerSize, 1)';
    outputWeights = pinv(hiddenNodes(xTrain, initialWeights, biases, alpha)) * labels;
end