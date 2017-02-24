import numpy as np
import scipy as sp
from sklearn import decomposition
from sklearn import datasets
from sklearn.ensemble import BaggingClassifier
from sklearn.neighbors import KNeighborsClassifier
from sklearn.lda import LDA


if __name__ == '__main__':
	train_in = np.load('./../Data/class_train_in.npy')	
	train_in =  train_in[:,1:]
	train_out = np.load('./../Data/class_train_out.npy')	
	train_out =  train_out[:,1:]
	test_in = np.load('./../Data/class_test_in.npy')	
	test_in = test_in[:,1:]
	print 'Train Input: ',train_in.shape
	print 'Train Ouput: ',train_out.shape
	print 'Test Input: ',test_in.shape

	#LDA
	train_out_lda = train_out.reshape((1962,))
	lda = LDA(n_components=124)
	reduce_train_lda = lda.fit_transform(train_in,train_out_lda)
	#reduce_train_lda = lda.transform(train_in)
	reduce_test_lda = lda.transform(test_in)
	print 'Reduced Train (LDA): ',reduce_train_lda.shape
	print 'Reduced Test (LDA): ',reduce_test_lda.shape

	
	#PCA
	pca = decomposition.PCA(n_components=100)
	pca.fit(train_in)

	#transform data set
	reduce_train = pca.transform(train_in)
	print 'Reduced Train: ',reduce_train.shape

	reduce_test = pca.transform(test_in)
	print 'Reduced Test: ',reduce_test.shape
	
	# Import the random forest package
	from sklearn.ensemble import RandomForestClassifier 

	# Create the random forest object which will include all the parameters
	# for the fit
	forest = RandomForestClassifier(n_estimators = 100)

	# Fit the training data to the Survived labels and create the decision trees
	forest = forest.fit(reduce_train,train_out_lda)

	#Take the same decision trees and run it on the test data
	output = forest.predict_proba(reduce_test)

	r = []
	for i in range(1963):
		r.append([i+1,output[i,0]])	
	
	np.savetxt("prob.csv", r, delimiter=",", fmt='%i,%1.5f')
	
