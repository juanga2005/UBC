load viterbiData.mat


n=10000; %Number of samples

X=sampleAncestral(p0,pT_long,n);
marginals=sum(X==1)/n;
marginals=[marginals;1-marginals];
display('The marginals obtained using Monte Carlo estimation: ')
marginals'

marginals2=marginalCK(p0,pT_long);

display('The marginals obtained using CK equations: ')
marginals2'

