
% Lab02 - tasks 3.1 to 3.6
clc; clear; close all;
% ---
q0_in_0 = [2; 3; 1];         % q0 expressed in frame {0}
angle_deg = 90;              % rotation about Z to get frame {-9}
p_in_1 = [1; 1; 1];   % point p expressed in frame {1}

% 3.1 Visualize coordinate system {0}
figure('Name','Lab02 3.1-3.6');
trplot(eye(4), 'frame', '0', 'color', 'b', 'length', 0.4, 'thick', 2);
hold on; grid on; axis equal;
axis([0 4 0 4 0 3]); xlabel('X'); ylabel('Y'); zlabel('Z');

% 3.2 Obtain rotation R1_0 and translation t1_0
theta = deg2rad(angle_deg);
R1_0 = rotz(theta);        % rotation matrix 3x3 (frame1 relative to frame0)
t1_0 = q0_in_0;            % translation vector (origin of {1} in {0})

% Display R and t
disp('R1_0 ='); disp(R1_0);
disp('t1_0 ='); disp(t1_0);

% 3.3 Visualize q0 in the figure using blue color (arrow from origin)
% plot a blue arrow from origin to q0_in_0
plot3([0 q0_in_0(1)], [0 q0_in_0(2)], [0 q0_in_0(3)], 'b-', 'LineWidth', 2);
plot3(q0_in_0(1), q0_in_0(2), q0_in_0(3), 'bo', 'MarkerSize', 6, 'MarkerFaceColor','b');

% 3.4 Obtain H1_0 and visualize coordinate frame {1} using red color
H1_0 = rt2tr(R1_0, t1_0);   % homogeneous transform (Robotics Toolbox)
% (alternatively: H1_0 = [R1_0 t1_0; 0 0 0 1];)
trplot(H1_0, 'frame', '1', 'color', 'r', 'length', 0.4, 'thick', 2);

% show H1_0 numeric
disp('H1_0 ='); disp(H1_0);

% 3.5 Find p0 and visualize it in the same figure using green color
% Convert p1 (in {1}) to homogeneous, then to {0}
P1_h = [p_in_1; 1];           % homogeneous coordinates in frame {1}
P0_h = H1_0 * P1_h;           % p expressed in frame {0}
p_in_0 = P0_h(1:3);

% plot p0 as green arrow from origin
plot3([0 p_in_0(1)], [0 p_in_0(2)], [0 p_in_0(3)], 'g-', 'LineWidth', 2);
plot3(p_in_0(1), p_in_0(2), p_in_0(3), 'go', 'MarkerFaceColor','g');

disp('p_in_1 (given) ='); disp(p_in_1');
disp('p_in_0 (converted) ='); disp(p_in_0');

% 3.6 Visualize p1 in the same figure using red color
% To plot p1 in the global figure we show its location in {0} coordinates (already computed)
plot3([q0_in_0(1) p_in_0(1)], [q0_in_0(2) p_in_0(2)], [q0_in_0(3) p_in_0(3)], 'r--', 'LineWidth', 1.5);
plot3(p_in_0(1), p_in_0(2), p_in_0(3), 'r*', 'MarkerSize', 8);

legend({'frame 0 origin','q0 vector','frame 1','p0 (green)','p1 position (red)'}, 'Location', 'northeastoutside');
hold off;