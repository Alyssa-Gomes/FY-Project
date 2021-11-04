%% PSO Algorithm

function out = pso_algorithm(problem, params)
    %% Problem Definiton
    Function = problem.Function;  % Cost Function (Objective Function)

    nVar = problem.nVar;        % Number of Unknown (Decision) Variables

    VarSize = [1 nVar];         % Matrix Size of Decision Variables

    VarMin = problem.VarMin;	% Lower Bound of Decision Variables
    VarMax = problem.VarMax;    % Upper Bound of Decision Variables

    %% PSO Parameters
    MaxIt = params.MaxIt;   % Maximum Number of Iterations
    nPop = params.nPop;     % Population (Swarm) Size
    w = params.w;           % Intertia Coefficient
    wdamp = params.wdamp;   % Damping Ratio of Inertia Coefficient
    c1 = params.c1;         % Personal Acceleration Coefficient
    c2 = params.c2;         % Social Acceleration Coefficient

    % Iteration Flag
    ShowIterInfo = params.ShowIterInfo;    
    MaxVelocity = 0.2*(VarMax-VarMin);
    MinVelocity = -MaxVelocity;
    
    %% Initialization

    % Particle Template
    empty_particle.Position = [];
    empty_particle.Velocity = [];
    empty_particle.Cost = [];
    empty_particle.Best.Position = [];
    empty_particle.Best.Cost = [];

    % Population Array
    particle = repmat(empty_particle, nPop, 1);

    % Initialization of Global Best
    GlobalBest.Cost = inf;
    
    % Initialization of best values array (for convergence)
    %coeffs = [MaxIt 1000 0 0 0];
    %all_coeffs = [];

    % Initialization of Population Members
    for i=1:nPop

        % Generation of Random Solution
        particle(i).Position = unifrnd(VarMin, VarMax, VarSize);

        % Initialization of Velocity
        particle(i).Velocity = zeros(VarSize);

        % Evaluation
        particle(i).Cost = Function(particle(i).Position);

        % Update Personal Best
        particle(i).Best.Position = particle(i).Position;
        particle(i).Best.Cost = particle(i).Cost;

        % Update Global Best
        if particle(i).Best.Cost < GlobalBest.Cost
            GlobalBest = particle(i).Best;
            BestIter = 1; % Iteration number corresponding to global best cost
            %coeffs = [1 GlobalBest.Cost w c1 c2];
        end

    end

    % Best Cost Value for each Iteration (Array)
    %BestCosts = zeros(MaxIt, 1);
    BestCosts = NaN(MaxIt+1, 1); % MaxIt+1 since initial pop is also considered as iteration 0
    BestCosts(1) = GlobalBest.Cost;
    disp(['Iteration ' num2str(0) ': Best Cost = ' num2str(BestCosts(1))]);

    %% Main Loop of PSO
    for it=1:MaxIt

        for i=1:nPop

            % Update Velocity
            particle(i).Velocity = w*particle(i).Velocity ...
                + c1*rand(VarSize).*(particle(i).Best.Position - particle(i).Position) ...
                + c2*rand(VarSize).*(GlobalBest.Position - particle(i).Position);

            % Apply Velocity Limits
            particle(i).Velocity = max(particle(i).Velocity, MinVelocity);
            particle(i).Velocity = min(particle(i).Velocity, MaxVelocity);
            
            % Update Position
            particle(i).Position = particle(i).Position + particle(i).Velocity;

            % Apply Lower and Upper Bound Limits
            particle(i).Position = max(particle(i).Position, VarMin);
            particle(i).Position = min(particle(i).Position, VarMax);

            % Evaluation
            particle(i).Cost = Function(particle(i).Position);

            % Update Personal Best
            if particle(i).Cost < particle(i).Best.Cost

                particle(i).Best.Position = particle(i).Position;
                particle(i).Best.Cost = particle(i).Cost;

                % Update Global Best
                if particle(i).Best.Cost < GlobalBest.Cost
                    GlobalBest = particle(i).Best;
                    BestIter = it;
                    
                    % Update best values array (for convergence)
                    %coeffs = [it GlobalBest.Cost w c1 c2];
                    %all_coeffs = [all_coeffs; coeffs];
                end            

            end

        end

        % Store Best Cost Value
        BestCosts(it+1) = GlobalBest.Cost;

        % Display Iteration Information
        if ShowIterInfo
            disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(BestCosts(it+1))]);
        end

        % Damping Inertia Coefficient
        %w = w * wdamp;

    end
    
    %% Return Final Results
    out.BestSol = GlobalBest;
    out.BestCosts = BestCosts;
    out.BestIter = BestIter;
    %out.coeffs = coeffs;
    %out.all_coeffs = all_coeffs;
    
end