function [projections] = mutate(projections)
%Mutates the elements in a projections pattern by add/subtracting a random
%value from a random amount of elements. 
    for index = 1:length(projections)
        mutationTemplate = sprand(projections(index).height, projection(index).width, 0.25);
        projections(index) = projections(index).pattern + mutationTemplate;
    end
end