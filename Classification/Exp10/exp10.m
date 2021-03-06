train_in = csvread('./../Data/class_train_in.csv',1,1);
test_in = csvread('./../Data/class_test_in.csv',1,1);
train_out = csvread('./../Data/class_train_out.csv',1,1);
train_out = (train_out - 0.5) * 2;
N = size(train_in,1);

%PCA
[W, lambda] = eig(cov(train_in));
lambda = diag(lambda);
Xtrain = train_in * W(:,259:end);
Xtest = test_in * W(:,259:end);
reducedD = size(Xtrain,2);
Ytrain = train_out;

reduce_pc = zeros(size(Xtrain,1),size(Xtrain,2)+1);
reduce_pc(:,1:7) = Xtrain(:,:);
for i = 1:size(Xtrain,1),
    reduce_pc(i,size(Xtrain,2)+1) = Ytrain(i);
end

csvwrite('pca_reduced.csv',reduce_pc);

reduce_pc = zeros(size(Xtest,1),size(Xtest,2)+1);
reduce_pc(:,1:7) = Xtest(:,:);
for i = 1:size(Xtest,1),
    reduce_pc(i,size(Xtest,2)+1) = 1;
end

csvwrite('pca_test.csv',reduce_pc);

% % for i = 1:length(yte_mu)
% %     fprintf(fid, '%u,%f\n', i, abs(yte_mu(i)));
% % end
% 
% addpath(genpath('./RF/lib/'))
% 
% opts= struct;
% opts.depth= 10;
% opts.numTrees= 200;
% opts.numSplits= 4;
% opts.verbose= true;P3
% opts.classifierID= [2,3]; % weak learners to use. Can be an array for mix of weak learners too
% 
% tic;
% m= forestTrain(Xtrain, Ytrain, opts);
% timetrain= toc;
% tic;
% 
% [yhat, ysoft] = forestTest(m, Xtest);
% timetest= toc;
% 
% % fid = fopen('prob.csv', 'w');
% % fprintf(fid, 'Point_ID,Output\n');
% % for i = 1:length(yte_mu)
% %     fprintf(fid, '%u,%f\n', i, abs(yte_mu(i)));
% % end
