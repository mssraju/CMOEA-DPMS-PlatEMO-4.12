classdef CMOEA_DPMS < ALGORITHM
% <algorithm> <A>
% A Dual Population based Multi-staged CMOEA

%------------------------------- Reference --------------------------------
%Sri Srinivasa Raju M
%------------------------------- Copyright --------------------------------
% Copyright (c) 2018-2019 BIMK Group. You are free to use the PlatEMO for
% research purposes. All publications which use this platform or any code
% in the platform should acknowledge the use of "PlatEMO" and reference "Ye
% Tian, Ran Cheng, Xingyi Zhang, and Yaochu Jin, PlatEMO: A MATLAB platform
% for evolutionary multi-objective optimization [educational forum], IEEE
% Computational Intelligence Magazine, 2017, 12(4): 73-87".
%--------------------------------------------------------------------------
%% Generate the reference points and random population
    methods
       function main(Algorithm,Problem)
           [W,Problem,B,Population,Z,TPop,wa,wb,arch,Z1,znadh,znadm] = Initial(Problem);
           Gen=1;
           maxGen = Problem.maxFE/Problem.N;
   
            %% Optimization
            while Algorithm.NotTerminated(Population)
                Off                     = AdapativeOffspring(Population,TPop,wa,Problem,B);
                [TPop,Z]                = EnvironmentalSelection([TPop,Off],W,Problem.N,Z);
                [Population,Z1]         = Association([TPop,Population,Off],W,Z1,wb,Problem);       
                arch                    = archive2REA([arch,Population,TPop],Problem.N);
                [wa,wb,znadh,znadm,TPop]= Strategy(Problem,TPop,arch,znadh,znadm,wa,wb,Gen); 
                if Problem.FE >= Problem.maxFE
                    Population = arch;
                end
                
                Gen=Gen+1;
            end
       end
    end  
    
end