

load MNIST_images.mat

d=size(X,1);

nonNaN=find(isnan(Xtest(:,:,1)));
nonNaN=nonNaN(1); %Value where the first nonNaN is located
mm=length(nonNaN:d);
model=cell(d,d);
%create the model of each of the NaN pixels
for j=nonNaN:d
	for k=1:d
		ind=[j k];
		m=logisticTrain(X,ind);
		temp=logisticL2(m.Xtrain,m.y,1);
		model{j,k}=temp;
	end
	j
end	

%Filling the random images
t=size(Xtest,3);
figure(1)
for l=1:4
	subplot(2,2,l);
	ind=randi(t);
	I=X(:,:,ind);

	for j=nonNaN:d
		for k=1:d
			mod=model{j,k};
			Xhat=I(1:j,1:k);
			Xhat=Xhat(:);
			Xhat=Xhat(1:(end-1));
			Xhat(Xhat<1)=-1;
			aux=mod.sample(mod,Xhat');
			I(j,k)=(aux==1);
		end
	end
	imagesc(I);
end
