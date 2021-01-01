%% Find a feasible path inside the tree, from start point to goal
% Input Arguments:
%   - tree: generated graph in the environment (see 'rrtStar.m')
% Output Arguments: 
%   - feasiblePath: an array of coordinates, connecting the start to goal

function [feasible_path] = rrtStar_path(tree)
    
pointer = tree(end).backpointer; % starting from end of tree
feasible_path = [];

while pointer~=1
    
    feasible_path = [feasible_path tree(pointer).configuration];
    pointer = tree(pointer).backpointer; % going backward in the tree

end

feasible_path = [feasible_path tree(1).configuration];
feasible_path = [tree(end).configuration feasible_path];
feasible_path = fliplr(feasible_path); % sorting path, from start to goal
    
end

