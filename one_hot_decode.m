function values = one_hot_decode(predictions)
    rows = size(predictions, 1);
    values = zeros(rows, 1);

    for row = 1:rows
        [maxValue, valueIndex] = max(predictions(row, :));
        values(row) = valueIndex - 1;
    end
    
end