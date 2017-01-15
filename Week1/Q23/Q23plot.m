%Script to do the plot

load outliersData.mat

%Calculating the training error
[n,~]=size(X);
model=robustRegression(X,y);

yhat=model.predict(model,X);

errorL1=sum(abs(yhat-y))/n; %Calculating the error


%Loading the least squares
model2=leastSquares(X,y);
yhat2=model2.predict(model2,X);

%plotting

plot(X,y,'b.');
hold on 
plot(X,yhat,'r');
plot(X,yhat2,'k');

%Labeling
xlabel('x');
ylabel('y');
title('Robust Regression v.s. Least Squares');

legend('Experimental data','Robust Regresion','Least Squares');



