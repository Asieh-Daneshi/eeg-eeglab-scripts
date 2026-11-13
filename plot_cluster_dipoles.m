% Plot the dipole map of one component cluster of an EEGLAB STUDY. Requires EEGLAB.
study_file = 'my.study';          % set these three
study_path = pwd;
cluster_id = 2;

[STUDY, ALLEEG] = pop_loadstudy('filename', study_file, 'filepath', study_path);
CURRENTSTUDY = 1; EEG = ALLEEG; CURRENTSET = 1:length(EEG);

% [STUDY] = pop_clust(STUDY, ALLEEG, 'algorithm', 'kmeanscluster', 'clus_num', 8);  % cluster first, if needed
figure;
STUDY = std_dipplot(STUDY, ALLEEG, 'clusters', cluster_id);   % dipole map of the cluster
% STUDY = std_topoplot(STUDY, ALLEEG, 'clusters', cluster_id, 'plotsubjects', 'on');  % topographic maps
% Viewing angle that shows the dipoles well: [.5 -.6 .3]
