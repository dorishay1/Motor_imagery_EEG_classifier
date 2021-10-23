function [electrode_cell,labels_idx,fs,t_samples,n_trails,names] = data_proc(data_struc)
%this function takes the raw data from the EEG and converts it to cells that
%will be more easily used in the analayse.

%taking only the first two relveant electrodes (C3 & C4)
C3 = data_struc.data(:,:,1);
C4 = data_struc.data(:,:,2);

%extracting the labels for all trails
labels = data_struc.attribute;

left = find(labels (3,:)==1);
right = find(labels (4,:)==1);

%sorting the data together in cells.
electrode_cell = {C3 C4};
labels_idx = {left right};
names = {'C3' 'C4';'Left','Right'};


%extra information
fs = data_struc.samplingfrequency;
t_samples = length(C3);
n_trails = size(data_struc.data,1);
end

