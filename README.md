Experiments for an in-class Kaggle competition involving three tasks

1. Density Modelling
2. Classification
3. Regression

Density Modelling - 

Description - 14 dimensional data, 3 binomial variables (x_10, x_13, x_14). Pairwise plots reflect on the relationship between variables.Notable ones being 1. (x_13, x_4 and x_7) 2. (x_1, x_6, x_9 and x_12)

	Data 		- data.csv and data_norm.csv (normliased across each column)
	Previous	- Scrapbook
	QQ PLot		- Analysis of x_2 in the provided data

	Details of the experiments have been provided in the comments
	Exp1 - 
	Exp2 -
	Exp3 -
	Exp4 -\includegraphics[]{../../Downloads/utt1_spect.png}

	Exp5 -
	Exp6 -


Classification - 256 dimensional data, Histograms and pairwise scatter-plot suggest nothing, 
	
	Data -

	Exp0 - 
	Exp1 -
	Exp2 -
	Exp3 - Random Forest (Weka) 64 Features, 100 Trees, break-ties-randomly
	Exp4 - RandomForest (Weka) 10 Features, 150 Trees

	Weka results (Cross-validation)
	KNN (k=22)				76.55
	SMO 					56.473
	Adaboost(DecisionStump)	
	ADTree					57.4414 
	RotationForest			67.8389
	RBFNetwork				64.0673
	SimpleLogistic			56.7788
	BFTree					62.4363
	FunctionalTrees			63.4557
	J48						63.0989
	LADTree					60.1937
	REPTree					60.6524
	NBTree					63.0989
	RandomForest(100Trees)	70.2854
	RandomForest(200Trees)	71.2029
	RandomForest(200T 10F)	71.8145
	RandomForest(200T 100F)	71.2029
	RandomForest(300T 10F)	71.2538
	RandomForest(150T 10F)	71.9164

