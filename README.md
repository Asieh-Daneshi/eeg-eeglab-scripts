# EEG scripts for EEGLAB

Small MATLAB scripts I used in EEG studies, cleaned up so that no data, subject names or local paths remain. They need [EEGLAB](https://sccn.ucsd.edu/eeglab/) on the MATLAB path. No data are included.

| Script | What it does |
|---|---|
| `resample_and_ica.m` | For every `*_filt.set` file in the current folder: resamples to 512 Hz, runs extended Infomax ICA and saves `_resampled.set` and `_ICA.set` files. |
| `plot_cluster_spectra.m` | Loads an EEGLAB STUDY, plots the spectra of the components of one cluster, and redraws them as grey single-component curves with the mean in red. |
| `plot_cluster_dipoles.m` | Loads an EEGLAB STUDY and plots the dipole map of one component cluster. |

Both plotting scripts were generated from EEGLAB's history (`eegh`) and then edited. Set the study file, folder and cluster number at the top.

## Notes on ICA

If the data were re-referenced to the average, they have one fewer independent signal than channels. Reduce the number of components to the rank of the data (EEGLAB's `pop_runica` accepts `'pca', rank`), otherwise the artifact components are separated worse. A small simulation of this is in [imaging-signal-pitfalls, experiment 22](https://github.com/Asieh-Daneshi/imaging-signal-pitfalls/tree/main/22_ica_rank).
