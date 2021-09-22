% PSO - Matyas Benchmark Function

clear;
close all;
clc;

%% Problem Definition
problem.Function = @(x) matyas(x);  % Cost Function
problem.nVar = 2;      % Number of Unknown Decision Variables
problem.VarMin = -10;   % Lower Bound of Decision Variables
problem.VarMax =  10;   % Upper Bound of Decision Variables

%% PSO Parameters

% Constriction Coefficients
kappa = 1;
phi1 = 2.05;
phi2 = 2.05;
phi = phi1 + phi2;
chi = 2*kappa/abs(2-phi-sqrt(phi^2-4*phi));

params.MaxIt = 4000;        % Maximum Number of Iterations
params.nPop = 50;           % Population (Swarm) Size
params.w = chi;             % Intertia Coefficient
params.w = 0.65;
params.wdamp = 1;           % Inertia Coefficient Damping Ratio
params.c1 = chi*phi1;       % Personal Acceleration Coefficient
%params.c1 = 1.65;
params.c2 = chi*phi2;       % Social Acceleration Coefficient
%params.c2 = 1.75;
params.ShowIterInfo = true; % Iteration Flag

%% Calling PSO
out = pso_algorithm(problem, params);
BestSol = out.BestSol;
BestCosts = out.BestCosts;

%% Results
figure;
% plot(BestCosts, 'LineWidth', 2);
semilogy(BestCosts, 'LineWidth', 2);
xlabel('Iteration');
ylabel('Best Cost');
grid on;

