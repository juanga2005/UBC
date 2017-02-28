%Function to implemente the generative Gaussian semi-supervised Learning

function model=generativeGaussianSSL(X,y,Xtilde)


	niter=12; %Number of iterations
	%Number of classes
	k=numel(unique(y));
	%Dimensions
	[n,d]=size(X);[t,~]=size(Xtilde);

	%Initializing the paramters
	Sigmaold=zeros(d,d,k); %Storing the covariance matrices
	muold=zeros(k,d); %Storing the means
	thetaold=zeros(1,k);%Storing the thetas

	%Initializing the parameters
	for j=1:k
		nj=sum(y==j);
		muold(j,:)=1/nj*sum(X(y==j,:));
		aux=X(y==j,:)-repmat(muold(j,:),nj,1);
		Sigmaold(:,:,j)=1/nj*aux'*aux;
		thetaold(j)=nj/n;
	end

	%Main loop
	for iteration=1:niter
		R=update_R(Xtilde,y,Sigmaold,muold,thetaold);
		munew=update_mu(X,Xtilde,y,R);
		Sigmanew=update_sigma(X,Xtilde,y,R,munew);
		thetanew=update_theta(Xtilde,y,R);
		
		%reassign
		muold=munew;
		Sigmaold=Sigmanew;
		thetaold=thetanew;
	end
	model.mu=munew;
	model.sigma=Sigmanew;
	model.theta=thetanew;
	model.predict=@predict;
end
		
		
		
			




function R=update_R(Xtilde,y,Sigmas,mus,thetas)
	%Sigmas are the cov matrices
	%mus are the means
	%thetas are the theta parameters

	%R_{ij}=r^{i}_{j}
	[t,d]=size(Xtilde);
	k=numel(unique(y));	
	l=zeros(t,k);
	for c=1:k
		S=Sigmas(:,:,c);
		mu=mus(c,:);
		theta=thetas(c);
		Sinv=inv(S);%aux'*aux;
		num1=0.5*logdet(S);
		num2=d/2*log(2*pi);
		XX=Xtilde-repmat(mu,t,1);
		l(:,c)=-0.5*diag(XX*Sinv*XX')-(num1+num2)-repmat(log(theta),t,1);
	end
	normalization_constant=logsumexp(l,2);
	LR=l-repmat(normalization_constant,1,k);
	R=exp(LR);
end

function mu=update_mu(X,Xtilde,y,R);
	%updates mu
	k=numel(unique(y));[~,d]=size(X);
	mu=zeros(k,d);
	
	aux=Xtilde'*R;%C-th column contains sums of the form sum(r^{i}_{c}*x^{i})
	aux2=sum(R,1);%sum_{i}r^{i}_{c}
	for j=1:k
		nj=sum(y==j);
		S1=sum(X(y==j,:));%Summand with label variables
		S2=aux(:,j); %Summand without labels	
		denom=aux2(j);
		mu(j,:)=(S1+S2')/(nj+denom); %row vector with the mu for the j-th class
	end
end


function Sigma=update_sigma(X,Xtilde,y,R,mus);

	%updates sigma
	k=numel(unique(y));
	[n,d]=size(X);
	Sigma=zeros(d,d,k);
	[t,~]=size(Xtilde);
	aux2=sum(R,1);	
	for j=1:k
		%denominator
		nj=sum(y==j);
		denom=aux2(j);

		
		%First summand
		aux=X(y==j,:)-repmat(mus(j,:),nj,1);
		S1=aux'*aux; %%%Possible source of problems

		%Second summand
		aux3=repmat(R(:,j),1,d);
		aux4=Xtilde-repmat(mus(j,:),t,1);
		S2=aux4'*(aux4.*aux3);
		
		%Sigmaj
		Sigma(:,:,j)=(S1+S2)/(nj+denom);
	end
end

function thetas=update_theta(Xtilde,y,R);

	%updates theta
	k=numel(unique(y));
	thetas=zeros(1,k);
	[t,d]=size(Xtilde);
	n=length(y);
	aux=sum(R,1);
	for j=1:k
		nj=sum(y==j);
		thetas(j)=(aux(j)+nj)/(n+t);
	end
end

function like=nll(Xtilde,mu,Sigma)

	[t,d]=size(Xtilde);
	like=zeros(t,1);
	
	U=chol(Sigma);
	temp=inv(U);
	Sinv=temp*temp';
	aux=Xtilde-repmat(mu,t,1);
	like=0.5*diag(aux*Sinv*aux')+0.5*logdet(Sigma)+d/2*log(2*pi);
end


function yhat=predict(model,Xtest)

	
	[t,~]=size(Xtest);
	k=10;	
	prob=zeros(t,k);
	for j=1:k
		mu=model.mu(j,:);
		Sigma=model.sigma(:,:,j);		
		prob(:,j)=nll(Xtest,mu,Sigma);
	
	end	
	theta=model.theta;	
	prob=prob+repmat(log(theta),t,1);
	%Getting the max probability
	[ii,jj]=sort(prob,2,'ascend');
	yhat=jj(:,1);

end
		
		




	
