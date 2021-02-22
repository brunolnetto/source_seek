function traj_vals = calc_traj(traj_type, t, T, P0, P1, options)

    % Decipher trajectory code
    traj_types = {'line', 'bezier', 'exp', 'arc-line'};
    traj_type_ = traj_types{traj_type};
    
    % Origin and destiny
    P0 = double(P0);
    P1 = double(P1); 
    
    deltas = options.deltas;

    deltas_xy = deltas(1:2) + 1;
    
    dtrajs_ordered = gen_xy_traj_dtraj(traj_type_, t, T, P0, P1, deltas_xy, options);

%     syms x y th real;
%     
%     [x_nd_vars, ~] = var_and_dvar(x, deltas(1) + 1);
%     [y_nd_vars, ~] = var_and_dvar(y, deltas(2) + 1);
%     [~, th_nd1_vars] = var_and_dvar(th, deltas(3) + 1);
% 
%     xy_vars = [x_nd_vars; y_nd_vars];

    yp = dtrajs_ordered(2);
    xp = dtrajs_ordered(1);

    th_val = atan2(yp, xp);

    deltas_th = deltas(3);
    
    dthvals = zeros(deltas_th-1, 1);
    th_vals = [th_val; dthvals];
    
%     dexpr_vals = zeros(deltas_th, 1);
% 
%     n_t = 2;
%     xy_symbs = [x_nd_vars; y_nd_vars];
%     xy_vals = dtrajs_ordered;
% 
%     xy_symbs = [xy_symbs; th];
%     xy_vals = [xy_vals; th_val];
% 
%     th_vals = [];
%     for i = 1:deltas_th
% 
%         dexpr = theta_nd(i, x, y, th);
%         [num, den] = numden(dexpr);
% 
%         num_val = subs(num, xy_symbs, xy_vals);
%         den_val = subs(den, xy_symbs, xy_vals);
% 
%         if((den_val == 0) && (num_val == 0))
%             dexpr = 0;
%         else
%             dexpr_val = num_val/den_val;
%         end
% 
%         dexpr_vals = [dexpr_vals; dexpr_val]; 
% 
%         xy_symbs = [xy_symbs; th_nd1_vars(i)];
%         xy_vals = [xy_vals; dexpr_val];
%         th_vals = [th_vals; dexpr_val];
%     end

    th_vals = [th_val; th_vals];

    xy_vals = gen_xy_traj_dtraj(traj_type_, t, T, P0, P1, deltas, options);

    traj_vals = double([xy_vals; th_vals]);
end
