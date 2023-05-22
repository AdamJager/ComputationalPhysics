function transmissionMatrix = transmissionMatrix(height, width, mean, variance)
% Generates a complex tranmission matrix with dimensions taken as input
% The random elements have a gaussian distribution
real = normrnd(mean, variance, height, width);
imag = 1i*normrnd(mean, variance, height, width);
transmissionMatrix = (real + imag)./(height * width);
end