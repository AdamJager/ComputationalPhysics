function [convergance, fitness] = SocialCognitivePlot(socialRange, cognitiveRange, particles, ...
                                                      trialsPerStep, maskHeight, maskWidth, ...
                                                      weight, transmissionMatrix)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    convergance = zeros(length(socialRange), length(cognitiveRange), trialsPerStep);
    fitness = zeros(length(socialRange), length(cognitiveRange), trialsPerStep);
    rowIndex = 1;
    for socialFactor = socialRange
        colIndex = 1;
        for cognitiveFactor = cognitiveRange
            for trial = 1:trialsPerStep
            [~, bestFitness, ~, iterationsToConverge, ~] = swarmOptimiser(-1, particles, cognitiveFactor, ...
                                                                socialFactor, maskHeight, maskWidth, ...
                                                                weight, transmissionMatrix, [-1,1], [-1, 1]);
                convergance(rowIndex, colIndex, trial) = iterationsToConverge;
                fitness(rowIndex, colIndex, trial) = bestFitness;
            end
            colIndex = colIndex + 1;
        end
        rowIndex = rowIndex + 1;
    end
    convergance = mean(convergance, 3);
    fitness = mean (fitness, 3);
end