%Function to maximize the marginals.

function seq=marginalDecode(p0,pT)

	d=size(pT,3);
	M=zeros(2,d); %Stores the values of the marginals

	M(:,1)=p0;
	for j=2:d
		aux=pT(:,:,j-1).*repmat(M(:,j-1),1,2);

		M(:,j)=sum(aux);
	end	
	[~,seq]=max(M);
		
	

end



