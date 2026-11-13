% Plot the spectra of the components of one cluster of an EEGLAB STUDY, then redraw
% every component in grey and the mean in red. Requires EEGLAB.
clear
clc

study_file = 'my.study';          % set these three
study_path = pwd;
cluster_id = 2;

[ALLEEG, EEG, CURRENTSET, ALLCOM] = eeglab;
[STUDY, ALLEEG] = pop_loadstudy('filename', study_file, 'filepath', study_path);
CURRENTSTUDY = 1; EEG = ALLEEG; CURRENTSET = 1:length(EEG);
CURRENTSTUDY = 0;
[ALLEEG, EEG, CURRENTSET] = pop_newset(ALLEEG, EEG, 1:length(EEG), 'retrieve', 1, 'study', 1);
[ALLEEG, EEG, CURRENTSET] = pop_newset(ALLEEG, EEG, 1, 'retrieve', 1:length(EEG), 'study', 1);
CURRENTSTUDY = 1;

%% spectra of all components of the cluster
STUDY = std_specplot(STUDY, ALLEEG, 'clusters', cluster_id, 'comps', 'all');

%% extract the data from the figure
h = gcf;
axesObjs = get(h, 'Children');
dataObjs = get(axesObjs, 'Children');
ydata = get(dataObjs, 'YData');

%% redraw
figure; set(gca, 'fontsize', 30, 'FontWeight', 'bold'); hold on
final_data = [];
for n = 1:size(ydata, 1)
    plot(ydata{n, 1}, 'color', [.5 .5 .5], 'linewidth', 1);
    final_data(n, :) = ydata{n, 1}; %#ok<AGROW>
end
plot(mean(final_data), 'color', [1 0 0], 'linewidth', 4);
box off
xlim([1 50])
ylim([0 70])
yticks(0:10:70)
title('')
grid on
xlabel('Frequency (Hz)', 'fontsize', 30, 'FontWeight', 'bold')
ylabel('Amplitude (dB)', 'fontsize', 30, 'FontWeight', 'bold')
