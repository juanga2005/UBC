%Script to implement an inhomogeneous Markov Chain on the data

clear all;
load MNIST_images.mat

d=size(X,1);
n=size(X,3);


%Train the parameters within each row
Theta=zeros(2*(d-1),2,d);%Storing the value of all possible parameters

for k=1:d
	M=[];
	for j=1:(d-1)
		
		aux1=X(j,k,:);
		aux2=X(j+1,k,:);
		%Getting the transitions
		temp=2*aux2-aux1;
		if sum(X(j+1,k,:)==0)==0
			t00=0;
			t01=0;

		else
			t00=sum(temp==0)/sum(X(j+1,k,:)==0);
			t01=sum(temp==2)/sum(X(j+1,k,:)==0);
		end
		
		if sum(X(j+1,k,:)==1)==0
			t10=0;
			t11=0;
		else
			t10=sum(temp==-1)/sum(X(j+1,k,:)==1);
			t11=sum(temp==1)/sum(X(j+1,k,:)==1);
		end
		M=[M;t00 t01;t10 t11];
		sum(M,2);
	end
	Theta(:,:,k)=M;
end
