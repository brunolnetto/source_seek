x = sys.kin.q(1);
y = sys.kin.q(2);
th = sys.kin.q(3);

n_d = 5;

[x_nd_vars, x_nd1_vars] = var_and_dvar(x, n_d);
[y_nd_vars, y_nd1_vars] = var_and_dvar(y, n_d);
[th_nd_vars, th_nd1_vars] = var_and_dvar(th, n_d);

n_x = length(x_nd_vars);

nd_vars = [x_nd_vars; y_nd_vars; th_nd_vars];
nd1_vars = [x_nd1_vars; y_nd1_vars; th_nd1_vars];

thp_exprs = th_nd1_vars(1:end-1);

expr = x_nd_vars(2)*cos(th) - y_nd_vars(2)*sin(th);
dexpr_1 = expr;

dens = sym(zeros(n_x, 1));
nums = sym(zeros(n_x, 1));

dexprs = [];
for i = 1:nd
    dexpr = dvecdt(dexpr_1, nd_vars, nd1_vars);
    dexpr = simplify(dexpr);
    
    dexpr_1 = dexpr;
end



