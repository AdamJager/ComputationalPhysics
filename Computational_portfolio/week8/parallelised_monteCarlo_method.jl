# parallisation of the monte carlo method

# Monte Carlo method applied to the driven dampended duffing oscillator

struct MonteCarloGrid
    gridDimensions::Vector{Number}
    pixelDimensions::Vector{Number}
    phaseSpace
    MonteCarloGrid(gridDimensions::Vector,
                   pixelDimensions::Vector,
                   phaseSpace::Nothing) = new(gridDimensions::Vector,
                                              pixelDimensions::Vector,
                                              monteCarloGridConstructor(gridDimensions, pixelDimensions))
end

struct particle 
    position::Number
    velocity::Number
end


function monteCarloGridConstructor(gridDimensions::Vector, pixelDimensions::Vector)
    xdimension = Integer(round(gridDimensions[1]/pixelDimensions[1]))
    ydimension = Integer(round(gridDimensions[2]/pixelDimensions[2]))
    return zeros(xdimension, ydimension) 
end

function randGaussianCoords(size)
    randomAngle = rand(size) .* pi
    randomRadius = rand(Normal(), size) .* 0.5

    randPosition = randomRadius .* cos.(randomAngle)
    randVelocity = randomRadius .* sin.(randomAngle)

    return randPosition, randVelocity
end


function monteCarloMethod(grid::MonteCarloGrid,
                          initialConditions::Matrix,
                          solverFunc::Function,
                          velocityFunc::Function,
                          accelerationFunc::Function,
                          startTime::Number,
                          simLength::Number,
                          timeStep::Number;
                          plotting::Bool = false)

    gridSize = size(initialConditions, 1)

    Threads.@threads for index in 1:gridSize
        initialPos, initialVel = initialConditions[index, :]
        finalPos, finalVel = solverFunc(velocityFunc,
                                        accelerationFunc,
                                        initialPos,
                                        initialVel,
                                        startTime,
                                        simLength,
                                        timeStep) .+ 2.5
        
        positionCoord = floor(Int, finalPos/grid.pixelDimensions[1])
        velocityCoord = floor(Int, finalVel/grid.pixelDimensions[2])

        grid.phaseSpace[velocityCoord, positionCoord] += 1
    end

    if plotting == true
        heatmap(grid.phaseSpace)
    end
    return grid
end
