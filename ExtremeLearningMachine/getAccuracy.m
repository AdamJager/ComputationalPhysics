function [accuracy] = getAccuracy(labelGuesses, labels)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    difference = labelGuesses- labels;
    accuracy = sum(difference(:) == 0) / length(difference) * 100;
end