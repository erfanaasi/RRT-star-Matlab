%% Draws spheres
% Input Arguments:
%   - sphere: object including the sphere information
%   - color: color of the outer ring of the sphere


function varargout = sphere_plot(sphere, color)

radius = sphere.radius;

faceColor = (rand(1,3));  % color of the inside of the sphere

plotHandle1 = plotCircle(sphere.xCenter(1), sphere.xCenter(2), radius, ...
                         'EdgeColor', color, 'FaceColor', faceColor);
                     
plotHandle2 = plotCircle(sphere.xCenter(1), sphere.xCenter(2), radius, ...
                         'EdgeColor', color, 'FaceColor', faceColor);

if nargout > 0
    
    varargout{1} = [plotHandle1; plotHandle2];

end


function plotHandle = plotCircle(xCenter, yCenter, radius, varargin)
diameter = radius * 2;
xCorner = xCenter-radius;
yCorner = yCenter-radius;

plotHandle = rectangle('Position', [xCorner yCorner diameter diameter], ...
                       'Curvature', [1,1], varargin{:});
                   
text(xCenter-0.4, yCenter, 'Obstacle','Color','k','FontSize', 7)