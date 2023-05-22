function [averageNoise] = getAverageNoise(opticalIntensity, xCoords, yCoords)
% calculates the absolute mean optical instensity outside of the area that
% is being optimised
    peak = opticalIntensity(xCoords, yCoords);
    opticalIntensity(xCoords, yCoords) = 0;
    averageNoise = mean(mean(abs(opticalIntensity))) / peak;
end