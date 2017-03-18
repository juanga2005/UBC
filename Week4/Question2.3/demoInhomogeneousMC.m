%Script to implement an inhomogeneous Markov Chain on the data

clear all;
load MNIST_images.mat

d=size(X,1);
n=size(X,3);


%Train the parameters within each row
Theta=zeros(2,2,d-1,d);%Storing the value of all possible parameters

for k=1:d
	for j=1:(d-1)
		
		aux1=X(j,k,:);
		aux2=X(j+1,k,:);
		%Getting the transitions
		temp=2*aux2-aux1;
		if sum(X(j,k,:)==0)==0
			t00=0;
			t01=0;

		else
			t00=sum(temp==0)/sum(X(j,k,:)==0);
			t01=sum(temp==2)/sum(X(j,k,:)==0);
		end
		
		if sum(X(j+1,k,:)==1)==0
			t10=0;
			t11=0;
		else
			t10=sum(temp==-1)/sum(X(j,k,:)==1);
			t11=sum(temp==1)/sum(X(j,k,:)==1);
		
		end
		Theta(:,:,j,k)=[t00 t01;t10 t11];
	end
end

%Sampling



% Fill-in some random test images
t = size(Xtest,3);
figure(1)
title('Inhomogeneous Markov Chain Model');
test=0;
for image = 1:4
    subplot(2,2,image);
    
    % Grab a random test example
    ind = randi(t);
    I = Xtest(:,:,ind);
    firstNonNaN=find(isnan(I)); %it should be last nonNaN
    firstNonNaN=firstNonNaN(1);
    n=sum(isnan(I(:,1)));
    % Fill in the bottom half using the model
    for j = 1:d
	for l=firstNonNaN:d	
		transProbs=Theta(I(l-1,j)+1,:,l-1,j);	
		probs=cumsum(transProbs);
		u=rand(1);
		if u<probs(1)
			I(l,j)=0;
		else
			I(l,j)=1;
		end		
	end
    end
    imagesc(reshape(I,[28 28]));
end
colormap gray




