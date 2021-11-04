%% Example (Heat Exchanger) Function

% Book: A Collection of Test Problems for Constrained Global Optimization Algorithms
% Authors: Christodoulos A. Floudas, Panos M. Pardalos (Year: 1990)
% Chapter 4: Nonlinear Programming test problems 
% Test Problem 8 (Section 4.8) - Book Pg no. 32)

% Global Minima: 189.3 at (T1, T2, T3) = (600, 700, 100)
% Local Minima: 286.93 at (T1, T2, T3) = (400, 900, 300)

clear;
close all;
clc;

% Start timer
%tic

%% Problem Definition

% Objective Function
problem.CostFunction = @(x) example_he(x);

problem.nVar = 7;      % Number of Unknown Decision Variables
problem.VarMin = [100 100 100 -10 -10 0 0];   % Lower Bound of Decision Variables
problem.VarMax = [600 900 300 2500000 2500000 100 100];   % Upper Bound of Decision Variables

%% SFLA Parameters
params.MaxIt = 5000;        % Maximum Number of Iterations

params.nPopMemeplex = 10;                          % Memeplex Size
%params.nPopMemeplex = max(nPopMemeplex, nVar+1);   % Nelder-Mead Standard

params.nMemeplex = 5;                  % Number of Memeplexes

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


%% Example (Heat Exchanger) Function
function z = example_he(x)

T1 = x(1);
T2 = x(2);
T3 = x(3);
Q1 = x(4);
Q2 = x(5);
A1 = x(6);
A2 = x(7);

rm = 200;
m = 0;

% Constants
TCi = 100;
TCo = 300;
THi1 = 600;
THi2 = 900;
F = 10000;
Cp = 1;
U = 200;

Y1 = log((T1 - TCi)/(THi1 - T3));
Y2 = log((T2 - T3)/(THi2 - TCo));

Tlm1 = ((T1 - TCi) - (THi1 - T3)) / Y1;
Tlm2 = ((T2 - T3) - (THi2 - TCo)) / Y2;

%Constraints
g(1) = F*Cp*(T3 - TCi) - Q1;
if g(1) ~= 0
    m(1) = abs(g(1));
end

g(2) = F*Cp*(TCo - T3) - Q2;
if g(2) ~= 0
    m(2) = abs(g(2));
end

g(3) = F*Cp*(THi1 - T1) - Q1;
if g(3) ~= 0
    m(3) = abs(g(3));
end

g(4) = F*Cp*(THi2 - T2) - Q2;
if g(4) ~= 0
    m(4) = abs(g(4));
end

g(5) = (Q1/(U*Tlm1)) - A1;
if g(5) ~= 0
    m(5) = abs(g(5));
end

g(6) = (Q2/(U*Tlm2)) - A2;
if g(6) ~= 0
    m(6) = abs(g(6));
end

% Penalty
penalty = sum(m);

% Objective Function
z = (35*A1^0.6 + 35*A2^0.6) + rm*(penalty);

end
