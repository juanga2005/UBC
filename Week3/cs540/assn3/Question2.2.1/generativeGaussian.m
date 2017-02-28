%Function to fit GDA 


function model=generativeGaussian(Xtrain,Ytrain)

	%Xtrain is the training input
	%Ytrain is the training output

	%Number of classes
	[n,d]=size(Xtrain);
	nClasses=numel(unique(Ytrain));
	
	model.mu=meanMatrix(d,nClasses,Xtrain,Ytrain);%Stores the mean for each class
	model.sigma=sigma(Xtrain,Ytrain,model.mu,nClasses);	
	model.predict=@predict;






end

function Mu=meanMatrix(d,nClasses,Xtrain,Ytrain)

	%Function to return a nxnClasses matrix with
	%the values of the mean for each class

	
		
	Mu=zeros(d,nClasses);
	klasses=unique(Ytrain);
	for k=1:nClasses
		Nk=sum(klasses(k)==Ytrain);		
		aux=sum(Xtrain(Ytrain==k,:),1);
		Mu(:,k)=1/Nk*aux';

	end
end


function S=sigma(Xtrain,Ytrain,Mu,nClasses)
	%Function that returns the estimation
	%for the covariance matrix
	%S is a cell containing all the covariance matrix for each class

	[n,d]=size(Xtrain);
	S=cell(nClasses,1);
	klasses=unique(Ytrain);

	for k=1:nClasses
		X=Xtrain(Ytrain==k,:);
		Nk=sum(Ytrain==klasses(k));	
		S{k,1}=1/Nk*X'*X;
	end
end


function yhat=predict(model,Xtest)
	%Function for prediction
	[n,~]=size(Xtest);	
	[~,nClasses]=size(model.mu);
	prob=zeros(n,nClasses); %Stores the probability for each class
	
	for k=1:nClasses
		prob(:,k)=mvnpdf(Xtest,model.mu(:,k)',model.sigma{k,1});
	end
	
		%Locating the maximum probablities for each feature
		[ii,jj]=sort(prob,2,'descend');
		yhat=jj(:,1);
end	

