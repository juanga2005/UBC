%Script to calculate the RBF

%Author: Juan Garcia
%Date: Jan 12 2017
%email: jggarcia@sfu.ca


function phi=rbfBasis(Xtrain,Xtest,sigma)

	%Arguments: x is the test  point 
	%xtrain is the training vector points
	%sigma is the parameter in e^(-1/(2*sigma^2)\|x-x'\|)

	%Output: phi is the row vector (phi_1,phi_2,...)
	[n,d]=size(Xtrain);[t,d]=size(Xtest);
	
	D=Xtrain.^2*ones(d,t)+ones(n,d)*Xtest'.^2-2*Xtrain*Xtest';	
	%Creating phi
	
	phi=(1/sqrt(2*pi*sigma^2))*exp(-0.5/sigma^2*D');

end


	
	
