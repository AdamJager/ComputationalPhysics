classdef Agent < handle
    % General exploration unit of the swarm
    properties
        currentPosition
        currentPositionCost
        currentVelocity
        personalBestPosition
        personalBestPositionCost
        swarmBestPosition
        cognitiveFactor
        socialFactor
        transmissionMatrix
        velocityBounds
        positionBounds
    end

    methods
        function obj = Agent(currentPosition, currentVelocity, ...
                             personalBestPosition, swarmBestPosition, ...
                             cognitiveFactor, socialFactor, transmissionMatrix, ...
                             velocityBounds, positionBounds)
            obj.currentPosition = currentPosition;
            obj.currentVelocity = currentVelocity;
            obj.personalBestPosition = personalBestPosition;
            obj.transmissionMatrix = transmissionMatrix;
            obj.currentPositionCost = obj.fitnessFunction(currentPosition);
            obj.personalBestPositionCost = obj.fitnessFunction(personalBestPosition);
            obj.swarmBestPosition = swarmBestPosition;
            obj.cognitiveFactor = cognitiveFactor;
            obj.socialFactor = socialFactor;
            obj.velocityBounds = velocityBounds;
            obj.positionBounds = positionBounds;

        end

        function updateSwarmBest(obj, newSwarmBestPosition)
            obj.swarmBestPosition = newSwarmBestPosition;
        end

        function setSocialFactor(obj, newSocialFactor)
            obj.socialFactor = newSocialFactor;
        end

        function setCognitiveFactor(obj, newCognitiveFactor)
            obj.cognitiveFactor = newCognitiveFactor;
        end

        function property = stickyBoundaryConditions(obj, bounds, property)
            lowerIndexes = find(property<bounds(1));
            upperIndexes = find(property>bounds(2));
            property(lowerIndexes) = bounds(1);
            property(upperIndexes) = bounds(2);
        end

        function fitness = fitnessFunction(obj, mask)
            % Gives a fitness score based on how high an arbitrary pixels value is
            % The arbitrary pixel is the one that the algorithm maximises
            % I've chosen the middle pixel
            dims = size(mask);
            electricField = exp(2*pi*1i*mask);
            opticalIntensity = abs((electricField * obj.transmissionMatrix)).^2;
            fitness = opticalIntensity(ceil(dims(1)/2), ceil(dims(2)/2));
        end

        function velocity = calculateVelocity(obj)
            randomNumber = rand(2,1);
            velocity = (obj.cognitiveFactor*randomNumber(1)*(obj.personalBestPosition - obj.currentPosition)) ...
                      + (obj.socialFactor*randomNumber(2)*(obj.swarmBestPosition - obj.currentPosition));
        end

        function inertia = calculateInertia(obj, weight)
            inertia = weight * obj.currentVelocity;
        end

        function updateCurrentPosition(obj, weight)
            inertia = obj.calculateInertia(weight);
            nextVelocity = obj.calculateVelocity();
            obj.currentVelocity = obj.stickyBoundaryConditions(obj.velocityBounds, nextVelocity);
            nextPosition = obj.currentPosition + nextVelocity + inertia;
            obj.currentPosition = obj.stickyBoundaryConditions(obj.positionBounds, nextPosition);
            nextPositionCost = obj.fitnessFunction(nextPosition);
            if nextPositionCost > obj.personalBestPositionCost
                obj.currentPositionCost = nextPositionCost;
                obj.personalBestPosition = obj.currentPosition;
                obj.personalBestPositionCost = nextPositionCost;
            else
                obj.currentPositionCost = nextPositionCost;
            end
        end
    end
end