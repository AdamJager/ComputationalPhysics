function [gradient] = dLdW(data, labels, predictions)
% returns the gradient of the binary cross entropy loss function with respect to W
    gradient = (1/length(labels)) * (predictions - labels)' * data;
end