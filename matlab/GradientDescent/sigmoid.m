function [activation] = sigmoid(input)
% Sigmoid activation function for gradient descent algorithm
    activation = 1./(1 + exp(-input));
end