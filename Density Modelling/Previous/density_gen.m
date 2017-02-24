%number of samples
numsample = 5000;

%the input file
close all;
m = csvread('./../Data/data.csv', 1, 1);

% %overall covariance and mean. Some of it will be used in generting samples
% %form a multi-variate Gaussian distribution
% covm = cov(m);
% meanm = mean(m);
% 
% %hypothesis - x13 is a Binomial distribution (p ~ 0.5) which controls the
% %covariance and mean (sign) between x4 and x7. Hence, first fetch the indices.
% ind = m(:,13)==1;
% 
% %covariance for the two halves
% cov1 = cov(m(ind,:));
% mean1 = mean(m(ind,:));
% cov2 = cov(m(~ind,:));
% mean2 = mean(m(~ind,:));
% 
% 
% %hypothesis - 2,3,5,8,6,9,4,7 are samples from a joint Gaussian where the
% %variance and mean depends on the respective halves (4 and 7 dependency)
% mean11 = zeros(1,8);
% mean11(:,:) = meanm(:,[2,3,5,8,6,9,4,7]);
% mean11(:,7) = mean1(:,4);
% mean11(:,8) = mean1(:,7);
% mean22 = zeros(1,8);
% mean22(:,:) = meanm(:,[2,3,5,8,6,9,4,7]);
% mean22(:,7) = mean2(:,4);
% mean22(:,8) = mean2(:,7);
% 
% %covariance
% cov11 = zeros(8,8);
% cov11(:,:) = covm([2,3,5,8,6,9,4,7],[2,3,5,8,6,9,4,7]);
% cov11(7,:) = cov1(4,[2,3,5,8,6,9,4,7]);
% cov11(:,7) = cov1([2,3,5,8,6,9,4,7],4);
% cov11(8,:) = cov1(7,[2,3,5,8,6,9,4,7]);
% cov11(:,8) = cov1([2,3,5,8,6,9,4,7],7);
% 
% %covariance
% cov22 = zeros(8,8);
% cov22(:,:) = covm([2,3,5,8,6,9,4,7],[2,3,5,8,6,9,4,7]);
% cov22(7,:) = cov2(4,[2,3,5,8,6,9,4,7]);
% cov22(:,7) = cov2([2,3,5,8,6,9,4,7],4);
% cov22(8,:) = cov2(7,[2,3,5,8,6,9,4,7]);
% cov22(:,8) = cov2([2,3,5,8,6,9,4,7],7);
% 
% 
% %hyothesis 10,14 and 13 are samples form Binomial distributions
% pd10 = fitdist(m(:,10),'Binomial');
% pd14 = fitdist(m(:,14),'Binomial');
% pd13 = fitdist(m(:,13),'Binomial');
% 
% 
% %generate samples
% 
% x2 = zeros(1,numsample);
% x3 = zeros(1,numsample);
% x5 = zeros(1,numsample);
% x8 = zeros(1,numsample);
% x6 = zeros(1,numsample);
% x9 = zeros(1,numsample);
% x4 = zeros(1,numsample);
% x7 = zeros(1,numsample);
% 
% x1 = zeros(1,numsample);
% x12 = zeros(1,numsample);
% 
% x11 = zeros(1,numsample);
% 
% x10 = zeros(1,numsample);
% x14 = zeros(1,numsample);
% x13 = zeros(1,numsample);
% 
% for i = 1:numsample,
%     %sample x10, x13 and x14
%     x13(1,i) = binornd(1,pd13.p);
%     x10(1,i) = binornd(1,pd10.p);
%     x14(1,i) = binornd(1,pd14.p);
%     
%     
%     % sample 2,3,5,8,6,9,4,7
%     if x13(1,i) == 1,
%         temp = mvnrnd(mean11,cov11);
%         x2(1,i) = temp(1,1);
%         x3(1,i) = temp(1,2);
%         x5(1,i) = temp(1,3);
%         x8(1,i) = temp(1,4);
%         x6(1,i) = temp(1,5);
%         x9(1,i) = temp(1,6);
%         x4(1,i) = temp(1,7);
%         x7(1,i) = temp(1,8);  
%     else
%         temp = mvnrnd(mean22,cov22);
%         x2(1,i) = temp(1,1);
%         x3(1,i) = temp(1,2);
%         x5(1,i) = temp(1,3);
%         x8(1,i) = temp(1,4);
%         x6(1,i) = temp(1,5);
%         x9(1,i) = temp(1,6);
%         x4(1,i) = temp(1,7);
%         x7(1,i) = temp(1,8);
%     end
%     
%     %sample x1 and x12
%     x1(1,i) = normrnd(mean(m(:,1)-cos(2*m(:,6))),std(m(:,1)-cos(2*m(:,6)))) + cos(2*x6(1,i));
%     x12(1,i) = normrnd(mean(m(:,12)-sin(2*m(:,6))),std(m(:,12)-sin(2*m(:,6)))) + sin(2*x6(1,i));
%     
%     
%     x11(1,i) = normrnd(mean(m(:,11)),exp(m(i,3)));
%     
%     temp = rand();
%     if temp <= 0.067600
%         x10(1,i) = 0;
%         x14(1,i) = 0;
%     elseif temp <= 0.067600+0.024400
%         x10(1,i) = 0;
%         x14(1,i) = 1;
%     elseif temp <= 0.067600+0.024400+0.18120
%         x10(1,i) = 1;
%         x14(1,i) = 0;
%     else
%         x10(1,i) = 1;
%         x14(1,i) = 1;
%     end
%     
% end
% 
% 
% mgen = [x1',x2',x3',x4',x5',x6',x7',x8',x9',x10',x11',x12',x13',x14'];
% 
% 
% filename = 'data_gen2.csv';
% fid = fopen(filename, 'w');
% fprintf(fid, 'x_1,x_2,x_3,x_4,x_5,x_6,x_7,x_8,x_9,x_10,x_11,x_12,x_13,x_14\n');
% fclose(fid);
% dlmwrite(filename, mgen, '-append', 'delimiter', ',');
% 
% %maintain log probability
% lprob = zeros(numsample,2);
% 
% for i = 1:numsample,
%     lprob(i,1) = i;
%     lprob(i,2) = 0;
%     % add log probability for 13
%     lprob(i,2) = lprob(i,2) + log(0.5);
%     % add log probability for 2,3,5,8,6,9,4,7
%     if m(i,13) == 1
%         lprob(i,2) = lprob(i,2) + log(mvnpdf([m(i,2),m(i,3),m(i,5),m(i,8),m(i,6),m(i,9),m(i,4),m(i,7)],mean11,cov11)); 
%         %log(mvnpdf([m(i,2),m(i,3),m(i,5),m(i,8),m(i,6),m(i,9),m(i,4),m(i,7)],mean11,cov11))
%     else
%         lprob(i,2) = lprob(i,2) + log(mvnpdf([m(i,2),m(i,3),m(i,5),m(i,8),m(i,6),m(i,9),m(i,4),m(i,7)],mean22,cov22));
%         %log(mvnpdf([m(i,2),m(i,3),m(i,5),m(i,8),m(i,6),m(i,9),m(i,4),m(i,7)],mean22,cov22))
%     end
%     % add log probabilities for 1,12
%     lprob(i,2) = lprob(i,2) + log(normpdf(m(i,1)-cos(2*(m(i,6))),mean(m(:,1)-cos(2*m(:,6))),std(m(:,1)-cos(2*m(:,6)))));
%     %log(normpdf(m(i,1)-cos(2*(m(i,6))),mean(m(:,1)-cos(2*m(:,6))),std(m(:,1)-cos(2*m(:,6)))))
%     lprob(i,2) = lprob(i,2) + log(normpdf(m(i,12)-sin(2*(m(i,6))),mean(m(:,12)-sin(2*m(:,6))),std(m(:,12)-sin(2*m(:,6)))));
%     %log(normpdf(m(i,12)-sin(2*(m(i,6))),mean(m(:,12)-sin(2*m(:,6))),std(m(:,12)-sin(2*m(:,6)))))
% 
%     % add log probability for 11
%     lprob(i,2) = lprob(i,2) + log(normpdf(m(i,11),mean(m(:,11)),0.03*m(i,3).^4 +0.18*m(i,3).^3 + 0.5*m(i,3).^2 + 0.97*m(i,3) +1));
%     %log(normpdf(m(i,11),mean(m(:,11)),0.03*m(i,3).^4 +0.18*m(i,3).^3 + 0.5*m(i,3).^2 + 0.97*m(i,3) +1))
%     
%     % add log probabilities for 10,14
%     if (m(i,[10,14])==[0,0])
%         lprob(i,2) = lprob(i,2) + log(0.067600);
%     elseif (m(i,[10,14])==[0,1])
%         lprob(i,2) = lprob(i,2) + log(0.024400);
%     elseif (m(i,[10,14])==[1,0])
%         lprob(i,2) = lprob(i,2) + log(0.18120);
%     elseif (m(i,[10,14])==[1,1])
%         lprob(i,2) = lprob(i,2) + log(0.72680);
%     end
%     
%     %lprob(i,2) = lprob(i,2) + log(pdf(pd14,m(i,14)));
%     %lprob(i,2) = lprob(i,2) + log(pdf(pd10,m(i,10)));
%     
% end
% 
% %for [0,0], [0,1], [1,0] and [1,1] respectively
% %p14_10 = [0.067600, 0.024400, 0.18120, 0.72680];
% 
% % filename = 'data_lpob_norm.csv';
% % fid = fopen(filename, 'w');
% % fprintf(fid, 'Point_ID,Output\n');
% % fclose(fid);
% % dlmwrite(filename, lprob, '-append', 'delimiter', ',');
% 
%csvwrite('data_lpob2.csv',lprob)

% t = [m_eval(:,2),m_eval(:,3),m_eval(:,4)];
% 
% ind = m(:,13)==1;
% n = 2500;
% m1 = mvnrnd(mean(m(ind,:)), cov(m(ind,:)), n);
% m1(:,1) = cos(2*(m1(:,6)))+ normrnd(mean(m(:,1)-cos(2*m(:,6))),std(m(:,1)-cos(2*m(:,6))),n,1);
% m1(:,12) =sin(2*(m1(:,6)))+ normrnd(mean(m(:,1)-cos(2*m(:,6))),std(m(:,1)-cos(2*m(:,6))),n,1);
% m1(:,11) = normrnd(0,(m1(:,3)-min(m1(:,3))).^4 - (m1(:,3)-min(m1(:,3))));
% %m1(:,10) = 
% 
% m2 = mvnrnd(mean(m(~ind,:)), cov(m(~ind,:)), 5000-n);
% m2(:,1) = cos(2*(m2(:,6)))+ normrnd(mean(m(:,1)-cos(2*m(:,6))),std(m(:,1)-cos(2*m(:,6))),5000-n,1);
% m2(:,12) =sin(2*(m2(:,6)))+ normrnd(mean(m(:,1)-cos(2*m(:,6))),std(m(:,1)-cos(2*m(:,6))),5000-n,1);
% m2(:,11) = normrnd(0,(m2(:,3)-min(m2(:,3))).^4 - (m2(:,3)-min(m2(:,3))));
% csvwrite('data_gen.csv',[m1;m2]);


close all;
a = figure;
pd = fitdist(m(:,2),'BirnbaumSaunders');
r = random(pd,1,numsample);
qqplot(m(:,2),r(1,:))
title('Exponential')
saveas(a,'Exponential','jpg')


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



% % numdim = 14;
% % m = zeros(numdim,numsample);
% % 
% % for i = 1:numsample 
% %     m(6,i) = normrnd(0,1.5)/2;
% %     m(9,i) = -m(6,i)+normrnd(0,0.05);
% %     m(1,i) = cos(2*m(6,i))+normrnd(0,0.2);
% %     m(12,i) = sin(2*m(6,i))+normrnd(0,0.2);
% %     
% % end
% 
% 
% 
% numsample = 5000;
% numdim = 14;
% x13 = zeros(1,numsample);
% x2 = zeros(1,numsample);
% x3 = zeros(1,numsample);
% x4 = zeros(1,numsample);
% x7 = zeros(1,numsample);
% x5 = zeros(1,numsample);
% x8 = zeros(1,numsample);
% 
% mu1 = [-1.0, 0, 2*pi,2*pi,0,0];
% cov1 = [
%     1,      0.1,    0.75,      0.7,      0.6,    0.6;
%     0.1,    1,      0.7,       0.6,      0.8,    0.8;
%     0.75,   0.7,        1,     0.75,     0.6,    0.6;
%     0.7,    0.6,    0.75,      1,        0.4,    0.4;
%     0.6,    0.8,    0.6,       0.4,        1,    0.01;
%     0.6,    0.8,    0.6,       0.4,      0.01,   1;
% ];
% 
% 
% mu2 = [-1.0, 0,-2*pi,-2*pi,0,0];
% cov2 = [
%     1,      0.1,    -0.75,      -0.7,      0.6,    0.6;
%     0.1,    1,      -0.7,       -0.6,      0.8,    0.8;
%     -0.75,  -0.7,     1,        -0.75,     -0.6,   -0.6;
%     -0.7,   -0.6,   -0.75,      1,         -0.4,   -0.4;
%     0.6,    0.8,    -0.6,       -0.4,        1,    0.01;
%     0.6,    0.8,    -0.6,       -0.4,      0.01,   1;
% ];
% 
% 
% 
% 
% 
% for i = 1:numsample,
%     x13(1,i) = rand(1);
%     if x13(1,i)>0.5
%         r = mvnrnd(mu1,cov1);
%         x2(1,i) = r(1);
%         x3(1,i) = r(2);
%         x4(1,i) = r(3);
%         x7(1,i) = r(4);
%         x5(1,i) = r(5);
%         x8(1,i) = r(6);
%     else
%         r = mvnrnd(mu2,cov2);
%         x2(1,i) = r(1);
%         x3(1,i) = r(2);
%         x4(1,i) = r(3);
%         x7(1,i) = r(4);
%         x5(1,i) = r(5);
%         x8(1,i) = r(6);
%     end
% end
% 
% t = unifrnd(-pi,pi,1,numsample);
% %n = normrnd(0,1,1,numsample);
% %x2 = 0.5*t+ normrnd(0,1,1,numsample);
% %x3 = t+ normrnd(0,1,1,numsample);
% x1 = cos(1.5*(x3-x2))+ normrnd(0,0.25,1,numsample);
% x12 = sin(1.5*(x3-x2)) + normrnd(0,0.25,1,numsample);
% x6 = x3-x2+ normrnd(0,0.25,1,numsample);
% x9 = x2-x3+normrnd(0,0.25,1,numsample);
% x11 = normrnd(0,500+(x3-min(x3)).^4 - (x3-min(x3)));
% 
% %x5 = x2+ normrnd(0,0.25,1,numsample);
% %x8 = x2+ normrnd(0,0.25,1,numsample);
% m = [x1',x2',x3',x4',x5',x6',x7',x8',x9',x11',x12'];
% csvwrite('data_gen.csv',m);


