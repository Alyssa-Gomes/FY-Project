% PSO - Eggholder Benchmark Function

clear;
close all;
clc;

%% Problem Definition
problem.Function = @(x) eggholder(x);  % Cost Function
problem.nVar = 2;      % Number of Unknown Decision Variables
problem.VarMin = -512;   % Lower Bound of Decision Variables
problem.VarMax =  512;   % Upper Bound of Decision Variables

%% PSO Parameters
params.MaxIt = 1000;        % Maximum Number of Iterations
params.nPop = 50;           % Population (Swarm) Size          
params.w = 0.65;            % Intertia Coefficient
params.wdamp = 1;           % Inertia Coefficient Damping Ratio
params.c1 = 1.65;           % Personal Acceleration Coefficient 
params.c2 = 1.75;           % Social Acceleration Coefficient
params.ShowIterInfo = true; % Iteration Flag

%% Run program multiple times
NRuns = 30;      % Number of runs
bestposition = NaN(NRuns, problem.nVar);
bestcost = NaN(NRuns, 1);
bestiter = NaN(NRuns, 1);

for i = 1:NRuns
    rng(i, 'twister') % Varies the seed for the random numbers generated in the algorithm
    out = pso_algorithm(problem, params);
    BestSol = out.BestSol;
    BestCosts = out.BestCosts;
    BestIter = out.BestIter;
    
    % Record best values for each run
    bestposition(i,:) = BestSol.Position(:);
    bestcost(i) = BestSol.Cost;
    bestiter(i) = BestIter;
end

%% Statistical Analysis
format long
MinCostVal = min(bestcost)
MaxCostVal = max(bestcost)
MeanCost = mean(bestcost)
MedianCost = median(bestcost)
StdDevCost = std(bestcost)
AvgConvergence = mean(bestiter)

%% Calling PSO
%out = pso_algorithm(problem, params);
%BestSol = out.BestSol;
%BestCosts = out.BestCosts;

%% Results
%figure;
% plot(BestCosts, 'LineWidth', 2);
%semilogy(BestCosts, 'LineWidth', 2);
%xlabel('Iteration');
%ylabel('Best Cost');
%grid on;
