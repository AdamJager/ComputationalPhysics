function [averageFitness] = fitnessAgainstIterations(iterations, trialsPerStep,...
                                                     numberOfAgents, ...
                                                     cognitiveFactor, socialFactor, ...
                                                     maskHeight, maskWidth, weight, ...
                                                     transmissionMatrix)

    patterns = normrnd(0, 0.5, maskHeight, maskWidth, numberOfAgents);
    careTaker = CareTaker(numberOfAgents, patterns, cognitiveFactor, socialFactor, transmissionMatrix);
    fitness = zeros(trialsPerStep, iterations);
    for trial = 1:trialsPerStep
        for iteration = 1:iterations
            careTaker.updateAgents(weight);
            careTaker.checkSwarmBest();
            fitness(trial, iteration) = careTaker.swarmBestPositionCost;
        end
    end
    if trialsPerStep > 1
        averageFitness = mean(fitness);
    else
        averageFitness = fitness;
    end
end