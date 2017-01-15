%Script to do linear regression with RBFs

%Author: Juan Garcia
%Date: Jan 12 2017
%email: jggarcia@sfu.ca


function model=leastSquaresRBFL2(X,y,lambda,sigma)

	%Arguments: X,y are the data, lambda is the strength of the penalty, sigma is the paramter for the RBF

	%Output: model is a struct that contains the weight and the predict function

	%Sizes
	[n,~]=size(X);

	%Transformed basis in the RBF function
	XX=zeros(n,n);
	for t=1:n
		XX(t,:)=rbfBasis(X(t,1),X,sigma);
		display(XX(t,:));pause()
	end

	%Creating Z
	Z=[ones(n,1) XX];
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
	
	[n,d]=size(Xtrain);[t,~]=size(Xhat);
	Zhat=zeros(t,n+1);
	
	for k=1:t
		Zhat(k,:)=[1 rbfBasis(Xhat(k),Xtrain,sigma)];
	end
	yhat =Zhat*model.w;
end
