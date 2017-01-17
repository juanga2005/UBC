%Script to see the performance of the learning in rcv1_train_binary.mat

load rcv1_train.binary.mat

lambda=1;
model=logisticL2(X,y,lambda);

[n,d]=size(X);

X=[ones(n,1) X];

Error=sum(y~=sign(X*model.w))/n
