%Script to evaluate conditioning

load viterbiData.mat

p0=[0;1];n=10000;
d=size(pT_long,3);

%part 1.2.1
%X=sampleAncestral(p0,pT_long,n);
%x1=sum(X==1)/n;
%x2=sum(X==2)/n;
%display('The conditional probability p(xj|x1=2) is given by: ')
%[x1' x2']
%
%
%%part 1.2.2
%display('The exact univariate conditionals are: ')
%M=marginalCK(p0,pT_long)'

%part 1.2.3
%display('The sequence with highest probability starting with x1=2 is: ')
%viterbiDecode(p0,pT_long)	

%%part 1.2.4
%pT_long2=pT_long;
%pt_long2(:,:,29)=eye(2);
%p0=[0.6 0.4];
%display('The sequence with highest probability with xd=1 is: ')
%viterbiDecode(p0,pT_long2)
%

%
%
%%part 1.2.6
%X=sampleBackwards(p0,pT_long,n);
%p1=sum(X==1)/n;
%p2=sum(X==2)/n;
%[p1' p2']
