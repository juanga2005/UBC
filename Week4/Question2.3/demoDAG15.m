%Demo to fit a DAG on the Minst Data using the 8 sorrounding nodes as parents

clear all;
load MNIST_images.mat

d=size(X,1);
n=size(X,3);
numberofParents=15;

token=find(isnan(Xtest(:,:,1)));
token=token(1);
models=cell(d,d);

%Loading the models
for j=token:d
	for k=1:d
		models{j,k}=modelCreator(X,[j k],numberofParents);
	end
end
figure(1)
t=size(Xtest,3);

for image=1:4
	subplot(2,2,image);

	ind=randi(t);
	I=Xtest(:,:,ind);
	

	noNaN=find(isnan(I));

	for j=noNaN:d
		for l=1:d
			mod=models{j,l};
			xhat=mod.subMatrix(I,[j l],numberofParents);
			xhat=xhat(:);
			xhat=xhat(1:(end-1));
			I(j,l)=mod.sample(mod,xhat');
		end
	end
	imagesc(I);
end

