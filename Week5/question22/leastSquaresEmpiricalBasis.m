%Script to determine lambda, sigma and the degree of the polynomial


clear all
close all

%Loading the data
load basisData.mat

[n,d]=size(X);

maxDegree=15;
minDegree=3;
loglikeold=inf;
%main loop
for degree=3:maxDegree

	%Calculating the basis
	Xpoly=zeros(n,maxDegree-minDegree);
	for i=0:degree
		Xpoly=X.^i;
	end
	%Evaluating at lambdas and sigmas	
	for lambda=10.^[-6:2]
		for sigma=10.^[-6:2]
			C=1/sigma^2*eye(n)+1/lambda*Xpoly*Xpoly';
			
			%calculating the log det
			aux1=logdet(C,0);

			%Calculating the quadratic term
			v=C\y;
			aux2=y'*v;

			loglikenew=aux1+aux2;
			if loglikenew<loglikeold
				par=[degree lambda sigma];% loglikenew];
				loglikeold=loglikenew;
			end
		end
	end
end	
		
			
			
