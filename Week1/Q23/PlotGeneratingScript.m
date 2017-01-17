%Script to do the plot

load outliersData.mat

%Calculating the training error
[n,~]=size(X);
epsilon=1;
model=svRegression(X,y,epsilon);

yhat=model.predict(model,X);

errorL1sv=sum(abs(yhat-y))/n; %Calculating the error


%Loading the least squares
model2=leastSquares(X,y);
yhat2=model2.predict(model2,X);

%Loading the robust regression
model3=robustRegression(X,y);
yhat3=model3.predict(model3,X);
errorL1RR=sum(abs(yhat3-y))/n;
%plotting

plot(X,y,'b.');
hold on 
plot(X,yhat,'r');
plot(X,yhat2,'k');
plot(X,yhat3,'g');

%Labeling
xlabel('x');
ylabel('y');
title('Robust Regression v.s. SVM v.s.  Least Squares');

legend('Experimental data','SVM','Least Squares','Robust Regression');



