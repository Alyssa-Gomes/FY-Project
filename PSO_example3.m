%% Example 3 Function

% Book: A Collection of Test Problems for Constrained Global Optimization Algorithms
% Authors: Christodoulos A. Floudas, Panos M. Pardalos (Year: 1990)
% Chapter 4: Nonlinear Programming test problems 
% Test Problem 5 (Section 4.3) - Book Pg no. 29)

% Best known solution: -11.96 at (x1,x2,x3,u1,u2,u3) = (0.67, 2, 4, 0, 0, 0)

clear;
close all;
clc;

%% Problem Definition
problem.Function = @(x) example3(x);  % Cost Function
problem.nVar = 6;      % Number of Unknown Decision Variables
problem.VarMin = [0 0 0 0 0 0];   % Lower Bound of Decision Variables
problem.VarMax = [3 5 4 5 2 5];   % Upper Bound of Decision Variables

%% PSO Parameters

% Constriction Coefficients
kappa = 1;
phi1 = 2.05;
phi2 = 2.05;
phi = phi1 + phi2;
chi = 2*kappa/abs(2-phi-sqrt(phi^2-4*phi));

params.MaxIt = 5000;        % Maximum Number of Iterations
params.nPop = 20;           % Population (Swarm) Size
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

%% Example 2 Function
function z = example3(x)

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

