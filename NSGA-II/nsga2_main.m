% Copyright [2017] [Proteek Chandan Roy]
% 
% Licensed under the Apache License, Version 2.0 (the "License");
% you may not use this file except in compliance with the License.
% You may obtain a copy of the License at
% 
%     http://www.apache.org/licenses/LICENSE-2.0
% 
% Unless required by applicable law or agreed to in writing, software
% distributed under the License is distributed on an "AS IS" BASIS,
% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
% See the License for the specific language governing permissions and
% limitations under the License.


%This is main function that runs NSGA-II procedure
function opt = nsga2_main(opt)

    %------------INITIALIZE------------------------------------------------
    opt.pop = lhsamp_model(opt.N, opt);%LHS Sampling
    
    %------------EVALUATE--------------------------------------------------
    [opt.popObj, opt.popCons] = evaluate_pop(opt, opt.pop);
    opt.popCV = evaluateCV(opt.popCons);
    opt.archiveObj = opt.popObj;%to save all objectives
    
    %-------------------PLOT INITIAL SOLUTIONS-----------------------------
    plot_population(opt, opt.popObj);
    
    
    %--------------- OPTIMIZATION -----------------------------------------
    funcEval = opt.N;
    
    while funcEval < opt.totalFuncEval % Generation # 1 to 

        opt = mating_selection(opt);%--------Mating Parent Selection-------
        opt = crossover(opt);%-------------------Crossover-----------------
        opt = mutation(opt);%--------------------Mutation------------------
        
        
        %---------------EVALUATION-----------------------------------------
        [opt.popChildObj, opt.popChildCons] = evaluate_pop(opt, opt.popChild);
        opt.popCV = evaluateCV(opt.popCons);
        opt.popChildCV = evaluateCV(opt.popChildCons);
        
        
        
        %---------------MERGE PARENT AND CHILDREN--------------------------
        opt.totalpopObj = vertcat(opt.popChildObj, opt.popObj);
        opt.totalpop = vertcat(opt.popChild, opt.pop);
        opt.totalpopCV = vertcat(opt.popChildCV, opt.popCV);
        opt.totalpopCons = vertcat(opt.popChildCons, opt.popCons);
        
        %-----------------SURVIVAL SELECTION-------------------------------
        opt = survival_selection(opt);
        funcEval = funcEval + opt.N;
        
        opt.popCV = evaluateCV(opt.popCons);
        opt.archiveObj = vertcat(opt.archiveObj,opt.popObj);
        
        
        %-------------------PLOT NEW SOLUTIONS----------------------------- 
        
        if mod(funcEval,1000)==0
            disp(funcEval);
            plot_population(opt, opt.popObj);
        end
        
    end
    
    
    %------------------RETURN VALUE----------------------------------------
    [opt.pop, opt.popObj] = calculate_feasible_paretofront(opt, opt.pop, opt.popObj, opt.popCV);
    
    

end%end of function
%------------------------------END OF -FILE--------------------------------

