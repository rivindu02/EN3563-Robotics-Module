% Lab02 - Task 3.12
% Generate 3D environment with table, box, camera and coordinate frames {0},{1},{2},{3}

clc; clear; close all;

% Use the provided script to generate the 3D environment
figure('Name','Lab02 Task 3.12 - 3D Environment');
xlabel('x'); ylabel('y'); zlabel('z');

% Frame {0} - Base frame at origin
trplot(eye(4),'color','b','frame','0','length',0.4,'thick',2);
hold on; grid on; axis equal;
axis([-2 2 0 2 0 3.5]);

% Generate the 3D environment (table, box, camera)
% Table (green)
fill3([0 0 -1 -1],[1 2 2 1],[1 1 1 1],'g');
fill3([0 0 0 0 0 0 0 0],[1 1.1 1.1 1.9 1.9 2 2 1],[0 0 0.9 0.9 0 0 1 1],'g');
fill3([-1 -1 -1 -1 -1 -1 -1 -1],[1 1.1 1.1 1.9 1.9 2 2 1],[0 0 0.9 0.9 0 0 1 1],'g');
fill3([0 -0.1 -0.1 -0.9 -0.9 -1 -1 0],[2 2 2 2 2 2 2 2],[0 0 0.9 0.9 0 0 1 1],'g');
fill3([0 -0.1 -0.1 -0.9 -0.9 -1 -1 0],[1 1 1 1 1 1 1 1],[0 0 0.9 0.9 0 0 1 1],'g');

% Box on table (red)
fill3([-0.4 -0.4 -0.6 -0.6],[1.4 1.6 1.6 1.4],[1 1 1 1],'r');
fill3([-0.4 -0.4 -0.6 -0.6],[1.4 1.6 1.6 1.4],[1.2 1.2 1.2 1.2],'r');
fill3([-0.4 -0.6 -0.6 -0.4],[1.6 1.6 1.6 1.6],[1 1 1.2 1.2],'r');
fill3([-0.4 -0.6 -0.6 -0.4],[1.4 1.4 1.4 1.4],[1 1 1.2 1.2],'r');
fill3([-0.4 -0.4 -0.4 -0.4],[1.4 1.6 1.6 1.4],[1 1 1.2 1.2],'r');
fill3([-0.6 -0.6 -0.6 -0.6],[1.4 1.6 1.6 1.4],[1 1 1.2 1.2],'r');

% Camera (blue)
fill3([-0.4 -0.4 -0.6 -0.6],[1.4 1.6 1.6 1.4],[3 3 3 3],'b');
fill3([-0.4 -0.4 -0.6 -0.6],[1.4 1.6 1.6 1.4],[3.2 3.2 3.2 3.2],'b');
fill3([-0.4 -0.6 -0.6 -0.4],[1.6 1.6 1.6 1.6],[3 3 3.2 3.2],'b');
fill3([-0.4 -0.6 -0.6 -0.4],[1.4 1.4 1.4 1.4],[3 3 3.2 3.2],'b');
fill3([-0.4 -0.4 -0.4 -0.4],[1.4 1.6 1.6 1.4],[3 3 3.2 3.2],'b');
fill3([-0.6 -0.6 -0.6 -0.6],[1.4 1.6 1.6 1.4],[3 3 3.2 3.2],'b');

% Define coordinate frames based on the 3D environment
% Frame {0}: Base frame at origin (already plotted)

% Frame {1}: On the table surface at center
% Translation: move to center of table surface
t1_0 = [0; 1; 1];  % Center of table surface
R1_0 = eye(3);            % No rotation
H1_0 = rt2tr(R1_0, t1_0);
trplot(H1_0, 'color', 'b', 'frame', '1', 'length', 0.3, 'thick', 2);

% Frame {2}: At the box location
% Translation: move to center of box
t2_0 = [-0.5; 1.5; 1];  % Center of box (slightly above table)
R2_0 = roty(deg2rad(0)); 
H2_0 = rt2tr(R2_0, t2_0);
trplot(H2_0, 'color', 'b', 'frame', '2', 'length', 0.5, 'thick', 2);

% Frame {3}: At the camera location
% Translation: move to center of camera
t3_0 = [-0.5; 1.5; 3];  % Center of camera (2m above table)
R3_0 =  rotz(deg2rad(90))*rotx(deg2rad(180)); % Looking down and rotated
H3_0 = rt2tr(R3_0, t3_0);
trplot(H3_0, 'color', 'r', 'frame', '3', 'length', 0.25, 'thick', 2);

% Display all transformation matrices
fprintf('=== TRANSFORMATION MATRICES ===\n\n');

fprintf('H1_0 (Frame {0} to Frame {1} - Table surface):\n');
disp(H1_0);

fprintf('H2_0 (Frame {0} to Frame {2} - Box location):\n');
disp(H2_0);

fprintf('H3_0 (Frame {0} to Frame {3} - Camera location):\n');
disp(H3_0);

% Compute and display the MATLAB scripts for each transformation
fprintf('=== MATLAB SCRIPTS FOR TRANSFORMATIONS ===\n\n');

fprintf('Script for H1_0:\n');
fprintf('t1_0 = [%.1f; %.1f; %.1f];\n', t1_0);
fprintf('R1_0 = eye(3);\n');
fprintf('H1_0 = rt2tr(R1_0, t1_0);\n\n');

fprintf('Script for H2_0:\n');
fprintf('t2_0 = [%.1f; %.1f; %.1f];\n', t2_0);
fprintf('R2_0 = roty(deg2rad(45));\n');
fprintf('H2_0 = rt2tr(R2_0, t2_0);\n\n');

fprintf('Script for H3_0:\n');
fprintf('t3_0 = [%.1f; %.1f; %.1f];\n', t3_0);
fprintf('R3_0 = rotx(deg2rad(180)) * rotz(deg2rad(90));\n');
fprintf('H3_0 = rt2tr(R3_0, t3_0);\n\n');

% Add title and legend
title('3D Environment with Multiple Coordinate Frames');
% legend({'Frame {0} (base)', 'Frame {1} (table)', 'Frame {2} (box)', 'Frame {3} (camera)'}, ...
%        'Location', 'northeast');

hold off;

% Create summary table for answer sheet
% fprintf('=== ANSWER SHEET TABLE ===\n');
% fprintf('┌─────────────────────────────────────────────────────────────────────────┐\n');
% fprintf('│ Requirement                    │ MATLAB Script                          │\n');
% fprintf('├─────────────────────────────────────────────────────────────────────────┤\n');
% fprintf('│ Frame {0} to Frame {1}         │ t1_0=[%.1f;%.1f;%.1f]; R1_0=eye(3);   │\n', t1_0);
% fprintf('│                                │ H1_0=rt2tr(R1_0,t1_0);                │\n');
% fprintf('├─────────────────────────────────────────────────────────────────────────┤\n');
% fprintf('│ Frame {0} to Frame {2}         │ t2_0=[%.1f;%.1f;%.1f]; R2_0=roty(45°);│\n', t2_0);
% fprintf('│                                │ H2_0=rt2tr(R2_0,t2_0);                │\n');
% fprintf('├─────────────────────────────────────────────────────────────────────────┤\n');
% fprintf('│ Frame {0} to Frame {3}         │ t3_0=[%.1f;%.1f;%.1f];                │\n', t3_0);
% fprintf('│                                │ R3_0=rotx(180°)*rotz(90°);            │\n');
% fprintf('│                                │ H3_0=rt2tr(R3_0,t3_0);                │\n');
% fprintf('└─────────────────────────────────────────────────────────────────────────┘\n');