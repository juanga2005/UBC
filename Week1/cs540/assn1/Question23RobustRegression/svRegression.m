%Script to perform a SVM regresion

%Author: Juan Garcia
%Date: Jan 14 2017
%email:jggarcia@sfu.ca


function coef=svRegression(X,y,epsilon)
	
	%Arguments: X is the training input data
	% y is the training output data
	% epsilon is the sensitivity loss (real number)

	%Output: coef is a strct coef.w is the vector (w0,w1,r1,r2,...,rn)
	%coef.predict predicts an output y given an input x 


	[n,d]=size(X);

	%Adding the bias variable
	
	one=ones(n,1);
	Z=[one X];

	%Setting up the linprog problem


	f=[0;0;one];

	aux=-eye(n);
	aux2=[Z aux;-Z aux]; 
	A=[zeros(n,2) aux;aux2];

	b=[zeros(n,1);y+epsilon;-y+epsilon];

	coef.w=linprog(f,A,b);
	coef.predict=@predict;
	
end

function yhat=predict(coef,Xhat)
	[test,d]=size(Xhat);
	Zhat=[ones(test,1) Xhat];
	yhat=Zhat*coef.w(1:2);
end
	

	

