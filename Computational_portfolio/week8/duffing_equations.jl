# duffing equations

function duffingVelocity(currentPosition::Number,
                         previousPosition::Number,
                         timeStep::Number)

    return (currentPosition - previousPosition) / timeStep
end


function duffingAcceleration(position::Number,
                             velocity::Number,
                             time::Number;
                             dampingFactor::Number = 0.1,
                             drivingForceStrength::Number = 0.35,
                             frequency::Number = 1.4,
                             stiffness::Number = 1,
                             non_linearity::Number = 1)

    return ((stiffness * position) -
            (non_linearity * position^3) -
            (dampingFactor * velocity) +
            (drivingForceStrength * cos(frequency * time)))
end