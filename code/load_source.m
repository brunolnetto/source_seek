c0 = [0; 0];
x_sym = sys.kin.q(1);
y_sym = sys.kin.q(2);

source_expr = (x_sym - c0(1))^2 + (y_sym - c0(2))^2;

paths_i = [model_name, '/Source signal'];
fun_name = 'source_signal';
expr_sym = source_expr;
vars_i = {sys.kin.q};
output = {'f_val'};

load_system(model_name);
load_simblock(model_name, paths_i, fun_name, expr_sym, vars_i, output);
save_system(model_name);
close_system(model_name);
