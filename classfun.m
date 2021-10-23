function [mean_success,sd_success,labels] = classfun(features,labels_idx,k)
% this function  train a classifier on part of the data and then test its
%performance on the rest of the data. the function Use K-fold cross-validation
%to measure the classifier performance

n_trails = size(features,2); %sets number of trails.
labels = zeros(length(features),1);
labels(labels_idx{1}) = 1; %create labels vector that fits to trails order. left=1, right=0

class_data = [features' labels]; % connect each trails features to the appropriate label.

random_class_data = class_data(randperm(size(class_data, 1)), :); %randomize trails order.
rand_labels = random_class_data(:,end);

%this variable will keep the accuracy measure of the classicication
%in each one of the k repetition. first row- accuracy in train.
%second row- accuracy in validation.
group_size = n_trails/k;
success_per_fold= zeros(2,k);


for i = 1:k
%sets the index of the current validation trails.
    test_idx = [(((i-1)*group_size+1):(group_size)*i)];
% save the features of the validation trails.
    test_group = random_class_data(test_idx,(1:end-1));

%sets the index of the current train trails.
    train_idx = setxor(1:length(class_data),test_idx); 
% save the features of the train trails.
    train_group = random_class_data(train_idx,(1:end-1));
    %use of classify function to predict the condition of the validation
    %trails(left\right).
    [class,err] = classify(test_group,train_group, rand_labels(train_idx));

   %1-err represents the accuracy of the predictions in the train group.
    success_per_fold(1,i) = 1-err;
%calculate the number of correct predictions in the validation group.
    test_success = sum(class == rand_labels(test_idx)); 
%represents the accuracy of the predictions in the train group.
    test_success = test_success/length(test_group);
    success_per_fold(2,i) = test_success;
end

%calculate the mean & SD prediction accuracy of the k repetition (in train & validation).
mean_success = mean(success_per_fold,2);
sd_success= std(success_per_fold,1,2);


end

