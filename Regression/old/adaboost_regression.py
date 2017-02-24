import numpy as np
import matplotlib.pyplot as plt
from sklearn.tree import DecisionTreeRegressor
from sklearn.ensemble import AdaBoostRegressor

test_in = np.load('Data/reg_test_in.npy')

for i in range(14):
    column = test_in[:,i]
    x = column[~np.isnan(column)]
    mean = np.mean(x)
    var = np.var(x)
    for j in range(len(column)):
        if np.isnan(column[j]):
            test_in[j,i] = np.random.normal(mean,var)
print "nan: ", np.sum(np.isnan(test_in))
# Create the dataset
X = np.load('Data/X.npy')
X = X[:,1:]
y = np.load('Data/y.npy')

# Fit regression model
regr_1 = DecisionTreeRegressor(max_depth=20)

regr_2 = AdaBoostRegressor(DecisionTreeRegressor(max_depth=20),
                          n_estimators=300)

regr_1.fit(X, y)
regr_2.fit(X, y)

# Predict
y_1 = regr_1.predict(test_in)
y_2 = regr_2.predict(test_in)
np.save('y_1',y_1)
np.save('y_2',y_2)
