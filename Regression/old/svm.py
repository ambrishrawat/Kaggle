import numpy as np
from sklearn.svm import SVR


#tmp = 'silly/Kaggle/regression'
#X = np.load('Data/X.npy')
X = np.genfromtxt('Data/reg_train_in.csv', delimiter=',')
y = np.load('Data/reg_train_out.npy')
y = [x[0] for x in y]
y=np.array(y)
test_in = np.load('Data/reg_test_in.npy')

clf = SVR(C=1.0, epsilon =0.2)
clf.fit(X,y)
test_out = clf.predict(test_in)
np.save(test_out, 'svm')
np.savetext(test_out, 'svm')