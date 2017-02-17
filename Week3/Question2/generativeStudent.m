%Function to do the generative T student



function model=generativeStudent(Xtrain,Ytrain)

	

	nClasses=numel(unique(Ytrain));
	%model.pdf=cell(1,nClasses);
	%model.mu=cell(1,nClasses);
	%model.sigma=cell(1,nClasses);
	%model.dof=cell(1,nClasses);	
	model=cell(1,nClasses);
	
	for k=1:nClasses
	
		X=Xtrain(Ytrain==k,:);
		TT=multivariateT(X);
		model{1,k}.mu=TT.mu;
		model{1,k}.sigma=TT.sigma;
		model{1,k}.dof=TT.dof;
		model{1,k}.pdf=TT.pdf;
	%	model.mu{1,k}=TT.mu;
	%	model.sigma{1,k}=TT.sigma;	
	%	model.dof{1,k}=TT.dof;
	%	model.pdf{1,k}=TT.pdf;

		model{1,k}.predict=@predict;
	end

end
		

function yhat=predict(model,Xtest,nClasses)
	
	[n,~]=size(Xtest);
	prob=zeros(n,nClasses);	
	for k=1:nClasses	
		prob(:,k)=model{1,k}.pdf(model{1,k},Xtest)
	end
end
			
		
