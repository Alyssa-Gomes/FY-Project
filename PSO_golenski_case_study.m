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
tic

%% Problem Definition
problem.Function = @(x) golenski_case_study(x);  % Cost Function
problem.nVar = 7;      % Number of Unknown Decision Variables
problem.VarMin = [2.6 0.7 17 7.3 7.3 2.9 5];   % Lower Bound of Decision Variables
problem.VarMax = [3.6 0.8 28 8.3 8.3 3.9 5.5];   % Upper Bound of Decision Variables

%% PSO Parameters

% Constriction Coefficients
kappa = 1;
phi1 = 2.05;
phi2 = 2.05;
phi = phi1 + phi2;
chi = 2*kappa/abs(2-phi-sqrt(phi^2-4*phi));

params.MaxIt = 500;        % Maximum Number of Iterations
params.nPop = 50;           % Population (Swarm) Size
params.w = chi;             % Intertia Coefficient
%params.w = 0.65;
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

% Stop timer
toc
