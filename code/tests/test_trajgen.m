clear all
close all
clc

P0 = [0; 0];
P1 = [1; 1];
theta0 = 0;

traj_type = 4;

deltas = [2, 2, 2];

% Trajectory options
T_traj = 1;
dt = 0.001;

T = T_traj;
t = T_traj/100;

options = struct('T_traj', T_traj, 'dt', dt);
options.thetaA = theta0;
options.alphaA = 0.5;
options.alphaB = 0.5;
options.deltas = deltas; 

traj_vals = calc_traj(traj_type, t, T, P0, P1, options)


