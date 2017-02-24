%number of samples
numsample = 5000;

%the input file
close all;
m = csvread('./../Data/data.csv', 1, 1);

close all;
a = figure;
% pd = fitdist(m(:,2),'BirnbaumSaunders');
% r = random(pd,1,numsample);

moments = {mean(m(:,2)),std(m(:,2)),skewness(m(:,2)),kurtosis(m(:,2))};
rng default  % For reproducibility
[r,type] = pearsrnd(moments{:},1,numsample);


qqplot(m(:,2),r(1,:))
title('Pearson')
saveas(a,'Pearson','jpg')

[r,~] = johnsrnd(quantile(m(:,2),4),1,numsample);
qqplot(m(:,2),r(1,:))
title('Johnson')
saveas(a,'Johnson','jpg')


% qqplot(m(:,2),normrnd(mean(m(:,2)),std(m(:,2)),1,5000));
% 
% %dists = ['ExtremeValue';'GeneralizedExtremeValue';'Logistic';'Normal';'Rayleigh';'tLocationScale'];
% close all;
% a = figure;
% pd = fitdist(m(:,2),'ExtremeValue');
% r = random(pd,1,numsample);
% qqplot(m(:,2),r(1,:))
% title('Exponential')
% saveas(a,'Exponential','jpg')
% a = figure;
% pd = fitdist(m(:,2),'GeneralizedExtremeValue');
% r = random(pd,1,numsample);
% qqplot(m(:,2),r(1,:))
% title('GeneralizedExtremeValue')
% saveas(a,'GeneralizedExtremeValue','jpg')
% a = figure;
% pd = fitdist(m(:,2),'Logistic');
% r = random(pd,1,numsample);
% qqplot(m(:,2),r(1,:))
% title('Logistic')
% saveas(a,'Logistic','jpg')
% a = figure;
% pd = fitdist(m(:,2),'Normal');
% r = random(pd,1,numsample);
% qqplot(m(:,2),r(1,:))
% title('Normal')
% saveas(a,'Normal','jpg')
% figure;
% pd = fitdist(m(:,2),'Rayleigh');
% r = random(pd,1,numsample);
% qqplot(m(:,2),r(1,:))
% title('Rayleigh')
% figure;
% pd = fitdist(m(:,2),'tLocationScale');
% r = random(pd,1,numsample);
% qqplot(m(:,2),r(1,:))
% title('tLocationScale')
% figure;
% pd = fitdist(m(:,2),'Kernel','Kernel','epanechnikov');
% r = random(pd,1,numsample);
% qqplot(m(:,2),r(1,:))
% title('Kernel-epanechnikov')
% figure;
% pd = fitdist(max(m(:,2))-m(:,2),'Lognormal');
% r = random(pd,1,numsample);
% qqplot(max(m(:,2))-m(:,2),r(1,:))
% title('Lognormal')
%dists = ['Beta';'Binomial';'BirnbaumSaunders';'Burr';'Exponential';'ExtremeValue';'Gamma'];
%dists = ['Beta','Binomial','BirnbaumSaunders','Burr'	,'Exponential','ExtremeValue','Gamma','GeneralizedExtremeValue','GeneralizedPareto','InverseGaussian','Logistic','Loglogistic','Lognormal','Multinomial','Nakagami','NegativeBinomial','Normal','PiecewiseLinear','Poisson','Rayleigh','Rician','tLocationScale','Triangular','Uniform','Weibull'];
%plot(x4,x1,'.')
%hist(x4)
%headerRow = ['x_1','x_2','x_3','x_4','x_5','x_6','x_7','x_8','x_9','x_10','x_11','x_12','x_13','x_14'];
%csvwrite('data_gen.csv',m')
% x1 = sin(t+n)+c
% x12 = cos(t+n)
% x6 = arcsin(x1)
% x9 = arcsin(-x1)



