% Resample every *_filt.set file in the current folder to 512 Hz, run extended ICA
% and save the results. Requires EEGLAB.
clear
clc
current_folder = pwd;
files = dir(fullfile(current_folder, '*.set'));
files = sort({files.name});
%--------------------------------------------------------------------------
eeglab;

for subject = 1:length(files)
    filename = files(subject);
    [ALLEEG, EEG, CURRENTSET, ALLCOM] = eeglab;
    EEG = pop_loadset('filename', filename, 'filepath', pwd);
    [ALLEEG, EEG, CURRENTSET] = eeg_store(ALLEEG, EEG, 0);
    EEG = eeg_checkset(EEG);

    % resample
    EEG = pop_resample(EEG, 512);
    filename_resampled = strcat(erase(filename, '_filt.set'), '_resampled.set');
    [ALLEEG, EEG, CURRENTSET] = pop_newset(ALLEEG, EEG, 1, 'savenew', filename_resampled{1}, 'gui', 'off');

    % ICA (if the data were average-referenced, pass 'pca', rank to pop_runica)
    EEG = pop_runica(EEG, 'extended', 1, 'interupt', 'on');
    [ALLEEG, EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
    EEG = eeg_checkset(EEG);
    filename_ICA = strcat(erase(filename, '_filt.set'), '_ICA.set');
    EEG = pop_saveset(EEG, 'filename', filename_ICA{1}, 'filepath', pwd);
    [ALLEEG, EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
end
