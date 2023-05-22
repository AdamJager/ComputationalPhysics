function fitness = fitnessFunction(mask, transmissionMatrix)
    % Gives a fitness score based on how high an arbitrary pixels value is
    % The arbitrary pixel is the one that the algorithm maximises
    % I've chosen the middle pixel
    dims = size(mask);
    electricField = exp(2*pi*1i*mask);
    opticalIntensity = abs((electricField * transmissionMatrix)).^2;
    fitness = opticalIntensity(ceil(dims(1)/2), ceil(dims(2)/2));
end