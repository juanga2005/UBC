%Script to do the sample reject to calculate conditionals
load viterbiData.mat
n=10000;


Y=sampleAncestral(p0,pT_long,n);
d=size(Y,2);



marginalxd=(sum(Y(:,d)==1)/n);

aux=Y(:,d)==1;
aux=Y(aux,:);

p1=zeros(d,1);
p2=zeros(size(p1));
for (k=1:d)
	temp=aux(:,k)==1;
	p1temp=sum(temp)/n;	
	temp=aux(:,k)==2;
	p2temp=sum(temp)/n;

	p1(k)=p1temp/marginalxd;
	p2(k)=p2temp/marginalxd;
	
end
display('The number of samples accepted: ')
n-size(aux,1)


display('the marginals probabilities are')
[p1 p2]


