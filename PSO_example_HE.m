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

%% Problem Definition
problem.Function = @(x) example_he(x);  % Cost Function
problem.nVar = 7;      % Number of Unknown Decision Variables
problem.VarMin = [100 100 100 -10 -10 0 0];   % Lower Bound of Decision Variables
problem.VarMax = [600 900 300 2500000 2500000 100 100];   % Upper Bound of Decision Variables

%% PSO Parameters

% Constriction Coefficients
kappa = 1;
phi1 = 2.05;
phi2 = 2.05;
phi = phi1 + phi2;
chi = 2*kappa/abs(2-phi-sqrt(phi^2-4*phi));

params.MaxIt = 10000;        % Maximum Number of Iterations
params.nPop = 60;           % Population (Swarm) Size
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

