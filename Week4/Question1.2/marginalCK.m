%Calculate the exact marginals using CK equations

function M=marginalCK(p0,pT)
	

	d=size(pT,3);
	M=zeros(2,d);

	M(:,1)=p0;

	for j=2:d
		M(:,j)=pT(:,:,j-1)'*M(:,j-1);
	end
end	
