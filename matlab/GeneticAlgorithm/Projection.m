classdef Projection
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here

    properties
        height
        width
        pattern
        cost
    end

    methods
        function obj = Projection(height, width, pattern, transmisionsMatrix)
            obj.height = height;
            obj.width = width;
            obj.pattern = pattern;
            obj.cost = obj.fitnessFunction(transmisionsMatrix);
        end

        function cost = fitnessFunction(obj, transmissionMatrix)
            electricField = exp(2*pi*1i*obj.pattern);
            opticalIntensity = abs((electricField * transmissionMatrix)).^2;
            cost = opticalIntensity(obj.height/2, obj.width/2);
        end
    
        function mutatedChild = mutate(obj, mutationSparsity, transmissionMatrix)
            mutatedPattern = obj.pattern + sprand(obj.height, obj.width, mutationSparsity);
            mutatedChild = Projection(obj.height, obj.width, mutatedPattern, transmissionMatrix);
        end
    end
end