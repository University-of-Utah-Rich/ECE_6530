%% Analzye accelerometer data

% Import the file into x,y,z vectors
% Assumes files are in the workspace in a folder called accelerometer_data
% Change path as required
[x,y,z] = importfile('accelerometer_data/Climb_stairs/Accelerometer-2011-03-24-10-24-39-climb_stairs-f1.txt');

% Acceleration due to gravity (m/s^2)
g = 9.8;

% Create a layout to plot both the encoded and decoded data together
figure
tiledlayout(1,2);

% Plot the encoded data
nexttile
plot3(x, y, z)
grid on
title('Encoded Accelerometer Data')


% Decode the data
real_x = -1.5 * g + 3 * g .* x ./ 63;
real_y = -1.5 * g + 3 * g .* y ./ 63;
real_z = -1.5 * g + 3 * g .* z ./ 63;

% Plot the decoded data
hold on
nexttile
plot3(real_x, real_y, real_z)
grid on
title('Decoded Accelerometer Data')
hold off
%% Analyze a cos signal at different sampling rates

% initialize variables
f = 30; %Hz
T = 1/f;
tmin = -0.5;
tmax = 0.5;
continuous_rate = 100*f;

% time steps for the various sampling rates
dt1 = 1/80;
dt2 = 1/60;
dt3 = 1/30;

% time scales
t = tmin:1/continuous_rate:tmax;
t1 = tmin:dt1:tmax;
t2 = tmin:dt2:tmax;
t3 = tmin:dt3:tmax;

% cos signal
c = cos(2*pi*f .* t);
c1 = cos(2 * pi * f .* t1);
c2 = cos(2 * pi * f .* t2);
c3= cos(2 * pi * f .* t3);

% plot
figure
plot(t,c);
hold on
plot(t1, c1, '--x');
plot(t2, c2, '--*');
plot(t3, c3, '--o');
hold off
xlim([-0.6, 0.6])
ylim([-2, 2])
legend('continuous', 'Sampled - 80Hz', 'Sampled - 60 Hz', 'Sampled - 30 Hz')

%% Part 5 Combine sampled signal with acc data

t = tmin:1/32:tmax;
c4 = cos(2 * pi * f .* t);
xc = real_x + c4;
figure
plot(t, xc)
title('Composite signal of sampled cos and decoded accl x values')