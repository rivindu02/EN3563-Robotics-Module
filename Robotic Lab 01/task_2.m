% 3.6 - 3.9: 3D frames, rotations, and RPY extraction
clc; clear; close all;

% 3.6: Visualize default 3D frame {0}
figure;
trplot(eye(4), 'frame', '0', 'color','b'); % default frame
axis([-1 2 -1 2 -1 2]);
grid on;
view(45,25);
hold on;

% 3.7: Build successive rotations (intrinsic rotations about current axes)

% Use rotx, roty, rotz (degrees)
R_x = rotx(deg2rad(15));            % rotation about X (degrees)
R_xy = R_x * roty(deg2rad(25));    % then about new Y
R_xyz = R_xy * rotz(deg2rad(35));  % then about new Z

% R1_0 is the rotation of frame {1} relative to {0} (3x3)
R1_0 = R_xyz;              % 3x3 rotation matrix

% Visualize intermediate frames with animation (optional cleanup)
tranimate(eye(4), 'frame', '0', 'color','b');      % base
pause(0.5);
T1 = eye(4); T1(1:3,1:3) = R_x;     tranimate(T1, 'frame', 'after_X', 'color','k', 'cleanup', true);
pause(0.5);
T2 = eye(4); T2(1:3,1:3) = R_xy;    tranimate(T2, 'frame', 'after_XY','color','m','cleanup', true);
pause(0.5);
T3 = eye(4); T3(1:3,1:3) = R_xyz;   tranimate(T3, 'frame', '1', 'color','r');

% Display R1_0
disp('R1_0 (rotation matrix from 3.7):');
disp(R1_0);

% 3.9: Given rotation matrix R (from the lab), find psi (roll about X), theta (pitch about Y), phi (yaw about Z)
R_lab = [ 0.8138  0.0400  0.5798;
          0.2962  0.8298 -0.4730;
         -0.5000  0.5567  0.6634 ];

% Use tr2rpy with 'deg' and 'xyz' to request roll(X)-pitch(Y)-yaw(Z) ordering
rpy_deg = tr2rpy(R_lab, 'deg', 'xyz');  % returns [roll pitch yaw] in degrees
psi_deg   = rpy_deg(1); % roll about X
theta_deg = rpy_deg(2); % pitch about Y
phi_deg   = rpy_deg(3); % yaw about Z

fprintf('For R_lab -> roll about X = %.4f deg\n', psi_deg);
fprintf('pitch about Y = %.4f deg\n', theta_deg);
fprintf('yaw about Z = %.4f deg\n', phi_deg);

% Confirm by rebuilding R from these angles and comparing to R_lab
R_check = rpy2r(psi_deg, theta_deg, phi_deg, 'deg', 'xyz');
disp('Reconstructed R from rpy2r (should match R_lab):');
disp(R_check);
disp('Frobenius norm of difference (R_check - R_lab):');
disp(norm(R_check - R_lab, 'fro'));