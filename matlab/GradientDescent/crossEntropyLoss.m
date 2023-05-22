function [error] = crossEntropyLoss(labels, sigmoidGuesses)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
    error = (1/length(labels)) * sum(-(labels.*log(sigmoidGuesses) + (1 - labels).*log(1 - sigmoidGuesses)));
end