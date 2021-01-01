%% Computes whether a point is in collision with obstacles
% Input Arguments:
%   - xSample: coordinates of the given point
%   - data: data structure including size of the environment and obstacles
% Output Arguments:
%   - collision_flag: Boolean parameter for collision

function [collision_flag] = isCollisionSample(xSample, data)
collision_flag = false;

for iObstacle = 1:size(data.obstacles, 2)  % Loop over all obstacles
    
    if norm(xSample-data.obstacles(iObstacle).xCenter) < ...
       data.obstacles(iObstacle).radius  % Euclidean distance
        
        collision_flag=true;
    
    end
    
end

end

