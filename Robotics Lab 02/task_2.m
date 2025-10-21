% Lab02 - tasks 3.7 to 3.11
% Continuation from tasks 3.1-3.6

clc; clear; close all;

% ---
% Given values from previous tasks
q0_in_0 = [2; 3; 1];         % q0 expressed in frame {0}
angle_deg = 90;              % rotation about Z to get frame {1}
p_in_1 = [1; 1; 1];          % point p expressed in frame {1}
% ---

% First, we need to compute the transformations from previous tasks
theta = deg2rad(angle_deg);
R1_0 = rotz(theta);          % rotation matrix 3x3 (frame1 relative to frame0)
t1_0 = q0_in_0;              % translation vector (origin of {1} in {0})
H1_0 = rt2tr(R1_0, t1_0);    % homogeneous transform from {0} to {1}

% 3.7 Use a new MATLAB figure to visualize coordinate system {1} and p1 using red color
figure('Name','Lab02 3.7-3.11');
trplot(eye(4), 'frame', '1', 'color', 'r', 'length', 0.4, 'thick', 2);
hold on; grid on; axis equal;
axis([-4 2 -1 3 -2 2]); xlabel('X'); ylabel('Y'); zlabel('Z');

% Visualize p1 in frame {1} using red color
plot3([0 p_in_1(1)], [0 p_in_1(2)], [0 p_in_1(3)], 'r-', 'LineWidth', 2);
plot3(p_in_1(1), p_in_1(2), p_in_1(3), 'ro', 'MarkerSize', 6, 'MarkerFaceColor','r');

% 3.8 Obtain the homogeneous transformation matrix H0_1 (inverse of H1_0)
H0_1 = inv(H1_0);
% Alternative method using the inverse formula: H0_1 = [R1_0' -R1_0'*t1_0; 0 0 0 1];

disp('H0_1 (inverse transformation) =');
disp(H0_1);

% 3.9 Visualize frame {0} with blue color
trplot(H0_1, 'frame', '0', 'color', 'b', 'length', 0.4, 'thick', 2);

% 3.10 Find t0_1 and visualize it on the figure with blue color
% t0_1 is the translation part of H0_1, which represents the position of frame {0} origin in frame {1}
t0_1 = H0_1(1:3, 4);

% Visualize t0_1 as blue arrow from origin of frame {1}
plot3([0 t0_1(1)], [0 t0_1(2)], [0 t0_1(3)], 'b-', 'LineWidth', 2);
plot3(t0_1(1), t0_1(2), t0_1(3), 'bo', 'MarkerSize', 6, 'MarkerFaceColor','b');

disp('t0_1 (position of frame {0} origin in frame {1}) =');
disp(t0_1');

% 3.11 Visualize a green arrow from the tip of p1 to the origin of frame {0}
% The origin of frame {0} in frame {1} is at t0_1
% The tip of p1 is at p_in_1
% So we draw an arrow from p_in_1 to t0_1
plot3([p_in_1(1) t0_1(1)], [p_in_1(2) t0_1(2)], [p_in_1(3) t0_1(3)], 'g-', 'LineWidth', 2);
plot3([p_in_1(1) t0_1(1)], [p_in_1(2) t0_1(2)], [p_in_1(3) t0_1(3)], 'g*', 'MarkerSize', 6);

% Add legend
legend({'frame 1 (red)', 'p1 vector (red)', 'frame 0 (blue)', 't0_1 vector (blue)', 'green arrow p1 to frame 0'}, 'Location', 'northeastoutside');

% Display results summary
fprintf('\n=== RESULTS SUMMARY ===\n');
fprintf('Given:\n');
fprintf('  q0_in_0 = [%.1f; %.1f; %.1f]\n', q0_in_0);
fprintf('  angle = %.0f degrees\n', angle_deg);
fprintf('  p_in_1 = [%.1f; %.1f; %.1f]\n', p_in_1);

fprintf('\nComputed transformations:\n');
fprintf('  H1_0 (from task 3.4):\n');
disp(H1_0);
fprintf('  H0_1 (inverse, task 3.8):\n');
disp(H0_1);
fprintf('  t0_1 = [%.4f; %.4f; %.4f]\n', t0_1);

hold off;