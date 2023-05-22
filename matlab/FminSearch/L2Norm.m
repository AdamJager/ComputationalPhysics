function L2Norm = L2Norm(predictions, lables)
    % computes the normalised l1 error of the predictions
    valuesSize = size(predictions);
    L2Norm = (1/valuesSize(1)*valuesSize(2)) * sqrt(sum(abs(predictions - lables)^2));
end