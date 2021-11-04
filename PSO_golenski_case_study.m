%% Case Study

% Journal Article: Design Optimization of a Speed Reducer Using Deterministic Techniques
% Paper no. 7 (in drive folder)
% Authors: Ming-Hua Lin,Jung-Fa Tsai,Nian-Ze Hu,and Shu-Chuan Chang
% Pg no. 3

% Best known solution ranges between: 3019.583365 with error <10^-1 to 2876.219475 with error <10^0
% Paper referred to - optimal soln: 2994.471921 with error in const <10^-6

clear;
close all;
clc;

% Start timer:
%tic

%% Problem Definition
problem.Function = @(x) golenski_case_study(x);  % Cost Function
problem.nVar = 7;      % Number of Unknown Decision Variables
problem.VarMin = [2.6 0.7 17 7.3 7.3 2.9 5];   % Lower Bound of Decision Variables
problem.VarMax = [3.6 0.8 28 8.3 8.3 3.9 5.5];   % Upper Bound of Decision Variables

%% PSO Parameters

params.MaxIt = 1000;        % Maximum Number of Iterations
params.nPop = 20;           % Population (Swarm) Size          
params.w = 0.7298;            % Intertia Coefficient
params.wdamp = 1;           % Inertia Coefficient Damping Ratio
params.c1 = 1.49609;           % Personal Acceleration Coefficient 
params.c2 = 1.49609;           % Social Acceleration Coefficient
params.ShowIterInfo = true; % Iteration Flag

%% Calling PSO
out = pso_algorithm(problem, params);

%% Output
%BestSol = out.BestSol;
%BestCosts = out.BestCosts;
%BestIter = out.BestIter;

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

%% Result Plots
%subplot(1,2,1)
%plot(0:params.MaxIt, BestCosts, 'LineWidth', 1);
%xlabel('Iteration');
%ylabel('Best fitness value');
%title('Best fitness value plot');

%subplot(1,2,2)
%semilogy(0:params.MaxIt, BestCosts, 'LineWidth', 1);
%xlabel('Iteration');
%ylabel('Best fitness value');
%title('Best fitness value semilog plot');

% Stop timer
%toc
