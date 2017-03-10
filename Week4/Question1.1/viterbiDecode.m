%Decode p using Viterby decode algorithm

function seq=viterbiDecode(p0,pT)

	d=size(pT,3)+1;
	M=zeros(2,d); %Matrix to memoize
	M(:,1)=p0;
	B=zeros(size(M));
	B(:,1)=[1;2];

	for j=2:d
		temp=pT(:,:,j-1).*repmat(M(:,j-1),1,2);
		[maxs,vals]=max(temp);
		M(:,j)=maxs';
		B(:,j)=vals';
	end
	[~,seq]=max(M);
end	
