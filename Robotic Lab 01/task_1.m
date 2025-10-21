% Spatial Descriptions with Robotics Toolbox
clc; clear; close all;

figure; hold on; axis equal;
title('Spatial Descriptions with Robotics Toolbox');

% 3.1 Default frame {0}
trplot2(SE2(), 'frame', '0', 'color', 'k', 'length', 2);
axis([-4,7,-2,7])
grid on;
% 3.2 Point p = [5;6] in frame {0}
p_in_0 = [5; 6];
plot_arrow([0 0], p_in_0', 'b');

% 3.3 Frame {1} rotated 45° CCW from {0}
theta = deg2rad(45);
R1_in_0 = rot2(theta);
tranimate2(R1_in_0, 'frame', '1', 'color', 'r', 'arrow')

% Transform point p into frame {1}
p_in_1 = R1_in_0' * p_in_0;  % transformation
disp('p in frame {1}:');
disp(p_in_1);

% 3.4 Define q = [-3;2] in frame {1}
q_in_1 = [-3; 2];
q_in_0 = R1_in_0 * q_in_1;   % expressed in frame {0} for visualization
plot_arrow([0 0], q_in_0', 'r');

% 3.5 Rotate p by 68° CCW in {0}
phi = deg2rad(68);
Rphi = rot2(phi);
r_in_0 = Rphi * p_in_0;
plot_arrow([0 0], r_in_0', 'g');