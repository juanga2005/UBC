load viterbiData.mat

p1=zeros(1,29);
p2=zeros(size(p1));
prandom=zeros(size(p2));

seq1=marginalDecode(p0,pT_long);
seq2=viterbiDecode(p0,pT_long);
seq3=randint(1,30)+1;
for j=1:29
	p1(j)=pT_long(seq(j),seq(j+1),j);
	p2(j)=pT_long(seq2(j),seq2(j+1),j);
	prandom(j)=pT_long(seq3(j),seq3(j+1),j);
end
marginal=prod(p1)*p0(1)
viterbi=prod(p2)*p0(1)
randomchain=prod(prandom)*p0(seq3(1))

viterbi/marginal
