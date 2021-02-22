P0 = [0; 0];
P1 = [1; 1];
theta0 = 0;

traj_type = 2;

T_traj = 1;
t = T_traj;

deltas = [2, 2, 2];

alphaA = 0.5;
alphaB = 0.5;

options = struct('T_traj', T_traj, 'dt', dt);
options.thetaA = theta0;
options.alphaA = alphaA;
options.alphaB = alphaB;
options.deltas = deltas;

traj_vals = traj_gen_simulink(t, P0, P1, theta0, traj_type, options);
