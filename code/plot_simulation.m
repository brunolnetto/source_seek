% Data read
time_q = simOut.coordinates.time;
coordinates = simOut.coordinates.signals.values;

time_p = simOut.p_speeds.time;
p_speeds = simOut.p_speeds.signals.values;

time_qp = simOut.q_speeds.time;
qp_speeds = simOut.q_speeds.signals.values;

time_traj = simOut.trajs.time;
trajs = simOut.trajs.signals.values;

time_readings = simOut.readings.time;
readings = simOut.readings.signals.values;

time_estimations = simOut.estimations.time;
estimations = simOut.estimations.signals.values;

time_xhat = simOut.xhat.time;
xhat = simOut.xhat.signals.values;

time_xhat_interval = simOut.xhat_interval.time;
xhat_interval = simOut.xhat_interval.signals.values;

time_m = simOut.m_interval.time;
m_interval = simOut.m_interval.signals.values;

time_u = simOut.u.time;
u = simOut.u.signals.values;

% % States
% markers = {'-', 'r--'};
% legends_x = {'$x(t)$', '$x^\star(t)$'};
% legends_y = {'$y(t)$', '$y^\star(t)$'};
% legends_th = {'$\theta(t)$', '$\theta^\star(t)$'};
% 
% plot_info.titles = {'', '', '', '', '', ''};
% plot_info.xlabels = {'', '', '', ...
%                      '$t$ $[s]$', '$t$ $[s]$', '$t$ $[s]$'};
% plot_info.ylabels = {'$x$ $[m]$', '$y$ $[m]$', '$\theta$ $[rad]$', ...
%                      '$\phi_1$ $[rad]$', ...
%                      '$\phi_2$ $[rad]$', ...
%                      '$\phi_3$ $[rad]$'};
% plot_info.grid_size = [2, 3];
% plot_info.legends = {legends_x, legends_y, legends_th};
% plot_info.pos_multiplots = [1 2 3];
% plot_info.markers = {markers, markers, markers};
% 
% traj_xyth = [trajs(:, 1), trajs(:, 4), trajs(:, 7)];
% 
% x = {coordinates, traj_xyth};
% 
% [h_q, axs] = my_plot(time_q, x, plot_info);

plot_info.titles = {'', '', '', '', '', ''};
plot_info.xlabels = {'', '', '', ...
                     '$t$ $[s]$', '$t$ $[s]$', '$t$ $[s]$'};
plot_info.ylabels = {'$x$ $[m]$', '$y$ $[m]$', '$\theta$ $[rad]$', ...
                     '$\phi_1$ $[rad]$', ...
                     '$\phi_2$ $[rad]$', ...
                     '$\phi_3$ $[rad]$'};
plot_info.grid_size = [2, 3];

x = coordinates;

[h_q, axs] = my_plot(time_q, x, plot_info);

axis(axs{1}{1}, 'square');
axis(axs{1}{2}, 'square');
axis(axs{1}{3}, 'square');
axis(axs{1}{4}, 'square');
axis(axs{1}{5}, 'square');
axis(axs{1}{6}, 'square');

% Input
plot_info.titles = {'', '', '', '', '', ''};
plot_info.xlabels = {'', '', '', '', '', ''};
plot_info.ylabels = {'$\tau_1$ $[Nm]$', ...
                     '$\tau_2$ $[Nm]$', ...
                     '$\tau_3$ $[Nm]$'};
plot_info.grid_size = [1, 3];

[h_u, axs] = my_plot(time_u, u, plot_info);

axis(axs{1}{1}, 'square');
axis(axs{1}{2}, 'square');
axis(axs{1}{3}, 'square');

plot_info.titles = {'', '', '', '', '', ''};
plot_info.xlabels = {'', '', '', ...
                     '$t$ $[s]$', '$t$ $[s]$', '$t$ $[s]$'};
plot_info.ylabels = {'$\dot{x}$ $[m]$', ...
                     '$\dot{y}$ $[m]$', ...
                     '$\dot{\theta}$ $[\frac{rad}{s}]$', ...
                     '$\dot{\phi_1}$ $[\frac{rad}{s}]$', ...
                     '$\dot{\phi_2}$ $[\frac{rad}{s}]$', ...
                     '$\dot{\phi_3}$ $[\frac{rad}{s}]$'};
plot_info.grid_size = [2, 3];

[h_qp, axs] = my_plot(time_qp, qp_speeds, plot_info);

axis(axs{1}{1}, 'square');
axis(axs{1}{2}, 'square');
axis(axs{1}{3}, 'square');
axis(axs{1}{4}, 'square');
axis(axs{1}{5}, 'square');
axis(axs{1}{6}, 'square');

% Speeds
plot_info.titles = {'', '', ''};
plot_info.xlabels = {'', '', '', '', '', ''};
plot_info.ylabels = {'$v_x$ $[\frac{m}{s}]$', ...
                     '$v_y$ $[\frac{m}{s}]$', ...
                     '$\dot{\theta}$ $[\frac{rad}{s}]$'};
plot_info.grid_size = [1, 3];

[h_p, axs] = my_plot(time_p, p_speeds, plot_info);

axis(axs{1}{1}, 'square');
axis(axs{1}{2}, 'square');
axis(axs{1}{3}, 'square');

% XY plot
xm = -3;
xM = 3;
ym = -3;
yM = 3;

n = 30;
x = linspace(xm, xM, n);
y = linspace(ym, yM, n);

nx = length(x);
ny = length(y);

wb = my_waitbar('Loading function.');

Z = zeros(nx, ny);
for i = 1:nx
    xi = x(i);
    for j = 1:ny 
        yi = y(j);
        Z(i, j) = my_subs(source_expr, sys.kin.q(1:2), [xi; yi]);
        wb.update_waitbar(i*nx + j, nx*ny);
    end
end

wb.close_window();

[X,Y] = meshgrid(x,y);

h_xy = my_figure();

contour(X, Y, Z);
hold on;

plot(coordinates(:, 1), coordinates(:, 2), 'b-');
hold on;

plot(xhat_interval(:, 1), xhat_interval(:, 2), ...
     'k-', 'Linewidth', 3);
hold on;

plot(coordinates(1, 1), coordinates(1, 2), ....
     'gp', 'MarkerSize', 15, 'MarkerFaceColor', 'green');
hold on;

plot(coordinates(end, 1), coordinates(end, 2), ...
     'sr', 'MarkerSize', 15, 'MarkerFaceColor', 'red');
hold on;

plot(c0(1), c0(2), ....
     'co', 'MarkerSize', 15, 'MarkerFaceColor', 'blue');
hold off;

axis(gca, 'square');

xlabel('$x$ $[m]$', 'interpreter', 'latex');
ylabel('$y$ $[m]$', 'interpreter', 'latex');

% [C_1, IA_1, ~] = unique(xhat(:, 1));
% IA_1 = sort(IA_1);
% 
% [C_2, IA_2, ~] = unique(xhat(:, 2));
% IA_2 = sort(IA_2);
% 
% Cs = [xhat(IA_1, 1), xhat(IA_2, 2)];
% 
% plot(Cs(:, 1), Cs(:, 2), 'ro');
% 
% traj_cell = {};
% traj_xy = [trajs(:, 1), trajs(:, 4)];
% 
% for i = 1:length(IA_1)-1
%     j = IA_1(i);
%     jp1 = IA_1(i+1)-1;
%     plot(traj_xy(j:jp1, 1), traj_xy(j:jp1, 2), 'r--');
%     hold on;
% end
% 
% j = IA_1(end);
% plot(traj_xy(j:end, 1), traj_xy(j:end, 2), 'r--');

% Source value
plot_info.titles = {''};
plot_info.xlabels = {'$t$ $[s]$'};
plot_info.ylabels = {'$f(x)$'};
plot_info.grid_size = [1, 1];

[h_f, axs] = my_plot(time_readings, readings, plot_info);

axis([xm xM ym yM]);
axis(axs{1}{1}, 'square');

% Source estimation on interval
plot_info.titles = {'', ''};
plot_info.xlabels = {'$t$ [s]', '$t$ [s]'};
plot_info.ylabels = {'$x_{\mathcal{I}}$ $[m]$', ...
                     '$y_{\mathcal{I}}$ $[m]$'};
plot_info.grid_size = [1, 2];

[h_xhi, axs] = my_plot(time_xhat_interval, xhat_interval, plot_info);

axis(axs{1}{1}, 'square');
axis(axs{1}{2}, 'square');

% Estimation value
plot_info.titles = {'', ''};
plot_info.xlabels = {'$t$ [s]', '$t$ [s]'};
plot_info.ylabels = {'$\hat{x}$ $[m]$', '$\hat{y}$ $[m]$'};
plot_info.grid_size = [1, 2];

[h_xhat, axs] = my_plot(time_xhat, xhat, plot_info);

axis(axs{1}{1}, 'square');
axis(axs{1}{2}, 'square');

imgs_path = '../imgs/';
mkdir([imgs_path, '/', noise_name]);
filepath = [imgs_path, '/', noise_name, '/'];

saveas(h_q, [filepath, 'states'], 'epsc');
saveas(h_u, [filepath, 'input'], 'epsc');
saveas(h_xy, [filepath, 'cartesian'], 'epsc');
saveas(h_qp, [filepath, 'state_speeds'], 'epsc');
saveas(h_p, [filepath, 'speeds'], 'epsc');
saveas(h_f, [filepath, 'function'], 'epsc');
saveas(h_xhat, [filepath, 'estimation'], 'epsc');

close all
