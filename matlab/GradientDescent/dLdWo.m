function [gradient] = dLdWo(labels, predictions)
% returns the gradient of the binary cross entropy loss function with
% respect to Wo
    gradient = (1/length(labels)) * sum(predictions - labels);
end