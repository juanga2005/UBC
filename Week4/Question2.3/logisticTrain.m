%Function to return the model for training with logistic regression


function model=logisticTrain(X,ind)
	%X contains all the dxdxn data
	%ind is the index [i j] where to train	
	d=size(X,1);
	n=size(X,3);
	
	x=ind(1);y=ind(2);
	subM=X(1:x,1:y,:);
	subM=subM(:);	
	
	M=max(x,y);m=min(x,y);
	aux=M*m;
	temp=zeros(aux,n);

	temp=reshape(subM,aux,n);
	temp(temp<1)=-1;	
	temp=temp';
	model.Xtrain=zeros(n,aux-1);
	model.y=zeros(n,1);
	model.Xtrain=temp(:,1:(end-1)); %input for the model
	model.y=temp(:,end); %output for the input model.X
	
	

	
end	
	
