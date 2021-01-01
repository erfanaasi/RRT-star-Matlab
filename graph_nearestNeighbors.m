%% Returns the k nearest neighbors in the graph for a given point.
% Input arguments:
%   - graphVector: the structure describing the graph of the roadmap
%   - x: coordinates of the given point
%   - k: number of nearest neighbors to find
% Output arguments
%   - idxNeighbors: indeces in graphVector of the neighbors of x

function [idxNeighbors] = graph_nearestNeighbors(graphVector, x, k)

NNodes = length(graphVector);

xAll = [graphVector.configuration];  % get locations of all nodes

distSquared = sum((xAll - x * ones(1, NNodes)).^2); % Euclidean distance

[~, idxSorted] = sort(distSquared); % sort and get first k neighbors

idxNeighbors = idxSorted(1:min(k, NNodes));
