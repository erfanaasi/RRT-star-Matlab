%% Computes whether an edge connecting xNeighbor to xSteer is safe
% Input Arguments:
%   - xNeighbor: coordinates of the nearby neighbor to xSteer
%   - xSteer: coordinates of the next target point of the agent
%   - data: data structure including size of the environment and obstacles
% Output Arguments:
%   - collision_flag: Boolean parameter for collision

function [collision_flag] = isCollisionEdge(xNeighbor, xSteer, data)

collision_flag = false;
division_number = 20;  % Number of points along the edge for safety check
division_collision_flag = false(1, division_number); 

for iPoint=1:division_number
    
    division_point = (iPoint / division_number) * (xSteer - xNeighbor) + ...
                     xNeighbor; % coordinates of points along the edge
    division_collision_flag(iPoint)=isCollisionSample(division_point,data);

end

if any(division_collision_flag)
    
    collision_flag = true;

end

end

