% Latest edition

%% Check different combinations of w, c1 and c2
clear;
close all;
clc;

%%Best Values
coeff_k = [1000 1000 0 0 0];
coeff_j = [1000 1000 0 0 0];
coeff_i = [1000 1000 0 0 0];

All_Coeffs_k = [];
All_Coeffs_j = [];
All_Coeffs_i = [];

% Value of w
for i = 0:0.1:1
    wm = i;
    
    % Value of c1
    for j = 0:0.1:2
        c1m = j;
        
        % Value of c2
        for k = 0:0.1:2
            c2m = k;
            
            %% Problem Definition
            problem.Function = @(x) sphere(x);  % Cost Function
            problem.nVar = 2;      % Number of Unknown Decision Variables
            problem.VarMin = -10;   % Lower Bound of Decision Variables
            problem.VarMax =  10;   % Upper Bound of Decision Variables

            %% PSO Parameters
            params.MaxIt = 200;       % Maximum Number of Iterations
            params.nPop = 10;           % Population (Swarm) Size
            params.w = wm;            % Inertia Coeff
            params.wdamp = 1;           % Inertia Coefficient Damping Ratio
            params.c1 = c1m;           % Personal Acceleration Coefficient
            params.c2 = c2m;           % Social Acceleration Coefficient
            params.ShowIterInfo = true; % Iteration Flag

            %% Calling PSO
            out = pso_algorithm(problem, params);
            BestSol = out.BestSol;
            BestCosts = out.BestCosts;
            BestCoeffs = out.coeffs;
            %AllCoeffs = out.all_coeffs;
            
            %All_Coeffs_k = [All_Coeffs_k; AllCoeffs];
            
            if BestCoeffs(1) < coeff_k(1) && BestCoeffs(2) < coeff_k(2)
                coeff_k(1) = BestCoeffs(1);
                coeff_k(2) = BestCoeffs(2);
                coeff_k(3) = BestCoeffs(3);
                coeff_k(4) = BestCoeffs(4);
                coeff_k(5) = BestCoeffs(5);
            end
            
            % Display New Best Values
            %disp(['Iterations = ' num2str(coeff_k(1)) ', Best Cost = ' num2str(coeff_k(2)) ...
            %    ', Best w = ' num2str(coeff_k(3)) ', Best c1 = ' num2str(coeff_k(4)) ...
            %    ', Best c2 = ' num2str(coeff_k(5))]);
            
        end
        
        if coeff_k(1) < coeff_j(1) && coeff_k(2) < coeff_j(2)
            coeff_j(1) = coeff_k(1);
            coeff_j(2) = coeff_k(2);
            coeff_j(3) = coeff_k(3);
            coeff_j(4) = coeff_k(4);
        end
        
        %All_Coeffs_j = [All_Coeffs_j; All_Coeffs_k];
        
        % Display New Best Values
        %disp(['Iterations = ' num2str(coeff_j(1)) ', Best Cost = ' num2str(coeff_j(2)) ...
        %    ', Best w = ' num2str(coeff_j(3)) ', Best c1 = ' num2str(coeff_j(4)) ...
        %    ', Best c2 = ' num2str(coeff_j(5))]);
        
    end
    
    if coeff_j(1) < coeff_i(1) && coeff_j(2) < coeff_i(2)
        coeff_i(1) = coeff_j(1);
        coeff_i(2) = coeff_j(2);
        coeff_i(3) = coeff_j(3);
        coeff_i(4) = coeff_j(4);
    end
    
    %All_Coeffs_i = [All_Coeffs_i; All_Coeffs_j];
    
    % Display New Best Values
    %disp(['Iterations = ' num2str(coeff_i(1)) ', Best Cost = ' num2str(coeff_i(2)) ...
    %    ', Best w = ' num2str(coeff_i(3)) ', Best c1 = ' num2str(coeff_i(4)) ...
    %    ', Best c2 = ' num2str(coeff_i(5))]);
    
end

%All_Coeffs_i

% Write file to excel
writematrix(coeff_i, "Coeff_Results.csv")

%% Final Results - Best Values
%disp(['Overall best values: Iterations = ' num2str(coeff_i(1)) ', Best Cost = ' num2str(coeff_i(2)) ...
%    ', Best w = ' num2str(coeff_i(3)) ', Best c1 = ' num2str(coeff_i(4)) ', Best c2 = ' num2str(coeff_i(5))]);
