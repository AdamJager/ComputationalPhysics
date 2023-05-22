function [children] = breed(parents, transmissionMatrix)
% Breeds consecutive parents using a binary matrix 
    height = parents(1).height;
    width = parents(1).width;
    breadingTemplate = randi([0 1], height, width);
    children = Projection.empty(length(parents)/2,0);
    childIndex = 1;
    for index = 1:2:length(parents);
        childPattern = parents(index).pattern .* breadingTemplate + parents(index + 1).pattern .* (1 - breadingTemplate);
        children(childIndex) = Projection(height, width, childPattern, transmissionMatrix);
        childIndex = childIndex + 1;
    end
end