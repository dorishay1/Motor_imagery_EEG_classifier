function [] = plot_pca(features,labels_idx,names)
%this function calculate PCA for features matrix and plots 2 and 3 dim scatter
%plots for them.

features = zscore(features,0,2);

pca1 = pca(features);
colors = {'r','b'};
figure
for i = 1:length(labels_idx)
    scatter(pca1(labels_idx{i},1),pca1(labels_idx{i},2),15, colors{i}, 'filled')
    hold on
end
legend(names(2,:),'FontSize',12)
xlabel ('PCA 1')
ylabel ('PCA 2')
title('2-D  PCA','FontSize',16)

figure
for i = 1:length(labels_idx)
    scatter3(pca1(labels_idx{i},1),pca1(labels_idx{i},2),pca1(labels_idx{i},3),15,colors{i},'filled')
    hold on
end
legend(names(2,:),'FontSize',12)
xlabel ('PCA 1')
ylabel ('PCA 2')
zlabel ('PCA 3')
title('3-D  PCA','FontSize',16)

end

