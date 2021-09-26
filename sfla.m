%% SFLA Algorithm

clear;
close all;
clc;

%% Problem Definition

% Objective Function
CostFunction = @(x) michalewicz(x);

nVar = 10;              % Number of Unknown Variables
VarSize = [1 nVar];     % Unknown Variables Matrix Size

VarMin = 0;           % Lower Bound of Unknown Variables
VarMax = pi;           % Upper Bound of Unknown Variables


%% SFLA Parameters

MaxIt = 5000;        % Maximum Number of Iterations

nPopMemeplex = 10;                          % Memeplex Size
%nPopMemeplex = max(nPopMemeplex, nVar+1);   % Nelder-Mead Standard

nMemeplex = 5;                  % Number of Memeplexes
nPop = nMemeplex*nPopMemeplex;	% Population Size

I = reshape(1:nPop, nMemeplex, []);

% FLA Parameters
fla_params.q = max(round(0.3*nPopMemeplex), 2);   % Number of Parents
fla_params.alpha = 3;   % Number of offspring
fla_params.beta = 5;    % Maximum Number of Iterations
fla_params.sigma = 2;   % Step Size
fla_params.CostFunction = CostFunction;
fla_params.VarMin = VarMin;
fla_params.VarMax = VarMax;

%% Initialization

% Empty Individual Template
empty_individual.Position = [];
empty_individual.Cost = [];

% Initialize Population Array
pop = repmat(empty_individual, nPop, 1);

% Initialize Population Members
for i = 1:nPop
    pop(i).Position = unifrnd(VarMin, VarMax, VarSize);
    pop(i).Cost = CostFunction(pop(i).Position);
end

% Sort Population
pop = SortPopulation(pop);

% Update Best Solution Ever Found
BestSol = pop(1);

% Initialize Best Costs Record Array
BestCosts = nan(MaxIt, 1);

%% SFLA Main Loop

for it = 1:MaxIt
    
    fla_params.BestSol = BestSol;

    % Initialize Memeplexes Array
    Memeplex = cell(nMemeplex, 1);
    
    % Form Memeplexes and Run FLA
    for j = 1:nMemeplex
        % Memeplex Formation
        Memeplex{j} = pop(I(j, :));
      
        % Run FLA
        Memeplex{j} = RunFLA(Memeplex{j}, fla_params);
        
        % Insert Updated Memeplex into Population
        pop(I(j, :)) = Memeplex{j};
    end
    
    % Sort Population
    pop = SortPopulation(pop);
    
    % Update Best Solution Ever Found
    BestSol = pop(1);
    
    % Store Best Cost Ever Found
    BestCosts(it) = BestSol.Cost;
    
    % Show Iteration Information
    disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(BestCosts(it))]);
    
end

%% Results

figure;
%plot(BestCosts, 'LineWidth', 2);
semilogy(BestCosts, 'LineWidth', 2);
xlabel('Iteration');
ylabel('Best Cost');
grid on;
