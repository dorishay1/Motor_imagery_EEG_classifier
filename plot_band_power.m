function [] = plot_band_power(band_power_cell,names,hist_range,BinWidth)
%this function plots the bandpowers from bandpower cell in histograms according
%to histogram settings.

figure
for elec = 1:size(band_power_cell,1)
    nexttile
    for label = 1:size(band_power_cell,2)
        title (names(1,elec));
        a = histogram(band_power_cell{elec,label},hist_range);
        a.BinWidth = BinWidth;
        ax = gca;
        ax.FontSize = 11;
        hold on
    end
    legend(names(2,:))
    xlabel('Energy','FontSize',14)
    ylabel('number of trails','FontSize',14)
    
end

