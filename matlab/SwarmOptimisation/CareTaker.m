classdef CareTaker < handle
    % This class manages all of the agents that explore a parameter space
    properties
        agents
        swarmBestPosition
        swarmBestPositionCost
    end

    methods
        function obj = CareTaker(numberOfAgents, initialPositions, ...
                                 cognitiveFactor, socialFactor, transmissionMatrix, ...
                                 velocityBounds, positionBounds)
            %UNTITLED Construct an instance of this class
            %   Detailed explanation goes here
            agents = Agent.empty(numberOfAgents, 0);
            for index = 1:numberOfAgents
                agents(index) = Agent(initialPositions(:,:,index), 0, ...
                                      initialPositions(:,:,index), 0, ...
                                      cognitiveFactor, socialFactor, transmissionMatrix, ...
                                      velocityBounds, positionBounds);
            end
            obj.agents = agents;
            obj.swarmBestPosition = 0;
            obj.swarmBestPositionCost = 0;
        end
        
        function updateAgents(obj, weight)
            for index = 1:length(obj.agents)
                obj.agents(index).updateCurrentPosition(weight);
                
            end
        end

        function updateSwarmBest(obj, newSwarmBestPosition, newSwarmBestCost)
            obj.swarmBestPosition = newSwarmBestPosition;
            obj.swarmBestPositionCost = newSwarmBestCost;
        end

        function updateSocialFactor(obj, newSocialFactor)
            for agent = obj.agents
                agent.updateSocialFactor(newSocialFactor);
            end
        end

        function updateCognitiveFactor(obj, newCognitiveFactor)
            for agent = obj.agents
                agent.updateSocialFactor(newCognitiveFactor);
            end
        end

        function checkSwarmBest(obj)
            % check if any of the agents have found something better
            % than the swarm best, and if yes then update it
            currentBestCost = obj.swarmBestPositionCost;
            for index = 1:length(obj.agents)
                agentBestCost = obj.agents(index).personalBestPositionCost;
                if agentBestCost > currentBestCost
                    currentBestCost = agentBestCost;
                    currentBestPosition = obj.agents(index).personalBestPosition;
                end
            end
            if currentBestCost > obj.swarmBestPositionCost
                obj.updateSwarmBest(currentBestPosition, currentBestCost);
                for index = 1:length(obj.agents)
                    obj.agents(index).updateSwarmBest(currentBestPosition);
                end
            end
        end
    end
end