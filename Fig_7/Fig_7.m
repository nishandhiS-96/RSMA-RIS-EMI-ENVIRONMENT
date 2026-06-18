clc;
clear all;
close all;

% Select only specific NumOfElements
NumOfElements_all = 10:5:50;
selected_elements = [10 20 30 40 50];
[~, idx] = ismember(selected_elements, NumOfElements_all);
NumOfElements = selected_elements;

% Load the saved data
load('mean_1.mat');         % Contains meanSNR and NumOfElements
load('mean_2.mat');   % Contains meanSNR_noEMI
load('mean_3.mat');   % Contains meanSNR_noRIS
load('beta_direct.mat');   % Contains vector_betaHd

fig3 = figure;
for index = 2:numel(vector_betaHd)
    hold on; box on; grid on;

    % w/o EMI - Blue dashed line with 'o' marker
    semilogy(NumOfElements, smooth(meanSNR_noEMI(index, idx), 3), ...
        'ok-', 'Color', [0 0.45 0.74], 'LineWidth', 1.3);  % Blue

    % w/ EMI - Red-orange dashed line with 'd' marker
    semilogy(NumOfElements, smooth(meanSNR(index, idx), 3), ...
        'dr-.', 'Color', [0.85 0.33 0.10], 'LineWidth', 1.3);  % Reddish-orange

    % % w/o RIS - Golden-yellow dotted line with 'h' marker
    % semilogy(NumOfElements, ones(1, numel(NumOfElements)) * meanSNR_noRIS(index, 1), ...
    %     'hb:', 'Color', [0.93 0.69 0.13], 'LineWidth', 1.2);  % Golden-yellow
    % -------- w/o RIS (BLACK) --------
semilogy(NumOfElements, ...
    ones(1, numel(NumOfElements)) * meanSNR_noRIS(index, 1), ...
    'h-', 'Color', 'k', ...
    'LineWidth', 1.3, 'MarkerSize', 6);

end

set(gca, 'fontsize', 12, 'Yscale', 'log');
set(gca, 'XTick', 10:5:50);
xlabel('Number of elements (per dimension)', 'Interpreter', 'latex');
ylabel('Average SINR', 'Interpreter', 'latex');
legend({'w/o EMI','w/ EMI','w/o RIS'}, 'Interpreter', 'latex', 'Location', 'Best');
xlim([10 50]);
% ylim([2500 5500]);
% fig3.Position(3:4) = [550 350];

set(gca, 'FontSize', 12, 'YScale', 'log');
ylim([2.5e3 5.5e3]);




