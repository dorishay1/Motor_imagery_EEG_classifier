function [features] = classification(data,fs,f)
%this function takes the data (train/test) and using f and fs calculates the
%features for the data in 'features'. each editional feature saved as
%'new_feature' and then added as a new row at the end of the matrix 'features'.
%the index of data sets the specific electrode. we did not use here a loop or
%complex indexing in order to be able to check features easily and seperatly for
%each electrode.

n_trails = size(data{1},1);         %number of trails

features = [];                      %creating/reseting memory

%(1-2)band power 1
freq_range = [15 18];
time_frame = [4.5 6];

new_feature = bandpower((data{1}(:,(time_frame(1)*fs):(time_frame(2)*fs)))',fs,freq_range);
features = [features ; new_feature];


new_feature = bandpower((data{2}(:,(time_frame(1)*fs):(time_frame(2)*fs)))',fs,freq_range);
features = [features ; new_feature];

%(3-4)band power 2
freq_range = [30 35];
time_frame = [5 6];


new_feature = bandpower((data{1}(:,(time_frame(1)*fs):(time_frame(2)*fs)))',fs,freq_range);
features = [features ; new_feature];

new_feature = bandpower((data{2}(:,(time_frame(1)*fs):(time_frame(2)*fs)))',fs,freq_range);
features = [features ; new_feature];


%(5-10)
p_window = 1.5*fs;               %t = time, length of time windows [sec]
p_overlap = p_window/2;         %overlap between windows [sec]/[as part of window]

%frequancy bands
f_resulotion = 0.1;             %frequancy vector resulution [Hz].
%this 2 vectors can be modified. each index in the name vectors is connected
%later with the same range index. more info inside 'freq_band'.
Bands_Name = ["delta" , "theta" , "low_alpha", "high_alpha", "beta", "gamma"];
Bands_range = [ 1, 4.5;  4.5,8;   8, 11.5;   11.5, 15;  15,30 ;  30, 40];

[freq_map] = freq_band(Bands_Name,Bands_range,f_resulotion);
[y,~] = pwelch(data{1}',p_window,p_overlap,f,fs);

new_feature = relative_power(y,freq_map,n_trails);
features = [features ; new_feature];

[y,~] = pwelch(data{2}',p_window,p_overlap,f,fs);
new_feature = relative_power(y,freq_map,n_trails);
features = [features ; new_feature];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%simultaion for more features
% powerC3 = pwelch(data{1}',1.5*fs,0.75*fs,f,fs);
% powerC4 = pwelch(data{2}',1.5*fs,0.75*fs,f,fs);
% 
% 
% new_feature = root_total_power(powerC3);
% features = [features ; new_feature];
% 
% new_feature = root_total_power(powerC4);
% features = [features ; new_feature];
% 
% 
% new_feature = SSI(powerC3,f);
% features = [features ; new_feature];
% 
% new_feature = SSI(powerC4,f);
% features = [features ; new_feature];
% 
% norm_power = normalize_power(powerC3);
% new_feature = spectral_entropy(norm_power);
% features = [features ; new_feature];
% 
% norm_power = normalize_power(powerC4);
% new_feature = spectral_entropy(norm_power);
% features = [features ; new_feature];


end
