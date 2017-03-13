%Script to evaluate conditioning

load viterbiData.mat


%part 1.2.1
p0=[0;1];n=10000;
d=size(pT_long,3);
%X=sampleAncestral(p0,pT_long,n);
%x1=sum(X==1)/n;
%x2=sum(X==2)/n;
%display('The conditional probability p(xj|x1=2) is given by: ')
%[x1' x2']


%part 1.2.2
display('The exact univariate conditionals are: ')
M=marginalCK(p0,pT_long)'

%part 1.2.3
display('The sequence with highest probability starting with x1=2 is: ')
viterbiDecode(p0,pT_long)	

%part 1.2.4
pT_long2=pT_long;
pt_long2(:,:,29)=eye(2);
p0=[0.6 0.4];
display('The sequence with highest probability with xd=1 is: ')
viterbiDecode(p0,pT_long2)

%part 1.2.5
%Y=sampleAncestral(p0,pT_long,n);
%marginalxd=(sum(X==1)/n);
%marginalxd=marginalxd(end);
%
%aux=Y(:,d)==1;
%aux=Y-repmat(aux,1,d);
%
%p1=zeros(d,1);
%p2=zeros(size(p1));
%for (k=1:d)
%	temp=aux(:,k)==0;
%	p1(k)=sum(temp)/length(temp);	
%	temp=aux(:,k)==1;
%	p2(k)=sum(temp)/length(temp);
%end
%display('the marginals probabilities are')
%[p1 p2]



%part 1.2.6
X=sampleBackwards(p0,pT_long,n);
p1=sum(X==1)/n;
p2=sum(X==2)/n;
[p1' p2']
