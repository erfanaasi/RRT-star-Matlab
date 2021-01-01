%% Returns nearby neighbors in the graph for a given point, up to radius r.
% Input arguments:
%   - agentGraph: the current graph of the agent
%   - x_new: coordinates of the given point
%   - r: the search radius
% Output arguments
%   - x_near: coordinates of the near neighbors
%   - index_near: indices of the near neighbors

function [x_near, index_near] = graph_NearNeighbors(agentGraph, x_new, r)

index_near=[];
x_near=[];

for iNear=1:size(agentGraph,2)   % Loop over all the nodes
    if norm(agentGraph(iNear).configuration - x_new) <= r % Euclidean norm
       index_near = [index_near, iNear];                   
       x_near = [x_near agentGraph(iNear).configuration];
    end
end

end

