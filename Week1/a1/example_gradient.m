load binaryLinear.mat

lambda = 1;
model = logisticL2(X,y,lambda);

binaryClassifier2Dplot(X,y,model);