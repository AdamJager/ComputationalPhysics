function [bestProjection, fitnessAtEachStep] = geneticAlgorithm(generations, numberOfProjections, projectionHeight, ...
                                projectionWidth, initialMutationSparsity, ...
                                finalMutationSparsity, decayFactor, ...
                                transmissionMatrix)

    fitnessAtEachStep = zeros(generations, 1);

    % generate inital random population
    patterns = normrnd(0, 0.5, projectionHeight, projectionWidth, numberOfProjections); % each row is a pattern
    
    % initialise object for each projection
    projections = Projection.empty(numberOfProjections,0);
    for index = 1:numberOfProjections
        projections(index) = Projection(projectionHeight, projectionWidth, patterns(:,:,index), transmissionMatrix);
    end


    for generation = 1:generations
    
        if mutationTimer == 0
            transmissionMatrix = transmissionMatrix + sprand(projectionHeight, projectionWidth, 0.5);
            mutationTimer = TMatrixMutationSpan;
        end

        mutationSparsity = (initialMutationSparsity - finalMutationSparsity) * exp(-(generation - 1)/decayFactor) + finalMutationSparsity;

    
        % sort by cost
        [~, index] = sort([projections.cost]);
        sortedProjections = projections(index);
        
    
        %select based on cost
        parents = randsample(sortedProjections, length(projections), true, [sortedProjections.cost]);
    
        %create child projections
        children = breed(parents, transmissionMatrix);
    
        
        %mutate child projections
        for index = 1:numberOfProjections/2
        
            children(index) = children(index).mutate(mutationSparsity, transmissionMatrix);
        end
    
        % replace worst half of the population with children
        sortedProjections(1:length(children)) = children;
        projections = sortedProjections;
        fitnessAtEachStep(generation) = sortedProjections(end).cost;
    end

    bestProjection = sortedProjections(end);

end