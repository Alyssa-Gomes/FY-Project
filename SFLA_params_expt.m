%% SFLA - Golinski Case Study - For Multiple runs and statistics
% Best known solution ranges between: 3019.583365 with error <10^-1 to 2876.219475 with error <10^0
% Paper referred to - optimal soln: 2994.471921 with error in const <10^-6

clear;
close all;
clc;

%% Problem Definition

% Objective Function
problem.CostFunction = @(x) golenski_case_study(x);

problem.nVar = 7;              % Number of Unknown Variables

problem.VarMin = [2.6 0.7 17 7.3 7.3 2.9 5];           % Lower Bound of Unknown Variables
problem.VarMax = [3.6 0.8 28 8.3 8.3 3.9 5.5];           % Upper Bound of Unknown Variables

%% SFLA Parameters
params.MaxIt = 1000;                                  % Maximum Number of Iterations

params.nPopMemeplex = 10;                           % Memeplex Size 10
%params.nPopMemeplex = max(nPopMemeplex, nVar+1);   % Nelder-Mead Standard
params.nMemeplex = 15;                               % Number of Memeplexes 5

% FLA Parameters
params.alpha = 3;                                   % Number of offspring                       
params.beta = 5;                                    % Max number of iterations                                   

%% Run for different values of w, c1, and c2
SFLA_params = [];

for w = 0:0.5:1
    for c1 = 0:0.5:2
        for c2 = 0:0.5:2
            
            %% PSO parameters
            params.w = w;                           % Weight factor - to avoid premature convergence
            params.c1 = c1;                         % Search acceleration factor for eqn 1
            params.c2 = c2;                         % Search acceleration factor for eqn 2
            
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
                %penalty(i) = BestSol.Penalty; %
                bestiter(i) = BestIter;
    
                % End timer
                RunTime(i) = toc;
            end

            %% Statistical Analysis
            format long
            MinCostVal = min(bestcost);
            MaxCostVal = max(bestcost);
            MeanCost = mean(bestcost);
            MedianCost = median(bestcost);
            StdDevCost = std(bestcost);
            AvgCI = mean(bestiter);      % Average convergence iteration
            AvgRunTime = mean(RunTime);
            %AvgPenalty = mean(penalty);
            
            %% Record statistics 
            stats = [w,c1,c2,MinCostVal,MaxCostVal,MeanCost,MedianCost,StdDevCost,AvgRunTime,AvgCI];
            SFLA_params = [SFLA_params;stats];
            
        end
    end
end
