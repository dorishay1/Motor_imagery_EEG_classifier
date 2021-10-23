function [] = plot_spectu(electrode_cell,labels_idx,f,fs,s_window,s_overlap,t_vec,names)
%this function takes the data from the EEG and the labels and with the relavent
%setting claculates the power for each electrode and label using spectogram.
%later,different calculates and plots are made in order to compare the
%conditions more easily.

%% calculations

memory = cell(length(electrode_cell),length(labels_idx));

%for each electrode according to the label, data will be transform into power
%using the function spectogram and other transformations.
for elec = 1:length(electrode_cell)
    for label = 1:length(labels_idx)
        current_data = electrode_cell{elec}(labels_idx{label},:);
        
        %cum_spec- cummulative spectogram. we use this variable in order to sum all the
        %spectograms and then in the end to calculate average spectrogram.
        cum_spec = 0;
        for trail = 1:size(current_data,1)
            spec_trail = spectrogram(current_data(trail,:),s_window,s_overlap,f,fs,'yaxis');
            spec_trail = 10*log(abs(spec_trail).^2);
            cum_spec = cum_spec+spec_trail;
        end
        
        mean_spec = cum_spec*(1/size(current_data,1));
        memory{elec,label} = mean_spec;
        
    end
end

%% delta calculations
%here we make some extra calculations in order to produce more informative
%spectograms. we calculate the differences between labels within each electrode
%and the differences between electrodes within each label.

delta_labels = cell(1,length(labels_idx));
for label = 1:length(labels_idx)
    delta_labels{label} = memory{2,label}-memory{1,label};
end

delta_elec = cell(1,length(electrode_cell));
for elec = 1:length(electrode_cell)
    delta_elec{elec} = memory{elec,1}-memory{elec,2};
end
%% plots

figure;
for elec = 1:size(memory,1)
    for label = 1:size(memory,2)
        current_spec = memory{elec,label};
        nexttile
        imagesc(t_vec,f,current_spec)
        set(gca,'YDir','normal')
        title([names(1,elec) names(2,label)])
        xlabel ('time [sec]','FontSize',14)
        ylabel ('frequancy [Hz]','FontSize',14)
        
    end
    cb = colorbar;
    cb.Label.String = 'Power/Frequency [dB/Hz]';
    cb.Label.FontSize = 14;
    ax = gca;
    ax.FontSize = 11;
    
end
sgtitle('Spectugrams by electrode & label','FontSize',16)

figure

for d = 1:length(delta_labels)
    current_spec = delta_labels{d};
    
    nexttile
    imagesc(t_vec,f,current_spec)
    set(gca,'YDir','normal')
    title([names(2,d)])
    xlabel ('time [sec]','FontSize',14)
    ylabel ('frequancy [Hz]','FontSize',14)
    ax = gca;
    ax.FontSize = 11;
    cb = colorbar;
    cb.Label.String = 'Power/Frequency [dB/Hz]';
    cb.Label.FontSize = 14;
    
end
sgtitle('Differences Spectugrams by label','FontSize',16)


figure

for d = 1:length(delta_elec)
    current_spec = delta_elec{d};
    
    nexttile
    imagesc(t_vec,f,current_spec)
    set(gca,'YDir','normal')
    title([names(1,d)])
    xlabel ('time [sec]','FontSize',14)
    ylabel ('frequancy [Hz]','FontSize',14)
    ax = gca;
    ax.FontSize = 11;
    cb = colorbar;
    cb.Label.String = 'Power/Frequency [dB/Hz]';
    cb.Label.FontSize = 14;
    
end
sgtitle('Differences Spectugrams by electrode','FontSize',16)

end

