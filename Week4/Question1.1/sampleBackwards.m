%function to sample Backwards.

function X=sampleBackwards(p0,pT,n)
	%n is the number of samples to produces given xd=1

	d=size(pT,3);
	k=size(p0); %Number of different states
	X=zeros(n,d);	

	X(:,d)=1;
	for j=(d-1):-1:1
		pos1=find(X(:,j+1)==1);
		pos2=find(X(:,j+1)==2);
		p01=pT(1,:,j);
		p02=pT(2,:,j);	
		X(pos1,j)=sampleDiscrete(p01,length(pos1));	
		X(pos2,j)=sampleDiscrete(p02,length(pos2));
	end
end

