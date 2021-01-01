%% Computes the free space of environment, with respect to the obstacles.
% Input Arguments:
%   - data: data structure including the environment size and obstacles
% Output Arguments:
%   - free_area: area of the free space

function [free_area] = freeSpace(data)

free_area = data.world.x * data.world.y;

for iObstacle = 1:size(data.obstacles, 2)
    free_area = free_area - pi * (data.obstacles(iObstacle).radius)^2;
end

