function Off = AdapativeOffspring(Population,TPop,wa,Problem,B)
    Off     = [];    
    for i = 1 : Problem.N
        % Choose the parents
            if rand<0.9
            	P = B(i,randperm(size(B,2)));
            else
                P = randperm(Problem.N);
            end
            ran  =  rand;
                 if round(Problem.FE/Problem.maxFE)==1 || wa==1  
                   
                   if ran<0.5
                      Offspring   = OperatorGAhalf(Problem,Population(P(1:2)));
                   else
                      Offspring   = OperatorDE(Problem,Population(i),Population(P(1)),Population(P(2)),{1,0.5,1,20});
                   end
                   Off            = [Off,Offspring];   
                 else               
                     if i == 1 || i == Problem.N 
                         Offspring    = OperatorDE(Problem,TPop(i),TPop(P(1)),TPop(P(2)),{1,0.8,1,20});
                         Off          = [Off,Offspring];
                     else
                         if ran<0.5
                            Offspring =  OperatorGAhalf(Problem,TPop(P(1:2)));
                         else   
                          Offspring   = OperatorDE(Problem,TPop(i),TPop(P(1)),TPop(P(2)),{1,0.5,1,20});
                         end 
                         Off          = [Off,Offspring];
                     end   
                 end
    end  
end