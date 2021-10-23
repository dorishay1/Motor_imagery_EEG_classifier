function [] = plot_EEG(rand_cell,t_vec,names)
%this function takes the cell that contains the 20 random trails from each side
%for each electrode and using the time vector and the names cell produce 2
%plots - one for each label. each plot contains the data from 20 random trails
%from both electrodes.

colors = {'r','b'};
titles = names(2,:);
for label = 1:size(rand_cell,2)
    fig = figure;
    sgtitle(['EEG signals for ',titles{label}, ' hand imagery'],'FontSize', 16)
    
    for elec = 1:size(rand_cell,1)
        current_data = rand_cell{elec,label};
        for trail = 1:size(current_data,1)
            subplot(4,5,trail)
            plot(t_vec,current_data(trail,:),colors{elec})
            ylim ([-20 20])
            ax = gca;
            ax.FontSize = 11;
            hold on
        end
        legend({'C3','C4'})
        
        
    end
    a = axes(fig,'visible','off');
    a.XLabel.Visible='on';
    a.YLabel.Visible='on';
    ylabel(a,'voltage [\muV]');
    xlabel(a,'time [sec]');
    a.FontSize = 14;
    
    
    
    
end

