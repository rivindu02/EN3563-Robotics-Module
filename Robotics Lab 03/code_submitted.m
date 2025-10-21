%% Tasks for Lab 03 (Puma 560)
%% 3.1 Instantiate Puma 560 robot model
mdl_puma560   % built-in model from the Robotics Toolbox
fprintf('\n Puma 560 object created \n'); 

%% 3.2 - Robot geometry and DH parameter table
p560; %Puma 560 [Unimation]:: 6 axis, RRRRRR, stdDH, slowRNE - viscous friction; params of 8/95;

%% 3.3 - Joint coordinate vectors for canonical configurations
% Canonical Configurations (Joint Coordinate Vectors)
qz, qr, qs,qn

%% 3.4 - Define tool transform: extension of 200 mm in z of T6 frame
p560.tool = SE3(0,0,0.2);  % extend 200mm along z-axis of T6

%% 3.5 Forward kinematics for canonical configurations
configs = {'zero angle (qz)', 'ready (qr)', 'stretch (qs)', 'nominal (qn)'};
q_vecs = {qz,qr,qs,qn};

for i = 1:4
    q = q_vecs{i};
    T = p560.fkine(q);
    fprintf('\nConfiguration: %s\n', configs{i});
    fprintf('Position (m): '); disp(transl(T));
    disp('Rotation matrix:'); disp(t2r(T));
end

%% 3.6 Graphically display realistic plots for canonical configurations
for i = 1:4
    figure('Name',sprintf('Puma560 - %s',configs{i}));
    % plot3d provides more realistic model (shaded links) if supported
    p560.plot3d(q_vecs{i})
    title(sprintf('Puma 560: %s', configs{i}));
end

%% 3.7  reset the tool transform to zero extension
p560.tool = SE3(0,0,0);  % extend 200mm along z-axis of T6

%% 3.8 perform inverse kinematics 
T_nominal = p560.fkine(qn);
disp('Target T_nominal:'); disp(T_nominal.T);
%p560.plot(qn)

% Analytical inverse kinematics (for 6-axis spherical wrist)
q_inv_nominal = p560.ikine6s(T_nominal);
disp('Recovered joint vector (ikine6s):'); disp(q_inv_nominal);
%p560.plot(q_inv_nominal)

fprintf('Difference from qn (radians):\n');
disp(q_inv_nominal - qn);

T_check = p560.fkine(q_inv_nominal);
disp('FK result from IK solution:'); disp(T_check.T);
fprintf('Pose difference (should be near zero):\n');
disp(T_check.T - T_nominal.T);

%% 3.9 Inverse Kinematics for a New Pose 
configs = {'lu','ld','ru','rd'};     % 3.9 options (wrist default = 'n')
sol = struct([]);

for i = 1:numel(configs)
       q_try = p560.ikine6s(T_nominal, configs{i});
      sol(i).cfg = configs{i};
      sol(i).q   = q_try;
      sse = sum((q_try - qn).^2);      % how close to the provided nominal vector
      sol(i).sse = sse;
      fprintf('%s  SSE=%.6f\n', configs{i}, sse);
      figure; p560.plot3d(q_try); title(['IK: ', configs{i}]);
end
%% 3.10 Give an unreachable point
 T_bad = SE3(2.0, 0, 0);             % way beyond reach
 q_bad = p560.ikine6s(T_bad);        % spherical-wrist IK
 disp(q_bad)
 if any(isnan(q_bad))
     disp('Unreachable: ikine6s returned NaNs (no solution).');
 end

%% observe Puma 560 motion
close all; clear all;
mdl_puma560
T1 = SE3(0.8, 0, 0) * SE3.Ry(pi/2);
T2 = SE3(-0.8,0, 0) * SE3.Rx(pi);

% IK (spherical wrist)
q1 = p560.ikine6s(T1);
q2 = p560.ikine6s(T2);

% Quintic joint trajectory
t = (0:0.05:2)';                    % time vector
q = jtraj(q1, q2, t);               % joint waypoints

% Animate realistic 3D model
p560.plot3d(q);