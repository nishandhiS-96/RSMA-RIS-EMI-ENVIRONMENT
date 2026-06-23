clc;
clear;
close all;

% Data
n = 10:5:50;

y1 = [2381.4309 2474.0287 2477.2871 2494.5676 2522.6789 2597.8633 2750.6952 2734.5035 2665.1152];
y2 = [353.0385 392.6966 414.5669 433.2398 447.8098 461.8835 488.8569 498.3944 514.8887];

% === Smooth curves (Savitzky–Golay filter — preserves shape) ===
y1_s = smooth(y1, 7, "sgolay");
y2_s = smooth(y2, 7, "sgolay");

%% === Plot ===
figure;
hold on;
set(gca, 'YScale', 'log'); % Logarithmic scale

% Plot smoothed curves (no markers here)
semilogy(n, y1_s, '-o', 'Color', [0 0.4470 0.7410], 'LineWidth', 1.5);

semilogy(n, y2_s, '--^', 'Color', [0.4660 0.6740 0.1880], 'LineWidth', 1.5);

% Axis labels
xlabel('Number of elements (per dimension)', 'Interpreter', 'latex');
ylabel('Achievable Sum Rate (dB)', 'Interpreter', 'latex');

% Log-scale Y-axis limits
ylim([10^1.75 10^3.5]);

% Grid and box
grid on;
box on;

% Hollow dummy markers for legend
h1 = plot(nan, nan, 'o', 'Color', [0 0.4470 0.7410], 'MarkerSize', 10, 'LineStyle', 'none');
h2 = plot(nan, nan, 's', 'Color', [0.9290 0.6940 0.1250], 'MarkerSize', 10, 'LineStyle', 'none');
h3 = plot(nan, nan, '^', 'Color', [0.4660 0.6740 0.1880], 'MarkerSize', 10, 'LineStyle', 'none');
h4 = plot(nan, nan, 'h', 'Color', [0.8500 0.3250 0.0980], 'MarkerSize', 10, 'LineStyle', 'none');

legend([h1, h2, h3, h4], ...
    {'RSMA-AO: Simulation', ...
        'NOMA-AO: Simulation', ...
        'RSMA-AO: Numerical', ...
        'NOMA-AO: Numerical'}, ...
        'Location','best');
