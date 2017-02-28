load mnist.mat;

alpha=2;
model=mixtureBernoulli(Xtrain,alpha);
nlls=model.predict(model,Xtest);

averageNLL=sum(nlls)/size(Xtest,1)
samples=model.sample(model,4);

%Samples from the distribution
figure(1);
title('Four Samples from the Bernoulli Model')
for j=1:4
	subplot(2,2,j);
	imagesc(reshape(samples(j,:),[28,28])');
end
saveas(gcf,'../samples.jpg')
%samples from the cluster
figure(2);
for k=1:10
	samples2=model.sample(model,1,k);
	subplot(4,3,k);
	imagesc(reshape(samples2(1,:),[28,28])');
	title(['Sample Cluster k=' num2str(k)])
end
saveas(gcf,'../cluster.jpg')
