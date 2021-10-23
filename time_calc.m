function [t_vec, trail_time] = time_calc(t_samples,fs)
%this function claculates diffrent time parametrs using the time samples vector
%and the frequancy sample.

trail_time = t_samples/fs;
t_vec = [0:(trail_time/(t_samples-1)):trail_time];

end

