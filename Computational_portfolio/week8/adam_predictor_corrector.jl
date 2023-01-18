# Adam predictor corrector method to the second order 


function AdamsBashforthSolver(velocityFunc::Function,
                              accelerationFunc::Function,
                              initialPosition::Number,
                              initialVelocity::Number,
                              startTime::Number,
                              simLength::Number,
                              timeStep::Number;
                              poincareSection::Bool = false,
                              plotting::Bool = false)


    omega = 1.4

    positionArray = []
    velocityArray = []

    previousPosition = currentPosition = 0
    previousVelocity = currentVelocity = 0

    for currentTime in startTime:timeStep:startTime + simLength
        
        # taking the first step using explicit euler method
        if currentTime == 0
            currentPosition = initialPosition + initialVelocity * timeStep
            currentVelocity = initialVelocity + accelerationFunc(initialPosition, initialVelocity, currentTime) * timeStep

            if plotting == true && poincareSection == false
                push!(positionArray, currentPosition)
                push!(velocityArray, currentVelocity)
            end
            previousPosition = initialPosition
            previousVelocity = initialVelocity
            continue
        end

        # stepping using the adam predictor corrector method
        predictedPosition = currentPosition + (timeStep/2)*(3*currentVelocity - previousVelocity)
        predictedVelocity = currentVelocity + (timeStep/2)*(3*accelerationFunc(currentPosition, currentVelocity, currentTime) - 
                                                            accelerationFunc(previousPosition, previousVelocity, (currentTime - timeStep)))

        nextPosition = currentPosition + (timeStep/2)*(velocityFunc(predictedPosition, currentPosition, timeStep) + currentVelocity)
        nextVelocity = currentVelocity + (timeStep/2)*(accelerationFunc(predictedPosition, predictedVelocity, (currentTime + timeStep)) +
                                                    accelerationFunc(currentPosition, currentVelocity, currentTime))

        previousPosition, previousVelocity = currentPosition, currentVelocity
        currentPosition, currentVelocity = nextPosition, nextVelocity

        if poincareSection == true
            if mod(currentTime, (2*pi)/omega) <= 1e-3
                push!(positionArray, nextPosition)
                push!(velocityArray, nextVelocity)
            end
        else 
            push!(positionArray, nextPosition)
            push!(velocityArray, nextVelocity)
        end
    end

    if plotting == true
        return positionArray, velocityArray
    end
    return currentPosition, currentVelocity 
end
