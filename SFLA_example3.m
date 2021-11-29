%% Example 3 Function

% Book: A Collection of Test Problems for Constrained Global Optimization Algorithms
% Authors: Christodoulos A. Floudas, Panos M. Pardalos (Year: 1990)
% Chapter 4: Nonlinear Programming test problems 
% Test Problem 3 (Section 4.3) - Book Pg no. 28)

% Best known solution: -4.5142 at (x1,x2,u1,u2) = (4/3, 4, 0, 0)

clear;
close all;
clc;

% Start timer
%tic

%% Problem Definition

% Objective Function
problem.CostFunction = @(x) example3(x);

problem.nVar = 4;      % Number of Unknown Decision Variables
problem.VarMin = [0 0 0 0];   % Lower Bound of Decision Variables
problem.VarMax = [3 10 10 1];   % Upper Bound of Decision Variables

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


%% Example 3 Function
function z = example3(x)

x1 = x(1);
x2 = x(2);
u1 = x(3);
u2 = x(4);
rm = 200;
m = 0;

%Constraints
g(1) = x2 - 3*x1 - 3*u1;
if g(1) ~= 0
    m(1) = abs(g(1));
else
    m(1) = 0;
end

g(2) = x1 + 2*u1 - 4;
if g(2) <= 0
    m(2) = 0;
else
    m(2) = abs(g(2));
end

g(3) = x2 + 2*u2 - 4;
if g(3) <= 0
    m(3) = 0;
else
    m(3) = abs(g(3));
end

% Penalty
penalty = sum(m);

% Objective Function
z = (x1^0.6 + x2^0.6 - 6*x1 - 4*u1 + 3*u2) + rm*(penalty);

end

