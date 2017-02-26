%Function to do the generative T student



function model=generativeStudent(Xtrain,Ytrain)

	

	nClasses=numel(unique(Ytrain));
	%nClasses=1;
	model.pdf=cell(1,nClasses);
	model.mu=cell(1,nClasses);
	model.sigma=cell(1,nClasses);
	model.dof=cell(1,nClasses);	
	%model=cell(1,nClasses);
	
	for k=1:nClasses
	
		X=Xtrain(Ytrain==k,:);
		TT=multivariateT(X);
	%	model{1,k}.mu=TT.mu;
	%	model{1,k}.sigma=TT.sigma;
	%%%	model{1,k}.dof=TT.dof;
	%	model{1,k}.pdf=TT.pdf;
		model.mu{1,k}=TT.mu;
		model.sigma{1,k}=TT.sigma;	
		model.dof{1,k}=TT.dof;

	%	model{1,k}.predict=@predict;
	end
	model.predict=@predict;
	model.NLL=TT.NLL;
	model.pdf=TT.pdf;

end
		

function yhat=predict(model,Xtest,nClasses)
	
	[n,~]=size(Xtest);
	prob=zeros(n,nClasses);	
	for k=1:nClasses	
		%prob(:,k)=model{1,k}.pdf(model{1,k},Xtest)
		%prob(:,k)=model.pdf{1,k}(model,Xtest)
		model2.mu=model.mu{1,k};
		model2.sigma=model.sigma{1,k};
		model2.dof=model.dof{1,k};
		%Xtest=Xtest-repmat(mu',n,1);
		%prob(:,k)=mvtpdf(Xtest,sigma,dof);
		prob(:,k)=model.pdf(model2,Xtest);
		
	end
		[ii,jj]=sort(prob,2,'descend');
		yhat=jj(:,1);
end
			
		
