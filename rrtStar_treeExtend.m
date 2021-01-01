%% Extends the current constructed tree with the new generated sample point
% Input Arguments:
%   - currentTree: current tree structure, before the extension
%   - xSample: coordinates of the new generated sample point
%   - data: data structure including size of the environment and obstacles
%   - steer: steer function for connecting nodes to new samples
%   - isCollisionSample: for checking collision of a point with obstacles
%   - isCollisionEdge: for checking collision of an edge with obstacles
% Output Arguments:
%   - updatedTree: the new tree, extend with the new sample

function [updatedTree] = rrtStar_treeExtend(currentTree, xSample, data, ...
                         steer, isCollisionSample, isCollisionEdge)

updatedTree = currentTree;

% Computing the radius of search for extension around sample point
miu_Xfree = freeSpace(data);
gamma_rrt = 2 * ((1 + 1 / data.dimension) * (miu_Xfree / data.zeta_d)) ^ ...
            (1 / data.dimension);
        
card_V = size(currentTree, 2);
r = min(gamma_rrt * (log(card_V) / card_V) ^ (1 / data.dimension), data.eta);

% Standard RRT* algorithm
if ~isCollisionSample(xSample, data)
    
    index_nearest = graph_nearestNeighbors(currentTree, xSample, 1);
    x_nearest = currentTree(index_nearest).configuration;
    xSteer = steer(x_nearest, xSample, data.eps);
        
    if ~isCollisionEdge(x_nearest, xSteer, data)
        [x_near, index_near] = graph_NearNeighbors(currentTree, xSteer, r);
        updatedTree(end + 1).configuration = xSteer;
        index_min = index_nearest;
        c_min = updatedTree(index_nearest).backpointerCost + ...
                norm(x_nearest - xSteer);
            
        for iNear = 1:size(index_near)
            
            collision_flag = ~isCollisionEdge(x_near(iNear), xSteer, data);
            cost_flag = updatedTree(index_near(iNear)).backpointerCost + ...
                        norm(x_near(iNear) - xSteer) < c_min;
                    
            if (collision_flag) && (cost_flag)
                
                index_min = index_near(iNear);
                x_min = x_near(iNear);
                c_min = updatedTree(index_min).backpointerCost + ...
                        norm(x_min - xSteer);
            
            end
            
        end
            
        updatedTree(end).backpointer = index_min;
        updatedTree(end).backpointerCost = c_min;
            
     end
        
end

end


