# main

using Plots, Random, Distributions
include("adam_predictor_corrector.jl")
include("duffing_equations.jl")
include("parallelised_monteCarlo_method.jl")

#=
posArray, velArray = AdamsBashforthSolver(duffingVelocity, duffingAcceleration, 0, 0, 0, 5000, 0.001,
                                          plotting = true, poincareSection = true)
scatter(posArray, velArray)
=#

pos, vel = randGaussianCoords(7000)
initialConditions = hcat(pos, vel)


anim = Animation()

for runTime in 28:0.1:56
        mGrid = MonteCarloGrid([5,5], [2e-2, 2e-2], nothing)
        filledGrid = monteCarloMethod(mGrid, initialConditions, AdamsBashforthSolver, duffingVelocity, duffingAcceleration, 0, runTime, 0.01)
        heatPlot = heatmap(filledGrid.phaseSpace)
        frame(anim, heatPlot)
        println(runTime)
end

gif(anim, fps = 12)