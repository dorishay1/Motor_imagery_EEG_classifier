function [memory] = rand_trails(electrode_cell,labels_idx,n_rand)
%this function takes the data from all electrodes, the index of each label
%and the number of wanted random trails and preduce one cell with all the data.
%each row stands for a different electrode and the colums for each label.

%preapering memory
memory = cell(length(electrode_cell),length(labels_idx));

%the loop takes the data from both electrodes from 20 random trails from each
%label and sort it in memory.
for label = 1:length(labels_idx)
    n_label_trails = length(labels_idx{label});   %number of trails per side
    idx_rand = randperm(n_label_trails,n_rand);   %20 random trails
    for elec = 1:length(electrode_cell)
        
        %this method repeats in the code- we want to extract the trails only from one
        %label from one electrode - so we use the index of the labels and take with them
        %only the relavent trails from the selected electrode.
        trails_by_label = electrode_cell{elec}(labels_idx{label},:);
        memory{elec,label} = trails_by_label(idx_rand,:);
    end
    
    
    
end

