function [nd_vars, nd1_vars] = var_and_dvar(var, n_d)
    nd_vars = var;
    for i = 1:n_d
        nd_vars = [nd_vars; add_dn(var, i)];
    end

    nd1_vars = nd_vars(2);
    for i = 1:n_d
        nd1_vars = [nd1_vars; add_dn(var, i+1)];
    end    
end