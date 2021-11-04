%% SFLA Algorithm

function out = sfla_algorithm(problem, params)

%% Problem Definiton
CostFunction = problem.CostFunction;

nVar = problem.nVar;              % Number of Unknown Variables
VarSize = [1 nVar];     % Unknown Variables Matrix Size

VarMin = problem.VarMin;           % Lower Bound of Unknown Variables
VarMax = problem.VarMax;           % Upper Bound of Unknown Variables 

%% SFLA Parameters
MaxIt = params.MaxIt;                  % Maximum Number of Iterations

nPopMemeplex = params.nPopMemeplex;    % Memeplex Size
%nPopMemeplex = params.nPopMemeplex;   % Nelder-Mead Standard

nMemeplex = params.nMemeplex;   % Number of Memeplexes
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
% Best iteration number (initially)
BestIter = 1; % Iteration number corresponding to global best cost

% Best Cost Value for each Iteration (Array)
%BestCosts = nan(MaxIt, 1);
BestCosts = NaN(MaxIt+1, 1); % MaxIt+1 since initial pop is also considered
BestCosts(1) = BestSol.Cost;
disp(['Iteration ' num2str(1) ': Best Cost = ' num2str(BestCosts(1))]);


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
    BestIter = it+1;
    
    % Store Best Cost Ever Found
    BestCosts(it+1) = BestSol.Cost;
    
    %% Update Global Best
    
    % Show Iteration Information
    disp(['Iteration ' num2str(it+1) ': Best Cost = ' num2str(BestCosts(it+1))]);
    
    %% Return Final Results
    out.BestSol = BestSol;
    out.BestCosts = BestCosts;
    out.BestIter = BestIter;
    
end
