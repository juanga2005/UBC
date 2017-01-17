%Script to do linear regression with RBFs

%Author: Juan Garcia
%Date: Jan 12 2017
%email: jggarcia@sfu.ca


function model=leastSquaresRBFL2(X,y,lambda,sigma)

	%Arguments: X,y are the data, lambda is the strength of the penalty, sigma is the paramter for the RBF

	%Output: model is a struct that contains the weight and the predict function

	%Sizes
	[n,~]=size(X);

	%transformed basis in the rbf function
	A=rbfBasis(X,X,sigma);
	%Creating Z
	Z=[ones(n,1) A];
	%Solving the MAP
	I=eye(n+1,n+1);
	w=(lambda*I+Z'*Z)\(Z'*y);

	%Preparing the output
	model.w=w;
	model.predict=@predict;
end

function yhat=predict(model,Xhat,Xtrain,sigma)

	%Arguments: model is a struct
	% Xhat is the proyection matrix X(X^T*X)^-1*X^T

	X=rbfBasis(Xtrain,Xhat,sigma);[n,~]=size(X);
	Zhat=[ones(n,1) X];
		
	yhat =Zhat*model.w;
end
