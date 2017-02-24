%number of samples
numsample = 5000;

%the input file
close all;
m = csvread('./../Data/data.csv', 1, 1);

% [t3,idx] = sort(m(:,3));
% y3 = m(idx,11);

t3 = m(:,3);
y3 = m(:,11);

bins = 50;
y = zeros(bins,1);
t = zeros(bins,1);
range = max(t3)-min(t3);
j = 1;
for i = 1:bins,
    in = min(t3) + (range/bins)*(i-1);
    out = min(t3) + (range/bins)*i;
    temp = std(y3(t3<=out & t3>=in));
        y(j) = temp;
        t(j) = (in + out)/2;
        j = j + 1;

end
y (isnan(y))=0;
p = polyfit(t(5:45),y(5:45),4);

x_1 = -3.5:0.001:0.0;
%plot(t,y,'g','marker','+')

hold on
y_1 = @(x) 0.0402*(x.^4)+ 0.2193*(x.^3) +0.5116*(x.^2) + 0.9296*(x.^1) + 0.9964;

plot(x_1,y_1(x_1))

hold on

y_2 = @(x) 0.03*(x.^4) +0.18*(x.^3) + 0.5*(x.^2) + 0.97*x +1;
plot(x_1,y_2(x_1),'r')
