%% Rewiring the extended tree
% Input Arguments:
%   - currentTree: current tree structure, after the extension
%   - data: data structure including size of the environment and obstacles
% Output Arguments:
%   - optimizedTree: the new tree structure, after the rewiring

function [optimizedTree] = rrtStar_treeRewire(currentTree, data)

% Computing the radius of search for rewiring
miu_Xfree = freeSpace(data);
gamma_rrt = 2 * ((1 + 1 / data.dimension) * (miu_Xfree / data.zeta_d)) ^ ...
            (1 / data.dimension);
        
card_V = size(currentTree, 2) - 1;
r = min(gamma_rrt * (log(card_V) / card_V) ^ (1 / data.dimension),data.eta);

% Standard RRT* rewiring algorithm
[x_near, index_near] = graph_NearNeighbors(currentTree(1:end-1), ...
                      currentTree(end).configuration, r);

for iNear=1:size(index_near)
    
    collision_flag = ~isCollisionEdge(currentTree(end).configuration, ...
                                      x_near(iNear), data);
                                  
    distance_to_near = currentTree(end).backpointerCost + ...
                       norm(currentTree(end).configuration - x_near(iNear));
                   
    cost_flag = distance_to_near < ...
                currentTree(index_near(iNear)).backpointerCost;
    
    if (collision_flag) && (cost_flag)
        
        currentTree(index_near(iNear)).backpointer = size(currentTree, 2);
        currentTree(index_near(iNear)).backpointerCost = distance_to_near;
    
    end
    
end

optimizedTree = currentTree;

end

