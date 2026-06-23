%%
clc;
clear;
close all;

%% ================= X-axis =================
n = 0:2:40;

%% ================= DATA =================
% RSMA WITH EMI
y19 = [1 0.120759 0.031657 0.019571 0.014205 0.011718 0.01003 0.008782 ...
       0.00795 0.007278 0.006786 0.00652 0.006094 0.005728 0.005597 ...
       0.005322 0.005269 0.005041 0.004856 0.004741 0.004668];

y23 = [1 0.169732 0.031746 0.016462 0.010835 0.007729 0.006089 0.004875 ...
       0.004228 0.003561 0.003147 0.002961 0.002706 0.002521 0.002438 ...
       0.002218 0.002149 0.002025 0.002076 0.001913 0.00181];

y27 = [1 0.012952 0.000682 0.000309 0.00022 0.000158 0.000143 0.000112 ...
       0.000119 9.3e-05 0.000102 7.2e-05 8.4e-05 8.2e-05 5.7e-05 ...
       7e-05 5.8e-05 5.2e-05 6.4e-05 4.7e-05 5.3e-05];

y31 = [1 0.02804 0.004104 0.00242 0.001615 0.001271 0.001056 0.00089 ...
       0.000831 0.000795 0.00073 0.000658 0.000591 0.000562 0.000565 ...
       0.0005 0.000476 0.00049 0.000462 0.000464 0.000439];

% NOMA WITH EMI
y4  = [1 0.999902 0.981167 0.904289 0.795221 0.686506 0.590018 0.507714 ...
       0.440057 0.383707 0.33627 0.2977 0.263962 0.236638 0.212369 ...
       0.192373 0.174726 0.159081 0.14585 0.133706 0.123682];

y8  = [1 0.999913 0.983128 0.912423 0.809777 0.703666 0.608964 0.526557 ...
       0.458075 0.400969 0.353282 0.313168 0.278567 0.251129 0.225149 ...
       0.203495 0.184938 0.168494 0.155026 0.14199 0.131689];

y12 = [1 0.980533 0.790806 0.581715 0.43194 0.32754 0.256016 0.205992 ...
       0.167593 0.139434 0.11706 0.101417 0.086994 0.076562 0.067095 ...
       0.059745 0.053318 0.047971 0.043362 0.039252 0.035754];

y16 = [1 0.980761 0.790891 0.583606 0.432749 0.329474 0.257964 0.206894 ...
       0.168689 0.141144 0.119388 0.102101 0.0884 0.077054 0.068533 ...
       0.06082 0.053868 0.048594 0.044001 0.040146 0.036341];

%% ================= SMOOTHING =================
span = 0.25;   % LOWESS smoothing factor (safe)

y19_s = smooth(y19, span, 'lowess');
y23_s = smooth(y23, span, 'lowess');
y27_s = smooth(y27, span, 'lowess');
y31_s = smooth(y31, span, 'lowess');

y4_s  = smooth(y4,  span, 'lowess');
y8_s  = smooth(y8,  span, 'lowess');
y12_s = smooth(y12, span, 'lowess');
y16_s = smooth(y16, span, 'lowess');

%% ================= MARKER POSITIONS =================
markX = 0:10:40;
[~, markIdx] = ismember(markX, n);
markIdx(markIdx == 0) = [];

%% ================= COLORS =================
blue_color = [0 0.4470 0.7410];      % RSMA (IEEE blue)
red_color  = [0.8500 0.3250 0.0980]; % NOMA

%% ================= PLOT =================
figure; hold on; box on; grid on;

% ---- RSMA (BLUE) ----
semilogy(n, y19_s, '-o', 'Color', blue_color, 'LineWidth', 1.2, ...
    'MarkerIndices', markIdx, 'MarkerSize', 5, 'MarkerEdgeColor', 'k');
semilogy(n, y23_s, '-s', 'Color', blue_color, 'LineWidth', 1.2, ...
    'MarkerIndices', markIdx, 'MarkerSize', 6, 'MarkerEdgeColor', 'k');
semilogy(n, y27_s, '-h', 'Color', blue_color, 'LineWidth', 1.2, ...
    'MarkerIndices', markIdx, 'MarkerSize', 5, 'MarkerEdgeColor', 'k');
semilogy(n, y31_s, '-^', 'Color', blue_color, 'LineWidth', 1.2, ...
    'MarkerIndices', markIdx, 'MarkerSize', 5, 'MarkerEdgeColor', 'k');

% ---- NOMA (RED) ----
semilogy(n, y4_s,  '-.s', 'Color', red_color, 'LineWidth', 1.2, ...
    'MarkerIndices', markIdx, 'MarkerSize', 8, 'MarkerEdgeColor', 'k');
semilogy(n, y8_s,  '-.o', 'Color', red_color, 'LineWidth', 1.2, ...
    'MarkerIndices', markIdx, 'MarkerSize', 5, 'MarkerEdgeColor', 'k');
semilogy(n, y12_s, '-.^', 'Color', red_color, 'LineWidth', 1.2, ...
    'MarkerIndices', markIdx, 'MarkerSize', 5, 'MarkerEdgeColor', 'k');
semilogy(n, y16_s, '-.h', 'Color', red_color, 'LineWidth', 1.2, ...
    'MarkerIndices', markIdx, 'MarkerSize', 5, 'MarkerEdgeColor', 'k');

%% ================= AXES =================
xlabel('Transmit Power (dBm)', 'Interpreter', 'latex');
ylabel('Outage Probability', 'Interpreter', 'latex');

xlim([0 40]);
xticks(0:5:40);
ylim([1e-5 1]);
set(gca, 'YScale', 'log', 'FontSize', 12);

%% ================= LEGEND =================
h1 = semilogy(nan, nan, '--', 'Color', red_color,  'LineWidth', 1.2);
h2 = semilogy(nan, nan, '-',  'Color', blue_color, 'LineWidth', 1.2);
h3 = semilogy(nan, nan, 'ok', 'MarkerSize', 8);
h4 = semilogy(nan, nan, 'sk', 'MarkerSize', 8);
h5 = semilogy(nan, nan, '^k', 'MarkerSize', 8);
h6 = semilogy(nan, nan, 'hk', 'MarkerSize', 8);

legend([h1 h2 h3 h4 h5 h6], ...
    {'NOMA', 'RSMA', ...
     'With EMI: N = 64', 'With EMI: N = 100', ...
     'Without EMI: N = 64', 'Without EMI: N = 100'}, ...
    'Location', 'best');
