%% Steers the near node 'xNeighbor' in graph to the new sample 'xSample'
% Input Arguments:
%   - xSample: coordinates of the new generated sample
%   - xNeighbor: coordinates of the nearby node in graph to the new sample
% Output Arguments:
%   - xSteer: coordinates of the steered point 

function [xSteer] = steer(xNeighbor, xSample, eps)
    % if the new sample is further than a specific value 'eps'
    if norm(xSample - xNeighbor) > eps 
        % steer to some point in the middle of 'xNeighbor' and 'xSample'
        xSteer = xNeighbor + (eps * (xSample - xNeighbor)) / ...
                              norm(xSample - xNeighbor); 
    
    else
        
        xSteer = xSample;

    end
    
end

