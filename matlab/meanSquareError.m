function meanSquareError = meanSquareError(predictions, labels)
    meanSquareError = (1/length(predictions))*sum(abs(labels - predictions).^2);
end