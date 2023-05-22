function [iterations] = weightAgainstConvergance(weightRange, trialsPerStep, particles, ...
                                             cognitiveFactor, socialFactor, ...
                                             maskHeight, maskWidth, frostedGlass)

    iterations = zeros(trialsPerStep, length(weightRange));
    colIndex = 1;
    for weight = weightRange
        for trial = 1:trialsPerStep
            [~,~, ~, iterationsToConverge, ~] = swarmOptimiser(-1, particles, cognitiveFactor, ...
                                                                            socialFactor, maskHeight, maskWidth, ...
                                                                            weight, frostedGlass, [-1,1], [-1, 1]);
            iterations(trial, colIndex) = iterationsToConverge;
        end
        colIndex = colIndex + 1;
    end
    iterations = mean(iterations);
end