function Population = archive2REA(Population,N)
% Select feasible and non-dominated solutions by using NSGA-II

%------------------------------- Copyright --------------------------------
% Copyright (c) 2018-2019 BIMK Group. You are free to use the PlatEMO for
% research purposes. All publications which use this platform or any code
% in the platform should acknowledge the use of "PlatEMO" and reference "Ye
% Tian, Ran Cheng, Xingyi Zhang, and Yaochu Jin, PlatEMO: A MATLAB platform
% for evolutionary multi-objective optimization [educational forum], IEEE
% Computational Intelligence Magazine, 2017, 12(4): 73-87".
%--------------------------------------------------------------------------

% This function is written by Wenji Li

%% Select feasible solutions
fIndex           = all(Population.cons <= 0,2);
Population       = Population(fIndex);

if isempty(Population)
    return
else
    %% Non-dominated sorting
    [FrontNo,~] = NDSort(Population.objs,1);
    Next = (FrontNo == 1);    
    Population = Population(Next);    
    if sum(Next) > N
        %% 2REA Selection
            [Population,~,~] = EnvironmentalSelection2REA(Population,N,min(Population.objs,[],1));
        
    end
    
end
end

