import numpy as np

test_in = np.load('Data/reg_test_in.npy')

for i in range(14):
	column = test_in[:,i]
	x = column[~np.isnan(column)]
	mean = np.mean(column)
	var = np.var(column)
	for j in range(len(column)):
		if np.isnan(column[j]):
			test_in[j,i] =  np.random.normal(mean,var)
