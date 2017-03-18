%Function to calculate marginals using Forward Backwards.


function probs=forwardBackwards(p0,pT)

	d=size(pT,3);
	probs=zeros(2,d);	
	%Calculating the Ms
	M=zeros(2,d);

	M(:,1)=p0;
	for j=2:d
		aux=pT(:,:,j-1).*repmat(M(:,j-1),1,2);
		M(:,j)=sum(aux)';
	end
	M(:,d)=1; %puting the condition x30=1;

	%Calculating the Vs

	V=zeros(2,d);
	V(:,d)=[1 0];
	for j=(d-1):-1:1
		aux=pT(:,:,j).*repmat(V(:,j+1),1,2);
		V(:,j)=sum(aux)';
	end
	num=M.*V;
	denom=sum(num);
	probs=num./repmat(denom,2,1);
	probs=probs';
	

		
end
