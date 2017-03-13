%Script to implment the forward backward algorithm


function mar=forwardBackwards(p0,pT,j)
	%j is the element we want to know the marginal of

	d=size(pT,3);
	k=length(p0);

	M(:,d)=1;
	 
