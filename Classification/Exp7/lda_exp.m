train_in = csvread('./../Data/class_train_in.csv',1,1);
test_in = csvread('./../Data/class_test_in.csv',1,1);

train_out = csvread('./../Data/class_train_out.csv',1,1);

[Z,W] = FDA(train_in',train_out,1);
[w,t,fp]=fisher_training(train_in,train_out);

reduced_train = zeros(1962,2);
reduced_train(:,1) = Z';
for i = 1:1962,
    reduced_train(i,2) = train_out(i);
end
csvwrite('reduced_train.csv',reduced_train)


reduced_test = zeros(1963,2);
reduced_test(:,1) = test_in*W;
for i = 1:1963,
    reduced_test(i,2) = 0;
end
reduced_test(1,2) = 1;



csvwrite('reduced_test.csv',reduced_test)