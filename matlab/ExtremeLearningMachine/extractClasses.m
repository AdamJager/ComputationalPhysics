function [twoClassData,twoClassLabels] = extractClasses(data, labels, class1, class2)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    indexes = find(labels == class1 | labels == class2);
    twoClassData = data(indexes, :);
    twoClassLabels = (labels(indexes) == class1);
end