%Script to perform the cross validation to deterimne lambda and sigma

%Author: Juan Garcia
%Date: Jan 14 2016
%email: jggarcia@sfu.ca


load nonLinear.mat

[n,d]=size(X); val=n/10; %Size of the validation set


%Values for lambda and sigma to look for

sigma=linspace(0.5,2,20);lambda=linspace(0,2,20);
ngrid=length(sigma);



K=10;

errors=zeros(ngrid,ngrid);

%Checking values of sigma and lambda
for xx=1:ngrid
	for yy=1:ngrid
		for j=1:K

			ind=(10*(j-1)+1):(10*j);

			%Validation set
			Xtest=X(ind);
			ytest=y(ind);

			%Training set
			X(ind)=[];
			y(ind)=[];

			%Prediction
			model=leastSquaresRBFL2(X,y,sigma(xx),lambda(yy));
			yhat=model.predict(model,Xtest,X,sigma(xx));
			
			display(yhat);display(ytest);
			errors(xx,yy)=sum((yhat-y).^2);
		end
	end
end
			

			
	


