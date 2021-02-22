function theta_nd = theta_nd(n_d, x_sym, y_sym, th_sym)
    x = x_sym;
    y = y_sym;
    th = th_sym;

    [x_nd_vars, x_nd1_vars] = var_and_dvar(x, n_d);
    [y_nd_vars, y_nd1_vars] = var_and_dvar(y, n_d);
    [th_nd_vars, th_nd1_vars] = var_and_dvar(th, n_d);
    
    expr = x_nd_vars(2)*cos(th) - y_nd_vars(2)*sin(th);

    if(n_d < 1)
        error('Derivative must be greater than 1.');
    else
        n_x = length(x_nd_vars);

        nd_vars = [x_nd_vars; y_nd_vars; th_nd_vars];
        nd1_vars = [x_nd1_vars; y_nd1_vars; th_nd1_vars];

        thp_exprs = th_nd1_vars(1:end-1);
        
        dexpr_1 = expr;

        dexprs = [];
        for i = 1:n_d
            dexpr = dvecdt(dexpr_1, nd_vars, nd1_vars);
            dexpr = simplify(dexpr);
            
            dexpr_1 = dexpr;
        end
        
        th_nd = th_nd1_vars(n_d);
        
        den = equationsToMatrix(dexpr, th_nd);
        num = simplify(dexpr - den*th_nd);
        
        theta_nd = num/den;
    end
end