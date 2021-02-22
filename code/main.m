clear all
close all
clc

% Load system
run('load_model.m');

% (dest, traj, u) noise parameters
noise_options = {[true, false, false], ...
                 [false, true, false], ...
                 [false, false, true]};
noise_devvals = {0.5, 0.5, 0.5};
noise_names = {'dest', 'traj', 'u'};

n = length(noise_options);

for i = 1:n
    noise_option = noise_options{i};
    noise_devval = noise_devvals{i}; 
    noise_name = noise_names{i};
    
    run('load_parameters.m');
    
    options.abs_tol = '1e-3';
    options.rel_tol = '1e-3';
    
    wb = my_waitbar(['Simulation: ', noise_name]);
    simOut = sim_block_diagram(model_name, x0, options);
    wb.close_window();
    
    run('./plot_simulation.m');
end

