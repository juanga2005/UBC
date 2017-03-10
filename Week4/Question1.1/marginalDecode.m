%Function to maximize the marginals.

function seq=marginalDecoding(p0,pT)

	M=marginals(p0,pT);
	seq=zeros(d,d);
	[~,seq(1,1)]=max(M(:,1));	
	
	
	

end



