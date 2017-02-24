import numpy as np
from sklearn.gaussian_process import GaussianProcess
from sklearn.cross_validation import cross_val_score, KFold


tmp = 'silly/Kaggle/regression'
X = np.load(tmp + '/Data/reg_train_in.npy')
y = np.load(tmp + '/Data/reg_train_out.npy')
test_in = np.load(tmp+'/Data/reg_test_in.npy')

X = X[0:100,:]
y = y[0:100]
#gp = GaussianProcess(regr='constant', corr='squared_exponential',
 #                    theta0=[1e-4] * 10, thetaL=[1e-12] * 10,
 #                    thetaU=[1e-2] * 10, nugget=1e-2, optimizer='Welch')
gp = GaussianProcess(regr='constant', corr='squared_exponential')
print 'Starting training\n'
gp.fit(X, y)
print 'Finished training\n'
# Deactivate maximum likelihood estimation for the cross-validation loop
gp.theta0 = gp.theta_  # Given correlation parameter = MLE
gp.thetaL, gp.thetaU = None, None  # None bounds deactivate MLE

# Perform a cross-validation estimate of the coefficient of determination using
# the cross_validation module using all CPUs available on the machine
K = 20  # folds
R2 = cross_val_score(gp, X, y=y, cv=KFold(y.size, K), n_jobs=1).mean()
print("The %d-Folds estimate of the coefficient of determination is R2 = %s" % (K, R2))

test_out = gp.predict(test_in, eval_MSE=False, batch_size=None)
print test_out



