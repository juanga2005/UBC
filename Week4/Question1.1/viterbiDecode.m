%Decode p using Viterby decode algorithm

function seq=viterbiDecode(p0,pT)

	d=size(pT,3);
	M=zeros(2,d); %Matrix to memoize
	M(:,1)=p0;
	S=zeros(2,d-1);
	seq=zeros(1,d);

	for j=2:d
		temp=pT(:,:,j-1).*repmat(M(:,j-1),1,2);
		[maxs,vals]=max(temp);
		M(:,j)=maxs';
		S(:,j-1)=vals';
	end
	[~,seq(d)]=max(M(:,d));
	for j=1:(d-1)
		seq(d-j)=S(seq(d-j+1),d-j);
	end
end	
