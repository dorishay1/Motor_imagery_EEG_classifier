% Final Project - Ex 6


%% Data handling
clear; close all; clc;

load motor_imagery_train_data.mat
%setting relevant frequancy and resulotion.
f = 1:0.1:40;

%data proccessing - sorting the relavent info from the raw data.
%electrode_cell - 1-C3, 2-C4. labels_idx - 1-left,2-right. t_samples - number of
%time samples. n_trails - number of trails (more details inside function).
[electrode_cell, labels_idx, fs, t_samples,n_trails,names] = data_proc(P_C_S);

%time calculation that will be needed next(more details inside function).
%t_vec - time in seconds in each time sample.
%trail_time - total trail time
[t_vec, trail_time] = time_calc(t_samples,fs);

%% 20 random samples EEG by side and electrode
%setting the number of random trails that will be ploted.
n_rand = 20;
%rand_cell contains the data from 20 random trails sorted by electrode and
%label.rows - C3,C4, col- left,right.(more info inside function).
rand_cell = rand_trails(electrode_cell,labels_idx,n_rand);
plot_EEG(rand_cell,t_vec,names)

%% power spectrum by side and electrode
p_window = 1.5*fs;               %duration of time windows [sec].
p_overlap = p_window/2;          %overlap between windows [sec]/[as part of window].
img_t_frame = 2.5*fs:t_samples;  %relavent time window for power spectrum.

plot_power_label(electrode_cell,labels_idx,f,fs,p_window,p_overlap,img_t_frame,names)

%% spectugram - each electrode & side + delta (3 figures)
s_window = .5*fs;               %t = time, length of time windows [sec]
s_overlap = s_window/2;         %overlap between windows [sec]/[as part of window]

plot_spectu(electrode_cell,labels_idx,f,fs,s_window,s_overlap,t_vec,names);

%% band power
%each row in this vectors represents a diffrent area to explore.
freq_range = [15 18;30 35; 22 27;15 20];
time_frame = [4.5 6; 5 6; 2 3;2 3];

%histogram settings
hist_range = [0 20];
BinWidth = .25;

for i = 1:size(freq_range,1)
    band_power_cell = band_power_calc(electrode_cell,labels_idx,freq_range(i,:),time_frame(i,:),fs);
    plot_band_power(band_power_cell,names,hist_range,BinWidth)
    sgtitle(['band power between ', mat2str(freq_range(i,1)),' - ',mat2str(freq_range(i,2)),...
        ' Hz ','in time between ',mat2str(time_frame(i,1)),'-',mat2str(time_frame(i,2)),' seconds'])
end

%% classification
features = classification(electrode_cell,fs,f);

%% PCA
plot_pca(features,labels_idx,names)

%% Classify
k = 8;
[mean_success, sd_success,labels] = classfun(features,labels_idx,k);
%% test
load motor_imagery_test_data.mat
test_trails_cells = {data(:,:,1) data(:,:,2)};
test_features = classification(test_trails_cells,fs,f);

[class, err] = classify(test_features',features',labels);
