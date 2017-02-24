import numpy as np
import scipy as sp
from sklearn import decomposition
from sklearn import datasets
from sklearn.ensemble import BaggingClassifier
from sklearn.neighbors import KNeighborsClassifier
from sklearn.lda import LDA
from sklearn import svm
import mlpy
from sklearn.cross_validation import train_test_split
from sklearn.grid_search import GridSearchCV
from sklearn.metrics import classification_report

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
	'''
	#lda = LDA(n_components=124)
	#reduce_train_lda = lda.fit_transform(train_in,train_out_lda)
	#reduce_train_lda = lda.transform(train_in)
	#reduce_test_lda = lda.transform(test_in)
	#print 'Reduced Train (LDA): ',reduce_train_lda.shape
	#print 'Reduced Test (LDA): ',reduce_test_lda.shape
	


	
	class1 = []
	class2 = []
	for i in range(1962):
		if train_out_lda[i]==1:
			class1.append(train_in[i,:])
		else:
			class2.append(train_in[i,:])
	class1 = np.array(class1)
	class2 = np.array(class2)
	print "Class1: ",class1.shape
	print "Class2: ",class2.shape
  	
	mean1=np.mean(class1, axis=0)
	mean2=np.mean(class2, axis=0)
	print "mean1: ",mean1.shape
	print "mean2: ",mean2.shape
	
	#calculate variance within class
	Sw=np.dot((class1-mean1).T, (class1-mean1))+np.dot((class2-mean2).T, (class2-mean2))
 	print "Sw: ",(class1-mean1).T.shape
	#calculate weights which maximize linear separation
	w=np.dot(np.linalg.inv(Sw), np.dot((mean2-mean1),(mean2-mean1).T))

	print "W matrix: ",w.shape
	eigenValues,eigenVectors = np.linalg.eig(w)

	idx = eigenValues.argsort()[::-1]   
	eigenValues = eigenValues[idx]
	eigenVectors = eigenVectors[:,idx]

	tr = eigenVectors[:,0:100]

	reduce_train = np.dot(train_in,tr)
	reduce_test = np.dot(test_in,tr)	

	print "Reduce shapes: ", reduce_train.shape, reduce_test.shape
	r = []
	for i in range(1962):
		r.append(np.append(reduce_train[i,:],[train_out_lda[i]]))	
	
	np.savetxt("reduce_train_py.csv", r, delimiter=",", fmt = "%.5f")
	r = []
	for i in range(1963):
		r.append(np.append(reduce_test[i,:],[0]))	
	np.savetxt("reduce_test_py.csv", r, delimiter=",", fmt = "%.5f")
	'''
	
	#PCA
	pca = decomposition.PCA(n_components=100)
	pca.fit(train_in)

	#transform data set
	reduce_train = pca.transform(train_in)
	print 'Reduced Train: ',reduce_train.shape

	reduce_test = pca.transform(test_in)
	print 'Reduced Test: ',reduce_test.shape


	'''		
	# Import the random forest package
	from sklearn.ensemble import RandomForestClassifier 

	# Create the random forest object which will include all the parameters
	# for the fit
	forest = RandomForestClassifier(n_estimators = 100)
	# Fit the training data to the Survived labels and create the decision trees
	forest = forest.fit(reduce_train,train_out_lda)

	#Take the same decision trees and run it on the test data
	output = forest.predict_proba(reduce_test)
	'''

	#from sklearn import cross_validation
	'''
	clf = svm.SVC(kernel='rbf', C=1, probability=True)
	#scores = cross_validation.cross_val_score(clf, reduce_train, train_out_lda, cv=5)
	#print scores
	clf.fit(reduce_train, train_out_lda)
	output = clf.predict_proba(reduce_test)
	'''
	from sklearn.ensemble import AdaBoostClassifier
	from sklearn.tree import DecisionTreeClassifier
	bdt = AdaBoostClassifier(DecisionTreeClassifier(max_depth=1),
                         algorithm="SAMME.R",
                         n_estimators=200)

	bdt.fit(reduce_train, train_out_lda)
	output = bdt.predict_proba(reduce_test)
	'''
	# Split the dataset in two equal parts
	X_train, X_test, y_train, y_test = train_test_split(
		reduce_train, train_out_lda, test_size=0.2, random_state=0)

	# Set the parameters by cross-validation
	tuned_parameters = [{'kernel': ['rbf'], 'gamma': [1e-3, 1e-4],
				'C': [1, 10, 100, 1000]},
				{'kernel': ['linear'], 'C': [1, 10, 100, 1000]}]

	scores = ['precision', 'recall']

	for score in scores:

		print("# Tuning hyper-parameters for %s" % score)
    		print()
		clf = GridSearchCV(svm.SVC(C=1), tuned_parameters, cv=5,
			scoring='%s_weighted' % score)

		clf.fit(X_train, y_train)

		print("Best parameters set found on development set:")
		print()
		print(clf.best_params_)
		for params, mean_score, scores in clf.grid_scores_:
			print("%0.3f (+/-%0.03f) for %r"% (mean_score, scores.std() * 2, params))
		print()

		print("Detailed classification report:")
		print()
		print("The model is trained on the full development set.")
		print("The scores are computed on the full evaluation set.")
		print()
		y_true, y_pred = y_test, clf.predict(X_test)
		print(classification_report(y_true, y_pred))
		print()
	'''
	r = []
	for i in range(1963):
		r.append([i+1,output[i,0]])	
	
	np.savetxt("prob2.csv", r, delimiter=",", fmt='%i,%1.5f')
		
