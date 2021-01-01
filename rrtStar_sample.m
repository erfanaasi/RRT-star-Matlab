%% Generates a new sample, based on the given sampling type
% Input Arguments: 
%   - sampling: string parameter, which is either 'Uniform' or 'Gaussian'
%   - data: data structure including size of the environment and obstacles
%   - varargin: optional inputs, which may include: 'bias_point_flag',
%     which is a Boolean parameter for bias sampling with respect to a 
%     point; 'bias_point', which is the coordinates of the bias point;
%     'bias_radius', which is the search radius around bias point;
%     and 'goal_bias_flag', which is a Boolean parameter for bias sampling
%     toward the goal point
% Output Arguments:
%   - xSample: coordinates of the generated sample point

function [xSample] = rrtStar_sample(sampling, data, varargin)

% Optional inputs
bias_point_flag = false;
goal_bias_flag = false;
ivarargin = 1;

% Check for optional inputs
while(ivarargin <= length(varargin))
    
    switch(lower(varargin{ivarargin}))
        
        case 'bias_point'
            bias_point_flag = true;
            ivarargin = ivarargin + 1;
            bias_point = varargin{ivarargin};
            ivarargin = ivarargin + 1;
            bias_radius = varargin{ivarargin};
            
        case 'goal_bias'
            goal_bias_flag = true;
            ivarargin = ivarargin+1;
            bias_radius = varargin{ivarargin}; 
            
        otherwise
            error(['Argument ' varargin{ivarargin} ' not valid!'])
    end
    
    ivarargin = ivarargin + 1;
    
end

% Generate a sample point by Uniform distribution
if contains(sampling, "Uniform")
    
    if (~bias_point_flag) && (~goal_bias_flag)
        
        xSample = [rand(1) * data.world.x + data.world.origin(1); ...
                   rand(1) * data.world.y + data.world.origin(2)];
        
    else
        if bias_point_flag
            
            xSample = [bias_point(1) + rand(1) * bias_radius; ...
                       bias_point(2) + rand(1) * bias_radius];
        
        else
            
            xSample = [data.xGoal(1) + rand(1) * bias_radius; ...
                       data.xGoal(2) + rand(1) * bias_radius];
        
        end
        
    end
    
else
% Generate a sample point by Gaussian distribution
        if ~goal_bias_flag
            
            xSample = [normrnd(bias_point(1), bias_radius); ...
                       normrnd(bias_point(2), bias_radius)];
        
        else
            
            xSample = [normrnd(data.xGoal(1), bias_radius); ...
                       normrnd(data.xGoal(2), bias_radius)];
        
        end
  
end

end




