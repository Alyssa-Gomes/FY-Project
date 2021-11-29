%% Example 2 Function

% Journal Article: Particle Swarm Optimization Method for Constrained Optimization Problems
% Authors: Parsopoulos K, Vrahatis M
% Test Problem 1 - Pg no. 5

% Best known solution: 1.3934651

clear;
close all;
clc;

% Start timer
%tic

%% Problem Definition

% Objective Function
problem.CostFunction = @(x) example2(x);

problem.nVar = 2;      % Number of Unknown Decision Variables
problem.VarMin = -10;   % Lower Bound of Decision Variables
problem.VarMax = 10;   % Upper Bound of Decision Variables

%% SFLA Parameters
params.MaxIt = 1000;                                  % Maximum Number of Iterations

params.nPopMemeplex = 10;                           % Memeplex Size 10
%params.nPopMemeplex = max(nPopMemeplex, nVar+1);   % Nelder-Mead Standard
params.nMemeplex = 5;                               % Number of Memeplexes 5

% FLA Parameters
params.alpha = 3;                                   % Number of offspring                       
params.beta = 5;                                    % Max number of iterations
params.w = 1;                                       % Weight factor - to avoid premature convergence
params.c1 = 2;                                      % Search acceleration factor for eqn 1
params.c2 = 2;                                      % Search acceleration factor for eqn 2

%% Calling SFLA
%out = sfla_algorithm(problem, params);

%% Output
%BestSol = out.BestSol;
%BestCosts = out.BestCosts;
%BestIter = out.BestIter;

%% Run program multiple times
NRuns = 30;      % Number of runs
bestposition = NaN(NRuns, problem.nVar);
bestcost = NaN(NRuns, 1);
bestiter = NaN(NRuns, 1);
RunTime = NaN(NRuns, 1);

for i = 1:NRuns
    rng(i, 'twister') % Varies the seed for the random numbers generated in the algorithm
    
    % Start timer
    tic
    
    out = sfla_algorithm(problem, params);
    BestSol = out.BestSol;
    BestCosts = out.BestCosts;
    BestIter = out.BestIter;
    
    % Record best values for each run
    bestposition(i,:) = BestSol.Position(:);
    bestcost(i) = BestSol.Cost;
    bestiter(i) = BestIter;
    
    % End timer
    RunTime(i) = toc;
    
end

%% Statistical Analysis
format long
MinCostVal = min(bestcost)
MaxCostVal = max(bestcost)
MeanCost = mean(bestcost)
MedianCost = median(bestcost)
StdDevCost = std(bestcost)
AvgCI = mean(bestiter)      % Average convergence iteration
AvgRunTime = mean(RunTime)

%% Results
%subplot(1,2,1)
%plot(BestCosts, 'LineWidth', 1);
%xlabel('Iteration');
%ylabel('Best fitness value');
%title('Best fitness value plot');

%subplot(1,2,2)
%semilogy(BestCosts, 'LineWidth', 1);
%xlabel('Iteration');
%ylabel('Best fitness value');
%title('Best fitness value semilog plot');

% Stop time
%toc


%% Example 2 Function
function z = example2(x)

x1 = x(1);
x2 = x(2);
rm = 200;
m = 0;

%Constraints
g(1) = x1 - 2*x2 + 1;
if g(1) ~= 0
    m(1) = abs(g(1));
else
    m(1) = 0;
end

g(2) = (x1^2/4) + x2^2 - 1;
if g(2) <= 0
    m(2) = 0;
else
    m(2) = abs(g(2));
end

penalty = sum(m);

z = (x1 - 2)^2 + (x2 - 1)^2 + rm*(penalty);

end
