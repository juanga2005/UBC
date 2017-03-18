%Samples from a discrete distribution

%Author: Juan Garcia
%date: March 4 2017
%email: jggarcia@sfu.ca

function samples=sampleDiscrete(p0,n)
	%p0 is the probability of each value
	%n is the number of samples
	%Storing the probabilities	
	probs=cumsum(p0);
	%Generating the samples
	u=rand(n,1);
	samples=generateSamples(probs,u);
	
end

function positions=generateSamples(probs,u)
	
	n=length(u);
	positions=zeros(n,1);	
	for j=1:n
		aux=binarySearch(probs,u(j));
		positions(j)=find(probs==aux);
	end
end	
	
function p=binarySearch(probs,u)
	%Performs a binary search to sample
	N=length(probs);
	k=(floor(N/2))*mod(N,2)+N/2*(1-mod(N,2));

	if (k==0)
		p=probs;
	else	
		if (u<probs(k))
			p=binarySearch(probs(1:k),u);
		else
			p=binarySearch(probs((k+1):end),u);
		end
	end
	

end
