%% Example (Speed Reducer) Function

% Book: A Collection of Test Problems for Constrained Global Optimization Algorithms
% Authors: Christodoulos A. Floudas, Panos M. Pardalos (Year: 1990)
% Chapter 11: Mechanical Design test problems 
% Test Problem 3 (Section 11.3) - Book Pg no. 153)

% Best known solution: 2294.47 at (x1,x2,x3,x4,x5,x6,x7) = (3.5, 0.7, 17, 7.3, 7.71, 3.35, 5.287)

clear;
close all;
clc;

%% Problem Definition
problem.Function = @(x) example_sr(x);  % Cost Function
problem.nVar = 7;      % Number of Unknown Decision Variables
problem.VarMin = [2.6 0.7 17 7.3 7.3 2.9 5];   % Lower Bound of Decision Variables
problem.VarMax = [3.6 0.8 28 8.3 8.3 3.9 5.5];   % Upper Bound of Decision Variables

%% PSO Parameters
params.MaxIt = 5000;        % Maximum Number of Iterations
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

%% Example (Speed Reducer) Function
function z = example_sr(x)

x1 = x(1);
x2 = x(2);
x3 = x(3);
x4 = x(4);
x5 = x(5);
x6 = x(6);
x7 = x(7);

rm = 200;
m = 0;

% Other Equations
A1 = ((745*x4*(x2^(-1))*(x3^(-1)))^2 + 16.9110^6)^0.5;
B1 = 0.1*x6^3;
A1 = ((745*x5*(x2^(-1))*(x3^(-1)))^2 + 157.510^6)^0.5;
B1 = 0.1*x7^3;

%Constraints
g(1) = -x1*(x2^2)*x3 + 27;
if g(1) <= 0
    m(1) = 0;
else
    m(1) = abs(g(1));
end

g(2) = -x1*(x2^2)*(x3^2) + 397.5;
if g(2) <= 0
    m(2) = 0;
else
    m(2) = abs(g(2));
end

g(3) = -x2*(x6^4)*x3*(x4^(-3)) + 1.93;
if g(3) <= 0
    m(3) = 0;
else
    m(3) = abs(g(3));
end

g(4) = -x2*(x7^4)*x3*(x5^(-3)) + 1.93;
if g(4) <= 0
    m(4) = 0;
else
    m(4) = abs(g(4));
end

g(5) = A1*B1 - 1101;
if g(5) <= 0
    m(5) = 0;
else
    m(5) = abs(g(5));
end

g(6) = A1*B1^(-1) - 850;
if g(6) <= 0
    m(6) = 0;
else
    m(6) = abs(g(6));
end

g(7) = x2*x3 - 40;
if g(7) <= 0
    m(7) = 0;
else
    m(7) = abs(g(7));
end

g(8) = -x1*x2^(-1) + 5;
if g(8) <= 0
    m(8) = 0;
else
    m(8) = abs(g(8));
end

g(9) = x1*x2^(-1) - 12;
if g(9) <= 0
    m(9) = 0;
else
    m(9) = abs(g(9));
end

g(10) = 1.5*x6 - x4 + 1.9;
if g(10) <= 0
    m(10) = 0;
else
    m(10) = abs(g(10));
end

g(11) = 1.5*x7 - x5 + 1.9;
if g(11) <= 0
    m(11) = 0;
else
    m(11) = abs(g(11));
end

% Penalty
penalty = sum(m);

% Objective Function
f = 0.7854*x1*x2^2*(3.3333*x3^2 + 14.9334*x3 - 43.0934) ...
    - 1.508*x1*(x6^2 + x7^2) + (7.477*(x6^3 + x7^3)) + 0.7854*(x4*x6^2 + x5*x7^2);

z = f + rm*(penalty);

end
