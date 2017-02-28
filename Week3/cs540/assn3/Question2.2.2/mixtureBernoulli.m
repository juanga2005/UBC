
function model=mixtureBernoulli(X,alpha)
	%Mixture of Bernoullis
	niter=30;
	%rng(3);
	[n,d]=size(X);
	k=10; %Number of mixture elements
	%Initializing the paramters
	theta=rand(k,d);
	probs=repmat(1/k,1,10); %Coeff for the combination
	model.theta=theta;
	model.probs=probs;

	%main loop
	for j=1:niter
		R=update_R(X,model);
		model.probs=update_probs(X,R);
		model.theta=update_theta(X,R,alpha);
	end
	model.predict=@predict;
	model.sample=@sample;

	
	
end


function R=update_R(X,model)
	%Creates the responsibilities at iteration t
	
	[t,d]=size(X);
	k=10;
	L=zeros(k,t);
	L=X*log(model.theta')+(1-X)*log(1-model.theta')+log(repmat(model.probs,t,1)); %L^{c}_{i}=L_{i,c}
	normalization_constants=logsumexp(L,2);
	LR=L-repmat(normalization_constants,1,k);
	R=exp(LR);

end


function probs=update_probs(X,R)

	[n,~]=size(X);
	probs=sum(R,1)/n;
end


function theta=update_theta(X,R,alpha)
	
	[n,d]=size(X);
	temp=2*alpha-2;
	aux=sum(R,1)+temp;
	temp=alpha-1;
	theta=((X'*R)+temp).*repmat(1./aux,d,1);
	
	%Not letting parameters go to zero or 1	
	theta(theta==0)=realmin;
	theta(theta==1)=1-eps;
	theta=theta';
end


function nll=predict(model,Xtest);

	[t,~]=size(Xtest);	
	p1=Xtest*log(model.theta')+(1-Xtest)*log(1-model.theta');
	partial_probs=exp(p1);
	mix=repmat(model.probs,t,1).*partial_probs;
	nll=-log(sum(mix,2));
end
	

function samples=sample(model,t,cluster)
	probabilities=model.probs;
	probabilities=probabilities/sum(probabilities);
	%Choosing the cluster
	d=size(model.theta,2);
	samples=zeros(t,d);
	cluster=randsample(1:10,1,true,probabilities);
	if nargin==2
		for j=1:t
			theta=model.theta(cluster,:);
			samples(j,:)=rand(1,d)<theta;
		end
	else
		theta=model.theta(cluster,:);	
		for j=1:t
			samples(j,:)=rand(1,d)<theta;
		end
	end
end

	
