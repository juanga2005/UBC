%Script to sample from a Markov Chain using ancestral sampling

%Author: Juan Garcia
%date: March 4 2017
%email: jggarcia@sfu.ca

function X=sampleAncestral(p0,pT,n)
	%p0 is the initial distribution
	%pT are the transition probability
	%n is the number of samples


	d=size(pT,3); %Number of features
	X=zeros(n,d); %Matrix with the sample in its rows
	
	%First column of the samples	
	X(:,1)=sampleDiscrete(p0,n);
	print('pase por aca')	
	%Creating the other columns
	for j=2:d
		pos1=find(X(:,j-1)==1);
		pos2=find(X(:,j-1)==2);
		p01=pT(1,:,j-1);
		p02=pT(2,:,j-1);
		X(pos1,j)=sampleDiscrete(p01,length(pos1));
		X(pos2,j)=sampleDiscrete(p02,length(pos2));	
	end


end

