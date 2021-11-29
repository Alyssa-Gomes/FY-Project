%% Example 4 Function

% Book: A Collection of Test Problems for Constrained Global Optimization Algorithms
% Authors: Christodoulos A. Floudas, Panos M. Pardalos (Year: 1990)
% Chapter 4: Nonlinear Programming test problems 
% Test Problem 5 (Section 4.3) - Book Pg no. 29)

% Best known solution: -11.96 at (x1,x2,x3,u1,u2,u3) = (0.67, 2, 4, 0, 0, 0)

clear;
close all;
clc;

%% Problem Definition
problem.Function = @(x) example4(x);  % Cost Function
problem.nVar = 6;      % Number of Unknown Decision Variables
problem.VarMin = [0 0 0 0 0 0];   % Lower Bound of Decision Variables
problem.VarMax = [3 5 4 5 2 5];   % Upper Bound of Decision Variables

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
RunTime = NaN(NRuns, 1);

for i = 1:NRuns
    rng(i, 'twister') % Varies the seed for the random numbers generated in the algorithm
    
    % Start timer
    tic
    
    out = pso_algorithm(problem, params);
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

%% Example 4 Function
function z = example4(x)

x1 = x(1);
x2 = x(2);
x3 = x(3);
u1 = x(4);
u2 = x(5);
u3 = x(6);

rm = 200;
m = 0;

%Constraints
g(1) = x2 - 3*x1 - 3*u1;
if g(1) ~= 0
    m(1) = (abs(g(1)))^2;
else
    m(1) = 0;
end

g(2) = x3 - 2*x2 - 2*u2;
if g(2) ~= 0
    m(2) = (abs(g(2)))^2;
else 
    m(2) = 0;
end

g(3) = 4*u1 - u3;
if g(3) ~= 0
    m(3) = (abs(g(3)))^2;
else
    m(3) = 0;
end

g(4) = x1 + 2*u1 - 4;
if g(4) <= 0
    m(4) = 0;
else
    m(4) = abs(g(4));
end

g(5) = x2 + u2 - 4;
if g(5) <= 0
    m(5) = 0;
else
    m(5) = abs(g(5));
end

g(6) = x3 + u3 - 6;
if g(6) <= 0
    m(6) = 0;
else
    m(6) = abs(g(6));
end

% Penalty
penalty = sum(m);

% Objective Function
z = (x1^0.6 + x2^0.6 + x3^0.4 + 2*u1 + 5*u2 - 4*x3 - u3) + rm*(penalty);

end
