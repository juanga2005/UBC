%Function to implemente the generative Gaussian semi-supervised Learning

function model=generativeGaussianSSL(X,y,Xtilde)


	niter=10; %Number of iterations
	%Number of classes
	k=numel(unique(y));
	%Dimensions
	[n,d]=size(X);[t,~]=size(Xtilde);

	%Initializing the paramters
	Sigmaold=cell(1,k); %Storing the covariance matrices
	muold=cell(1,k); %Storing the means
	thetaold=cell(1,k);%Storing the thetas

	%Initializing the parameters
	for j=1:k
		Sigmaold{1,j}=eye(d);
		muold{1,j}=ones(1,d);
		thetaold{1,j}=1/k;
	end

	%Main loop
	Theta=cell(1,3); %Stores all the parameters
	for iteration=1:niter
		R=create_r(Xtilde,y,Sigmaold,muold,thetaold);
		munew=update_mu(X,Xtilde,y,R);
		Sigmanew=update_sigma(X,Xtilde,y,R,munew);
		thetanew=update_theta(Xtilde,y,R);
		
		%reassign
		muold=munew;
		Sigmaold=Sigmanew;
		thetaold=thetanew;
		Theta{1,1}=munew;
		Theta{1,2}=Sigmanew;
		Theta{1,3}=thetanew;
	end
	model.Theta=Theta;
	model.predict=@predict;
end
		
		
		
			




function R=create_r(Xtilde,y,Sigmas,mus,thetas)
	%Sigmas are the cov matrices
	%mus are the means
	%thetas are the theta parameters

	%R_{ij}=r^{i}_{j}
	[t,~]=size(Xtilde);
	k=numel(unique(y));	
	likelihoods=zeros(k,t);
	prior=zeros(k,t);
	for l=1:k
		a=mvnpdf(Xtilde,mus{1,l},Sigmas{1,l});
		if sum(a)==0
			likelihoods(l,:)=0.5;
		else
			likelihoods(l,:)=a;
		end
		prior(l,:)=repmat(thetas{1,l},1,t);
	end
	P=likelihoods.*prior; %P_{ij}=p(x^{j}|y_{i}=i,Theta)*p(y^{i}=i|Theta)
	normalization_constants=sum(P);
	aux=ones(k,1)*(1./normalization_constants);
	R=P.*aux;
end

function mu=update_mu(X,Xtilde,y,R);
	%updates mu
	k=numel(unique(y));
	mu=cell(1,k);
	
	aux=Xtilde'*R';%C-th column contains sums of the form sum(r^{i}_{c}*x^{i})
	aux2=sum(R,2);
	for j=1:k
		nj=sum(y==j);
		S1=sum(X(y==j,:));%Summand with label variables
		S2=aux(:,j); %Summand without labels	
		denom=aux2(j);
		mu{1,j}=(S1+S2')/(nj+denom); %row vector with the mu for the j-th class
	end
end


function Sigma=update_sigma(X,Xtilde,y,R,mus);

	%updates sigma
	k=numel(unique(y));
	Sigma=cell(1,k);
	[n,d]=size(X);
	[t,~]=size(Xtilde);
	aux2=sum(R,2);	
	for j=1:k
		%denominator
		nj=sum(y==j);
		denom=aux2(j);

		
		%First summand
		aux=X-ones(n,1)*mus{1,j};
		S1=aux'*aux;

		%Second summand
		aux3=R(j,:)'*ones(1,d);
		aux4=Xtilde-ones(t,1)*mus{1,j};
		S2=aux4'*(aux4.*aux3);
		
		%Sigmaj
		Sigma{1,j}=(S1+S2)/(nj+denom);
	end
end

function thetas=update_theta(Xtilde,y,R);

	%updates theta
	k=numel(unique(y));
	thetas=cell(1,k);
	[t,d]=size(Xtilde);
	aux=sum(R,2);
	for j=1:k
		thetas{1,j}=aux(j)/t;
	end
end


function yhat=predict(model,Xtest)

	
	[t,~]=size(Xtest);
	k=10;	
	prob=zeros(t,k);
	for j=1:k
		medias=model.Theta{1,1};
		mu=medias{1,j};
		Sigmas=model.Theta{1,2};
		Sigma=Sigmas{1,j};
		prob(:,j)=mvnpdf(Xtest,mu,Sigma);
	end	

	%Getting the max probability
	[ii,jj]=sort(prob,2,'descend');
	yhat=jj(:,1);

end
		
		




	
