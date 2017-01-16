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
	
