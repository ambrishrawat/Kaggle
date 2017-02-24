train_in = csvread('./../Data/class_train_in.csv',1,1);
test_in = csvread('./../Data/class_test_in.csv',1,1);
train_out = csvread('./../Data/class_train_out.csv',1,1);
train_out = (train_out - 0.5) * 2;
N = size(train_in,1);

addpath(genpath('./gpml'))

%PCA
[W, lambda] = eig(cov(train_in));
lambda = diag(lambda);
Xtrain_in = train_in * W(:,149:end);
Xtest_in = test_in * W(:,149:end);
reducedD = size(Xtrain_in,2);


%GP
mnf = @meanConst; hyp0.mean = 0;
cvf = @covRQard; hyp0.cov = log([10*ones(1,reducedD) 1 1]);
lkf = @likErf;

Xtr = Xtrain_in;
ytr = train_out;
Xte = Xtest_in;


idx_init = randperm(size(Xtr,1), floor(0.25 * size(Xtr,1)));
[hyp, fX1, ~] = minimize(hyp0, @gp, -150, @infEP, mnf, cvf, lkf, Xtr(idx_init,:), ytr(idx_init));
[hyp, fX2, ~] = minimize(hyp, @gp, -100, @infEP, mnf, cvf, lkf, Xtr, ytr);
[ytr_mu, ytr_s2] = gp(hyp, @infEP, mnf, cvf, lkf, Xtr, ytr, Xtr);
[yte_mu, yte_s2] = gp(hyp, @infEP, mnf, cvf, lkf, Xtr, ytr, Xte);

fid = fopen('prob.csv', 'w');
fprintf(fid, 'Point_ID,Output\n');
for i = 1:length(yte_mu)
    fprintf(fid, '%u,%f\n', i, yte_mu(i));
end
