%Script to calculate the RBF

%Author: Juan Garcia
%Date: Jan 12 2017
%email: jggarcia@sfu.ca


function phi=rbfBasis(x,Xtrain,sigma)

	%Arguments: x is the test  point 
	%xtrain is the training vector points
	%sigma is the parameter in e^(-1/(2*sigma^2)\|x-x'\|)

	%Output: phi is the row vector (phi_1,phi_2,...)
	[n,~]=size(Xtrain);
	f=@(x,xtrain) exp(-(x-xtrain).^2/(2*sigma^2));
	
	%Creating phi
	phi=f(x,Xtrain);
	phi=phi';

end


	
	
