% 13 sampled from Binomial
% 2,3,5,8,6,9,4,7 - sampled from a multivariate Gaussian
% the covariance and mean for x4 amd x7 depend on the sign of 13
% 1 and 12 sampled from gaussians, mean and covariance depend on 6 (sin, cos relation)
% 10, 14 sampled form joint binomial (2-d multinomial)
% 11 sampled from Gaussian, covariance depends on 3 (polynomial regression)

%Score - 0.76271

%number of samples
numsample = 5000;

%the input file
close all;
m = csvread('./../Data/data.csv', 1, 1);

%overall covariance and mean. Some of it will be used in generting samples
%form a multi-variate Gaussian distribution
covm = cov(m);
meanm = mean(m);

%hypothesis - x13 is a Binomial distribution (p ~ 0.5) which controls the
%covariance and mean (sign) between x4 and x7. Hence, first fetch the indices.
ind = m(:,13)==1;

%covariance for the two halves
cov1 = cov(m(ind,:));
mean1 = mean(m(ind,:));
cov2 = cov(m(~ind,:));
mean2 = mean(m(~ind,:));


%hypothesis - 2,3,5,8,6,9,4,7 are samples from a joint Gaussian where the
%variance and mean depends on the respective halves (4 and 7 dependency)
mean11 = zeros(1,8);
mean11(:,:) = meanm(:,[2,3,5,8,6,9,4,7]);
mean11(:,7) = mean1(:,4);
mean11(:,8) = mean1(:,7);
mean22 = zeros(1,8);
mean22(:,:) = meanm(:,[2,3,5,8,6,9,4,7]);
mean22(:,7) = mean2(:,4);
mean22(:,8) = mean2(:,7);

%covariance
cov11 = zeros(8,8);
cov11(:,:) = covm([2,3,5,8,6,9,4,7],[2,3,5,8,6,9,4,7]);
cov11(7,:) = cov1(4,[2,3,5,8,6,9,4,7]);
cov11(:,7) = cov1([2,3,5,8,6,9,4,7],4);
cov11(8,:) = cov1(7,[2,3,5,8,6,9,4,7]);
cov11(:,8) = cov1([2,3,5,8,6,9,4,7],7);

%covariance
cov22 = zeros(8,8);
cov22(:,:) = covm([2,3,5,8,6,9,4,7],[2,3,5,8,6,9,4,7]);
cov22(7,:) = cov2(4,[2,3,5,8,6,9,4,7]);
cov22(:,7) = cov2([2,3,5,8,6,9,4,7],4);
cov22(8,:) = cov2(7,[2,3,5,8,6,9,4,7]);
cov22(:,8) = cov2([2,3,5,8,6,9,4,7],7);


%hyothesis 10,14 and 13 are samples form Binomial distributions
pd10 = fitdist(m(:,10),'Binomial');
pd14 = fitdist(m(:,14),'Binomial');
pd13 = fitdist(m(:,13),'Binomial');


%generate samples

x2 = zeros(1,numsample);
x3 = zeros(1,numsample);
x5 = zeros(1,numsample);
x8 = zeros(1,numsample);
x6 = zeros(1,numsample);
x9 = zeros(1,numsample);
x4 = zeros(1,numsample);
x7 = zeros(1,numsample);

x1 = zeros(1,numsample);
x12 = zeros(1,numsample);

x11 = zeros(1,numsample);

x10 = zeros(1,numsample);
x14 = zeros(1,numsample);
x13 = zeros(1,numsample);

for i = 1:numsample,
    %sample x10, x13 and x14
    x13(1,i) = binornd(1,pd13.p);
    x10(1,i) = binornd(1,pd10.p);
    x14(1,i) = binornd(1,pd14.p);
    
    
    % sample 2,3,5,8,6,9,4,7
    if x13(1,i) == 1,
        temp = mvnrnd(mean11,cov11);
        x2(1,i) = temp(1,1);
        x3(1,i) = temp(1,2);
        x5(1,i) = temp(1,3);
        x8(1,i) = temp(1,4);
        x6(1,i) = temp(1,5);
        x9(1,i) = temp(1,6);
        x4(1,i) = temp(1,7);
        x7(1,i) = temp(1,8);  
    else
        temp = mvnrnd(mean22,cov22);
        x2(1,i) = temp(1,1);
        x3(1,i) = temp(1,2);
        x5(1,i) = temp(1,3);
        x8(1,i) = temp(1,4);
        x6(1,i) = temp(1,5);
        x9(1,i) = temp(1,6);
        x4(1,i) = temp(1,7);
        x7(1,i) = temp(1,8);
    end
    
    %sample x1 and x12
    x1(1,i) = normrnd(mean(m(:,1)-cos(2*m(:,6))),std(m(:,1)-cos(2*m(:,6)))) + cos(2*x6(1,i));
    x12(1,i) = normrnd(mean(m(:,12)-sin(2*m(:,6))),std(m(:,12)-sin(2*m(:,6)))) + sin(2*x6(1,i));
    
    
    x11(1,i) = normrnd(mean(m(:,11)),0.03*x3(1,i).^4 +0.18*x3(1,i).^3 + 0.5*x3(1,i).^2 + 0.97*x3(1,i) +1);
    
    temp = rand();
    if temp <= 0.067600
        x10(1,i) = 0;
        x14(1,i) = 0;
    elseif temp <= 0.067600+0.024400
        x10(1,i) = 0;
        x14(1,i) = 1;
    elseif temp <= 0.067600+0.024400+0.18120
        x10(1,i) = 1;
        x14(1,i) = 0;
    else
        x10(1,i) = 1;
        x14(1,i) = 1;
    end
    
end

mgen = [x1',x2',x3',x4',x5',x6',x7',x8',x9',x10',x11',x12',x13',x14'];

filename = 'data_gen.csv';
fid = fopen(filename, 'w');
fprintf(fid, 'x_1,x_2,x_3,x_4,x_5,x_6,x_7,x_8,x_9,x_10,x_11,x_12,x_13,x_14\n');
fclose(fid);
dlmwrite(filename, mgen, '-append', 'delimiter', ',');




lprob = zeros(numsample,2);

for i = 1:numsample,
    lprob(i,1) = i;
    lprob(i,2) = 0;
    
    % add log probability for 13
    lprob(i,2) = lprob(i,2) + binopdf(m(i,13),1,pd13.p);
    
    % add log probability for 2,3,5,8,6,9,4,7
    if m(i,13) == 1
        lprob(i,2) = lprob(i,2) + log(mvnpdf([m(i,2),m(i,3),m(i,5),m(i,8),m(i,6),m(i,9),m(i,4),m(i,7)],mean11,cov11)); 
        %log(mvnpdf([m(i,2),m(i,3),m(i,5),m(i,8),m(i,6),m(i,9),m(i,4),m(i,7)],mean11,cov11))
    else
        lprob(i,2) = lprob(i,2) + log(mvnpdf([m(i,2),m(i,3),m(i,5),m(i,8),m(i,6),m(i,9),m(i,4),m(i,7)],mean22,cov22));
        %log(mvnpdf([m(i,2),m(i,3),m(i,5),m(i,8),m(i,6),m(i,9),m(i,4),m(i,7)],mean22,cov22))
    end
    % add log probabilities for 1,12
    lprob(i,2) = lprob(i,2) + log(normpdf(m(i,1)-cos(2*(m(i,6))),mean(m(:,1)-cos(2*m(:,6))),std(m(:,1)-cos(2*m(:,6)))));
    %log(normpdf(m(i,1)-cos(2*(m(i,6))),mean(m(:,1)-cos(2*m(:,6))),std(m(:,1)-cos(2*m(:,6)))))
    lprob(i,2) = lprob(i,2) + log(normpdf(m(i,12)-sin(2*(m(i,6))),mean(m(:,12)-sin(2*m(:,6))),std(m(:,12)-sin(2*m(:,6)))));
    %log(normpdf(m(i,12)-sin(2*(m(i,6))),mean(m(:,12)-sin(2*m(:,6))),std(m(:,12)-sin(2*m(:,6)))))

    % add log probability for 11
    lprob(i,2) = lprob(i,2) + log(normpdf(m(i,11),mean(m(:,11)),0.03*m(i,3).^4 +0.18*m(i,3).^3 + 0.5*m(i,3).^2 + 0.97*m(i,3) +1));
    %log(normpdf(m(i,11),mean(m(:,11)),0.03*m(i,3).^4 +0.18*m(i,3).^3 + 0.5*m(i,3).^2 + 0.97*m(i,3) +1))
    
    % add log probabilities for 10,14
    if (m(i,[10,14])==[0,0])
        lprob(i,2) = lprob(i,2) + log(0.067600);
    elseif (m(i,[10,14])==[0,1])
        lprob(i,2) = lprob(i,2) + log(0.024400);
    elseif (m(i,[10,14])==[1,0])
        lprob(i,2) = lprob(i,2) + log(0.18120);
    elseif (m(i,[10,14])==[1,1])
        lprob(i,2) = lprob(i,2) + log(0.72680);
    end
    
    %lprob(i,2) = lprob(i,2) + log(pdf(pd14,m(i,14)));
    %lprob(i,2) = lprob(i,2) + log(pdf(pd10,m(i,10)));
    
end

%for [0,0], [0,1], [1,0] and [1,1] respectively
%p14_10 = [0.067600, 0.024400, 0.18120, 0.72680];

filename = 'data_lprob.csv';
fid = fopen(filename, 'w');
fprintf(fid, 'Point_ID,Output\n');
fclose(fid);
dlmwrite(filename, lprob, '-append', 'delimiter', ',');

