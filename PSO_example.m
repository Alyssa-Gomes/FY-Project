%% Example Function

% From NPTEL video: https://www.youtube.com/watch?v=ftOzxva86rA&list=PLwdnzlV3ogoUuROTSTBM2mUgtiKIrRn_5&index=24
% Lec 22 : Constraint-Handling in Metaheuristic Techniques
% Prof. Prakash Kotecha

% Best known solution (By graphical method): 1

clear;
close all;
clc;

%% Problem Definition
problem.Function = @(x) example(x);  % Cost Function
problem.nVar = 2;      % Number of Unknown Decision Variables
problem.VarMin = [0.1 0];   % Lower Bound of Decision Variables
problem.VarMax = [1 5];   % Upper Bound of Decision Variables

%% PSO Parameters

% Constriction Coefficients
kappa = 1;
phi1 = 2.05;
phi2 = 2.05;
phi = phi1 + phi2;
chi = 2*kappa/abs(2-phi-sqrt(phi^2-4*phi));

params.MaxIt = 100;        % Maximum Number of Iterations
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

%% Example Function
function z = example(x)

x1 = x(1);
x2 = x(2);
rm = 20;
m = 0;

%Constraints
g(1) = ((9*x1 + x2)/6) - 1;
if g(1) < 0
    m(1) = abs(g(1));
end

g(2) = 9*x1 - x2 - 1;
if g(2) < 0
    m(2) = abs(g(2));
end

penalty = sum(m);

z = (1 + x2)/x1 + rm*(penalty);

end

