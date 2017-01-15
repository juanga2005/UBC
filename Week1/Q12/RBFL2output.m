%Script to produce the output of the function leastSquaresRBFL2.m

close all
clear all


%Setting the parameters
sigma=1;lambda=0.1;

%Loading the data
load nonLinear.mat

%Sizes
[n,d]=size(X);[t,~]=size(Xtest);

%Train the ridge regresion
model=leastSquaresRBFL2(X,y,lambda,sigma);

%Testing
yhat=model.predict(model,Xtest,X,sigma);

%Report test error
squaredTestError=sum((yhat-ytest).^2)/t

%Plotting
plot(X,y,'b.');
hold on
plot(Xtest,ytest,'g.');
Xhat=linspace(min(X),max(X),n)';
yhat=model.predict(model,Xhat,X,sigma);

plot(Xhat,yhat,'r');

title('Linear Regression with Gaussian RBFs for \sigma=1, \lambda=1');
xlabel('x');
ylabel('y');


