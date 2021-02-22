function traj_vals = calc_source_line(t, T, P0, P1, options)
    % Origin and destiny
    P0 = double(P0);
    P1 = double(P1); 
    
    deltas = options.deltas;
    
    xy_vals = zeros(sum(deltas(1:2)), 1);
    xy_vals = gen_xy_traj_dtraj('line', t, T, P0, P1, deltas, options);

    yp = xy_vals(2);
    xp = xy_vals(1);

    th_val = atan2(yp, xp);

    deltas_th = deltas(3);
    dthvals = zeros(deltas_th-1, 1);
    th_vals = [th_val; dthvals];
    
    th_vals = [th_val; th_vals];
    
    aux = [xy_vals; th_vals];
    n = length(aux);
    
    traj_vals = zeros(n, 1);
    traj_vals = double(aux);
end
