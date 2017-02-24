close all;
m_in = csvread('./../Data/reg_train_in.csv', 1, 1);
m_out = csvread('./../Data/reg_train_out.csv', 1, 1);
test_x = csvread('./../Data/reg_test_in.csv', 1, 1);

load('yte.mat')
xte = test_x(:,1);
t_xte = xte(xte>=2800 & xte<=3400);
t_yte = yte(xte>=2800 & xte<=3400);
x = m_in(:,1);
t_x = x(x>=2800 & x<=3400);
y = m_in(:,2);
t_y = y(x>=2800 & x<=3400);

plot(t_x,t_y);
% hold on
% plot(t_xte,t_yte);



T = 0.2;
Fs = 1/T;            % Sampling frequency
L = size(x,1);            % Sampling period
t = x; 

ft = fft(y);

P2 = abs(ft/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1); 

figure

f = Fs*(0:(L/2))/L;
fig = plot(f,P1);
%saveas(fig,'fft.jpeg');
title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')


% 
% [P3,loc] = findpeaks(P1,'Threshold',0.15);
% a = [0.001333,0.02948, 0.05896, 0.2089, 0.4164];
% 
% t_x_1 = ones(size(x,1),2*size(a,2)+1);
% 
% for i = 1:size(a,2),
%     t_x_1(:,i) = sin(a(i).*x);
%     t_x_1(:,i+size(a,2)) = cos(a(i).*x);
% end
% 
% 
% t_xte_1 = ones(size(xte,1),2*size(a,2)+1);
% 
% for i = 1:size(a,2),
%     t_xte_1(:,i) = sin(a(i).*xte);
%     t_xte_1(:,i+size(a,2)) = cos(a(i).*xte);
%     
% end
% 
% save('sincos_tr.mat','t_x_1')
% save('y_tr.mat','y')
% save('sincos_te.mat','t_xte_1')
