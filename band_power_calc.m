function [band_power_cell] = band_power_calc(electrode_cell,labels_idx,freq_range,time_frame,fs)
%this function takes the data from the electrodes and calculate the band power
%according to specific range (time and frequancy). the output is a cell with all
%the calculations according to electrdoe and label.

time_idx = time_frame*fs;
%% calculations
memory = cell(length(electrode_cell),length(labels_idx));
for elec = 1:length(electrode_cell)
    for label = 1:length(labels_idx)
                current_data = electrode_cell{elec}(labels_idx{label},(time_idx(1):time_idx(2)));
                memory{elec,label} = bandpower(current_data',fs,freq_range);
    end
end
                
band_power_cell = memory;
end

