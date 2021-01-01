%% Generates the tree and the feasible path connecting start to goal points
% Input Arguments:
%   - data: data structure including size of the environment and obstacles
%   - steer: steer function for connecting nodes to new samples
%   - isCollisionSample: for checking collision of a point with obstacles
%   - isCollisionEdge: for checking collision of an edge with obstacles
%   - sampling: type of the sampling function
% Output Arguments:
%   - tree: structure of the generated graph in the environment, which has 
%           3 features: 'configuration', which has the coordinates of the 
%           nodes; 'backpointer', which saves the parent index of a node; 
%           'backpointerCost', which is the Euclidean distance from child
%           node to its parent
%   - feasiblePath: an array of coordinates, connecting the start to goal

function [tree, feasiblePath] = rrtStar(data, steer, isCollisionSample, ...
                                isCollisionEdge, sampling)

% Initialization of the tree
tree = struct('configuration', [], 'backpointer', [], 'backpointerCost',[]);
tree(1).configuration = data.xStart;
tree(1).backpointer = 1;
tree(1).backpointerCost = 0;

goal_flag=false; % flag for checking if goal is achieved
  
while ~goal_flag
    
    xSample = rrtStar_sample(sampling, data); % generating new sample
    
    tree = rrtStar_treeExtend(tree, xSample, data, steer, ...
           isCollisionSample, isCollisionEdge); % extending the tree
       
    tree = rrtStar_treeRewire(tree, data);  % rewiring the tree
        
    if norm(data.xGoal - tree(end).configuration) < data.goal_distance
        
        tree = rrtStar_treeExtend(tree, data.xGoal, data, steer, ...
               isCollisionSample, isCollisionEdge);
        
        tree = rrtStar_treeRewire(tree, data);
        
        goal_flag = true;
    
    end
    
end
    
feasiblePath = rrtStar_path(tree); % find a feasible path inside the tree

end


