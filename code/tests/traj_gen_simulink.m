function traj_vals = traj_gen_simulink(t, P0, P1, theta0, traj_type, trajectory_info)
    % Decipher trajectory code
    traj_types = {'line', 'bezier', 'exp', 'arc-line'};
    traj_type_ = traj_types{traj_type};
    
    % Origin and destiny
    P0 = double(P0);
    P1 = double(P1);    
    
    % Trajectory options
    T = trajectory_info.T_traj;
    trajectory_info.thetaA = theta0;
    
    traj_vals = calc_traj(traj_type, t, T, P0, P1, trajectory_info);
    
end

