%Script to do the softmaxClassifier

%Author: Juan Garcia
%Date: Jan 15 2017
%email: jggarcia@sfu.ca


function model=softmaxClassifier(X,y)

	%X,y data sets

	[n,d]=size(X);
	k=max(y); %number of classes

	W=zeros(d,k);w=W(:);
	w=findMin(@softmaxLoss,w,500,1,X,y);
	model.W=reshape(w,d,k);
	model.predict=@predict;
		
	




end

function [f,g]=softmaxLoss(w,X,y);
	%Function that returns the softmax loss and its gradient
	%X is assumed to have the bias variable

	W=reshape(w,3,5);	
	%Forming the exponential term in the function
	aux=X*W;aux=exp(aux);
	firstSumand=sum(aux,2);aux2=log(firstSumand);
	sumlogexp=sum(aux2,1);
	
	innerprod=product(W,X,y);

	
	%Function
	f=-innerprod+sumlogexp;

	%Gradient
	g=[];
	for k=1:5
		Ind=find(y==k);
		XX=X(Ind,:); 
		firstSum=sum(XX,1); %First term in the gradient

		%Creating the second term
		aux=X*W(:,k);V=exp(aux)./firstSumand;
		%display(size(X));pause();

		secondSum=X'*V;
		g=[g;-firstSum'+secondSum];
	end
		
		
	
end


function number=product(W,X,y)	
	%Returns the negative of the  first summand in the softMax function
	[n,d]=size(X);
	number=0;
	for k=1:n
		number=number+X(k,:)*W(:,y(k));
	end
end


function yhat=predict(model,X)
	W=model.W;
	[~,yhat]=max(X*W,[],2);
end
