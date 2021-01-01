%% Sample code for testing the algorithm
% Sampling type, which is the last input to the 'rrtStar' function, can be
% either 'Uniform' or 'Gaussian'.

function rrtStar_test()

close all
clear 
load('data');

% Generating the tree and finding the feasible path
[tree, feasiblePath] = rrtStar(data, @steer, @isCollisionSample, ...
                            @isCollisionEdge, 'Uniform');

figure(1)

% Plotting the obstacles
for iObstacle = 1:size(data.obstacles, 2)
    
    sphere_plot(data.obstacles(iObstacle), 'b');
    hold on

end

% Plotting the tree
for iNode = 2:size(tree, 2)
    node1_x = tree(iNode).configuration(1);
    node2_x = tree(tree(iNode).backpointer).configuration(1);
    node1_y = tree(iNode).configuration(2);
    node2_y = tree(tree(iNode).backpointer).configuration(2);
    plot([node1_x node2_x], [node1_y node2_y], 'g');
    hold on

end


% Plotting the feasibe path inside the tree
for iPath = 1:size(feasiblePath, 2) - 1
    
    p1_x = feasiblePath(1,iPath);
    p2_x = feasiblePath(1,iPath+1);
    p1_y = feasiblePath(2,iPath);
    p2_y = feasiblePath(2,iPath+1);
    plot([p1_x p2_x],[p1_y p2_y], 'r', 'LineWidth', 3);
    hold on

end

% Representing the start and goal points
plot(data.xStart(1), data.xStart(2), '.', 'MarkerSize', 15, 'Color', 'k')
hold on
plot(data.xGoal(1), data.xGoal(2), '.', 'MarkerSize', 15, 'Color', 'k')
hold on
text(data.xStart(1)-0.2, data.xStart(2)-0.25, 'Start', 'Color', 'k', ...
     'FontSize', 10)
hold on
text(data.xGoal(1)-0.2, data.xGoal(2)-0.25, 'Goal', 'Color', 'k', ...
     'FontSize', 10)

end

