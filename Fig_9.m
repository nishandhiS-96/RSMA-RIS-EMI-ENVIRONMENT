%%
% Combination of comparison of NOMA vs RSMA and power allocation
clc;
clear;
close all;

%% X-axis values
n = 0:2:40;

%% Data
y1 = [1 0.012952 0.000682 0.000309 0.000220 0.000158 0.000143 0.000112 ...
      0.000119 9.3e-05 0.000102 7.2e-05 8.4e-05 8.2e-05 5.7e-05 ...
      7.0e-05 5.8e-05 5.2e-05 6.4e-05 4.7e-05 5.3e-05];

y2 = [1 0.17048 0.03222 0.01617 0.01075 0.00782 0.00596 0.00489 ...
      0.00409 0.00347 0.00293 0.00304 0.00273 0.00257 0.00227 ...
      0.00223 0.00219 0.00199 0.00200 0.00190 0.00184];

y3 = [1 0.02804 0.004104 0.00242 0.001615 0.001271 0.001056 0.00089 ...
      0.000831 0.000795 0.00073 0.000658 0.000591 0.000562 ...
      0.000565 0.00050 0.000476 0.00049 0.000462 0.000464 ...
      0.000439];

y4 = [1 0.65096 0.14746 0.07694 0.05363 0.04114 0.03593 0.03242 ...
      0.03018 0.02771 0.02721 0.02500 0.02453 0.02338 ...
      0.02346 0.02248 0.02247 0.02263 0.02155 0.02034 ...
      0.02084];

%% Marker positions (only these x-values get markers)
markX = 0:10:40;
[~, markIdx] = ismember(markX, n);
markIdx(markIdx == 0) = [];

%% Proper smoothing (LOG-DOMAIN – IMPORTANT)
span = 0.3;   % 0.25–0.4 is safe for papers

y1_s = 10.^smooth(log10(y1), span, 'loess');
y2_s = 10.^smooth(log10(y2), span, 'loess');
y3_s = 10.^smooth(log10(y3), span, 'loess');
y4_s = 10.^smooth(log10(y4), span, 'loess');
%% IEEE-style colors
col1 = [0.85 0.33 0.10];        % Without EMI (red-orange)
col2 = [0 0.4470 0.7410];       % With EMI (IEEE blue)

%% Plot
figure;
hold on; box on; grid on;

% ---- Smoothed curves ----
semilogy(n, y1_s, '-.', 'Color', col1, 'LineWidth', 1.5);
semilogy(n, y2_s, '-.', 'Color', col1, 'LineWidth', 1.5);

semilogy(n, y3_s, '-', 'Color', col2, 'LineWidth', 1.5);
semilogy(n, y4_s, '-', 'Color', col2, 'LineWidth', 1.5);

% ---- Markers at selected x-values ----
semilogy(n(markIdx), y1(markIdx), 'o', 'Color', col1, ...
    'MarkerSize', 5, 'LineWidth', 1.2);
semilogy(n(markIdx), y2(markIdx), 'o', 'Color', col1, ...
    'MarkerSize', 5, 'LineWidth', 1.2);

semilogy(n(markIdx), y3(markIdx), '^', 'Color', col2, ...
    'MarkerSize', 5, 'LineWidth', 1.2);
semilogy(n(markIdx), y4(markIdx), '^', 'Color', col2, ...
    'MarkerSize', 5, 'LineWidth', 1.2);

% Dummy plots for legend (same colors)
h1 = semilogy(nan, nan, 'o', 'Color', col1, 'MarkerSize', 10);
h2 = semilogy(nan, nan, '^', 'Color', col2, 'MarkerSize', 10);

legend([h1, h2], {'Without EMI', 'With EMI'}, ...
       'Location', 'best', 'Interpreter', 'latex');

xlim([0 40]);
ylim([1e-5 1]);

xlabel('Transmit Power (dBm)', 'Interpreter', 'latex');
ylabel('Outage Probability', 'Interpreter', 'latex');
set(gca, 'YScale', 'log', 'FontSize', 12);
grid on;
