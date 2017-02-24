D = csvread('pca.csv',0,0);
train = csvread('./../Data/class_train_in.csv',1,1);

test = csvread('./../Data/class_test_in.csv',1,1);

for i = 1:265,
    mean_t = mean(train(:,i));
    std_t = std(train(:,i));
    train(:,i) = (train(:,i) - mean_t)/std_t;
    test(:,i) = (test(:,i) - mean_t)/std_t;
end

reduced_train = train*D;
csvwrite('reduced_train.csv',reduced_train)


reduced_test = test*D;
csvwrite('reduced_test.csv',reduced_test)