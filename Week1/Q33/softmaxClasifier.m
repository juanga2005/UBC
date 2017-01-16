%Script to do the softmaxClassifier

%Author: Juan Garcia
%Date: Jan 15 2017
%email: jggarcia@sfu.ca


function model=softmaxClassifier(X,y)

	%X,y data sets

	[n,d]=size(X);
	k=max(y); %number of classes

	W=zeros(d,k);
	
	




end

function softmaxLoss(W,X,y);
	%Function that returns the softmax loss and its gradient
	%X is assumed to have the bias variable
	aux=W'*X;aux=diag(aux);aux=exp(aux);
	wTx=sum(diag(aux));
	
	%Function
	f=number+log(wTX);
		
	



function number=product(W,X,y)	
	%Returns the first summand in the softMax function
	[n,d]=size(X);
	number=0;
	for k=1:n
		number=number+X(k,:)*W(:,y(k));
	end
end

