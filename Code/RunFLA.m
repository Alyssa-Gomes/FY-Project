%% SFLA 

function pop = RunFLA(pop, params)

    %% FLA Parameters
    q = params.q;           % Number of Parents
    alpha = params.alpha;   % Number of Offsprings
    beta = params.beta;     % Maximum Number of Iterations
    w = params.w;
    c1 = params.c1;
    c2 = params.c2;
    CostFunction = params.CostFunction;
    VarMin = params.VarMin;
    VarMax = params.VarMax;
    VarSize = size(pop(1).Position);
    BestSol = params.BestSol;
    
    nPop = numel(pop);                          % Population Size
    P = 2*(nPop+1-(1:nPop))/(nPop*(nPop+1));    % Selection Probabilities
    
    % Calculate Population Range (Smallest Hypercube)
    LowerBound = pop(1).Position;
    UpperBound = pop(1).Position;
    for i = 2:nPop
        LowerBound = min(LowerBound, pop(i).Position);
        UpperBound = max(UpperBound, pop(i).Position);
    end
    
    %% FLA Main Loop

    for it = 1:beta
        
        % Select Parents
        L = RandSample(P, q);
        B = pop(L);
        
        % Generate Offsprings
        for k = 1:alpha
            
            % Sort Population
            [B, SortOrder] = SortPopulation(B);
            L = L(SortOrder);
            
            % Flags
            ImprovementStep2 = false;
            Censorship = false;
            
            % Improvement Step 1
            NewSol1 = B(end);
            Step = c1*rand(VarSize).*(B(1).Position-B(end).Position);
            NewSol1.Position = w*B(end).Position + Step;
            if IsInRange(NewSol1.Position, VarMin, VarMax)
                NewSol1.Cost = CostFunction(NewSol1.Position);
                %z = CostFunction(NewSol1.Position); %
                %NewSol1.Cost = z.Cost; %
                %NewSol1.Penalty = z.Penalty; %
                if NewSol1.Cost<B(end).Cost
                    B(end) = NewSol1;
                else
                    ImprovementStep2 = true;
                end
            else
                ImprovementStep2 = true;
            end
            
            % Improvement Step 2
            if ImprovementStep2
                NewSol2 = B(end);
                Step = c2*rand(VarSize).*(BestSol.Position-B(end).Position);
                NewSol2.Position = w*B(end).Position + Step;
                if IsInRange(NewSol2.Position, VarMin, VarMax)
                    NewSol2.Cost = CostFunction(NewSol2.Position);
                    %z = CostFunction(NewSol2.Position); %
                    %NewSol2.Cost = z.Cost; %
                    %NewSol2.Penalty = z.Penalty; %
                    if NewSol2.Cost<B(end).Cost
                        B(end) = NewSol2;
                    else
                        Censorship = true;
                    end
                else
                    Censorship = true;
                end
            end
                
            % Censorship
            if Censorship
                B(end).Position = unifrnd(LowerBound, UpperBound);
                B(end).Cost = CostFunction(B(end).Position);
            end
            
        end
        
        % Return Back Subcomplex to Main Complex
        pop(L) = B;
        
    end
    
end