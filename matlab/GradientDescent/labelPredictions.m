function [labelPredictions] = labelPredictions(sigmoidPredictions)
% converts the sigmoid function output into lable predictions
    labelPredictions = zeros(length(sigmoidPredictions), 1);
    for index = 1:length(sigmoidPredictions)
        if sigmoidPredictions(index) >= 0.5
            labelPredictions(index) = 1;
        end
    end
end