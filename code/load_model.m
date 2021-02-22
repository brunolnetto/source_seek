repo_path = '/home/brunolnetto/github/matlab-utils';
path = '/control/synthesis/exact_lin/examples/omni/code/main';
run([repo_path path]);

clearvars -except sys
clear_inner_close_all(pwd);

model_name = 'bary_source_seeking';

gen_plant_scripts(sys, model_name);
run('load_source.m');
run('load_control.m');
