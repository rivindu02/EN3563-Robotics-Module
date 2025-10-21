mdl_puma560

p560; %  Puma 560 [Unimation]:: 6 axis, RRRRRR, stdDH, slowRNE- viscous friction; params of 8/95; 

% Canonical Configurations (Joint Coordinate Vectors)
qz, qr, qs, qn;

%Tool Transform (200 mm Extension)
p560.tool = SE3(0,0,0.2);  % extend 200mm along z-axis of T6


% Forward Kinematics

p560.fkine(qz); % Zero angle  (All joint angles = 0)

p560.fkine(qr); % Ready (Arm straight, vertical)

p560.fkine(qs); % Steady (Arm straight, horizontal)
p560.fkine(qn); % Nominal (Dexterous working pose)

%p560.plot(qn);

%figure; p560.plot3d(qz); title('Zero angle');
% figure; p560.plot3d(qr); title('Ready');
% figure; p560.plot3d(qs); title('Stretch');
% figure; p560.plot3d(qn); title('Nominal');

% Inverse Kinematics
p560.tool = SE3(); % Reset tool to zero extension

T_nom = p560.fkine(qn);
%q_inv = p560.ikine6s(T_nom);

%p560.plot(q_inv);

configs = {'lu','ld','ru','rd'};     % 3.9 options (wrist default = 'n')
sol = struct([]);

% for i = 1:numel(configs)
%     q_try = p560.ikine6s(T_nom, configs{i});
%     sol(i).cfg = configs{i};
%     sol(i).q   = q_try;
%     sse = sum((q_try - qn).^2);      % how close to the provided nominal vector
%     sol(i).sse = sse;
%     fprintf('%s  SSE=%.6f\n', configs{i}, sse);
%     figure; p560.plot3d(q_try); title(['IK: ', configs{i}]);
% end

% T_bad = SE3(2.0, 0, 0);             % way beyond reach
% q_bad = p560.ikine6s(T_bad);        % spherical-wrist IK
% disp(q_bad)
% if any(isnan(q_bad))
%     disp('Unreachable: ikine6s returned NaNs (no solution).');
% end



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
