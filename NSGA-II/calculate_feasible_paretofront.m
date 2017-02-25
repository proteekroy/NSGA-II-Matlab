
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

function [pareto_pop, pareto_obj] = calculate_feasible_paretofront(opt, pop, pop_obj, pop_cv)

    %-------------FIND FEASIBLE PARETO FRONT-------------------------------
    
    if opt.C>0 %Feasible Pareto front of Constraint Problems
        
        index = find(pop_cv<=0);
        pareto_pop = pop(index,:);
        pareto_obj = pop_obj(index,:);
        
    else
        pareto_pop = pop; 
        pareto_obj = pop_obj;
        
    end
    
    if size(pareto_pop,1)>0

        [R,~] = bos(pareto_obj);
        index = find(R==1);%non-dominated front, first front
        pareto_pop =  pop(index,:);
        pareto_obj =  pop_obj(index,:);
        
    end
                    
end