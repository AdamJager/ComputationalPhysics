function transmissionMatrix = transmissionMatrix(height, width)
% Generates a complex tranmission matrix with dimensions taken as input
% The random elements have a gaussian distribution with mean = 0 and
% variance = 0.5
mean = 0;
variance = 0.5;
real = normrnd(mean, variance, height, width);
imag = 1i*normrnd(mean, variance, height, width);

transmissionMatrix = (real + imag)./(height * width);
end