function [] = plot_power_label(electrode_cell,labels_idx,f,fs,t_window,t_overlap,img_t_frame,names)
%this function takes the data from the EEG, the labels and all the relavent
%setting for pwelch and returns plots for each electrode with the power
%accordint to the label.

colors = {'r','b'};
titles = names(1,:);

%for each electrode the loop will make a new figure with power spectrum
%according to the label.
for elect = 1:size(electrode_cell,2)
    figure
        sgtitle(['Power spectrum from ',titles{elect},' electrode'])
        for label = 1:size(electrode_cell,2)
            current_data = electrode_cell{elect}(labels_idx{label},img_t_frame);
            [y,x] = pwelch(current_data',t_window,t_overlap,f,fs);
            y = 10*log(mean(y,2));
            plot(x,y,colors{label})
            ax = gca;
            ax.FontSize = 11;
            hold on
        end
        xlabel ('Frequency [Hz]','FontSize',14)
        ylabel ('Power [dB]','FontSize',14)
        legend(names(2,:),'FontSize',14)
            

end

