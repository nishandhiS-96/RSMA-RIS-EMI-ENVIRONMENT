clc;
clear all;
close all;
n = 0:2:40;

y4 = [1	0.999902000000000	0.981167000000000	0.904289000000000	0.795221000000000	0.686506000000000	0.590018000000000	0.507714000000000	0.440057000000000	0.383707000000000	0.336270000000000	0.297700000000000	0.263962000000000	0.236638000000000	0.212369000000000	0.192373000000000	0.174726000000000	0.159081000000000	0.145850000000000	0.133706000000000	0.123682000000000];

y23 = [1	0.169732000000000	0.0317460000000000	0.0164620000000000	0.0108350000000000	0.00772900000000000	0.00608900000000000	0.00487500000000000	0.00422800000000000	0.00356100000000000	0.00314700000000000	0.00296100000000000	0.00270600000000000	0.00252100000000000	0.00243800000000000	0.00221800000000000	0.00214900000000000	0.00202500000000000	0.00207600000000000	0.00191300000000000	0.00181000000000000];



figure;
hold on;

% Define colors
yellow_color = [0.9290 0.6940 0.1250];  % RSMA (yellow)
red_color    = [0.8500 0.3250 0.0980];  % NOMA (red)

% Marker x-positions
mark_x = 0:5:max(n);

% ==== Plot RSMA ====
semilogy(n, y23, '-', 'Color', yellow_color, 'LineWidth', 2);
mark_y = interp1(n, y23, mark_x);
semilogy(mark_x, mark_y, 'o', ...
    'Color', yellow_color, 'MarkerEdgeColor', yellow_color, ...
    'MarkerFaceColor', 'none', 'MarkerSize', 6, 'LineWidth', 1.4);

% ==== Plot NOMA ====
semilogy(n, y4, '--', 'Color', red_color, 'LineWidth', 2);
mark_y2 = interp1(n, y4, mark_x);
semilogy(mark_x, mark_y2, '^', ...
    'Color', red_color, 'MarkerEdgeColor', red_color, ...
    'MarkerFaceColor', 'none', 'MarkerSize', 6, 'LineWidth', 1.4);

% ==== Axis formatting (single axis) ====
ylabel('Outage Probability', 'Color', 'k');
ylim([10^-4 1]);        % Unified range
set(gca, 'YScale', 'log');
xlim([0 max(n)]);
xticks(0:5:max(n));
xlabel('Transmit Power (dBm)');
set(gca, 'FontSize', 12, 'XColor', 'k', 'YColor', 'k');
box on;

% ==== Legend ====
h1 = plot(nan, nan, '-',  'Color', yellow_color, 'LineWidth', 2);
h2 = plot(nan, nan, '--', 'Color', red_color, 'LineWidth', 2);
h3 = plot(nan, nan, 'o',  'Color', yellow_color, 'MarkerSize', 8);
h4 = plot(nan, nan, '^',  'Color', red_color, 'MarkerSize', 8);

legend([h1 h2 h3 h4], ...
    {'RSMA–OP: Simulation', ...
     'NOMA–OP: Simulation', ...
     'RSMA–OP: Numericals', ...
     'NOMA–OP: Numericals'}, ...
    'Location', 'best', 'Interpreter', 'latex');
