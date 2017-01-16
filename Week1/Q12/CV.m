%Script to perform the cross validation to deterimne lambda and sigma

%Author: Juan Garcia
%Date: Jan 14 2016
%email: jggarcia@sfu.ca


load nonLinear.mat

[n,d]=size(X); K=n/10; %Size of the validation set


%Values for lambda and sigma to look for

sigma=linspace(0.05,5,100);lambda=linspace(0.05,5,100);
ngrid=length(sigma);




errors=zeros(ngrid,ngrid); %Storing the errors from the imput in the sigma-lambda plane

%Checking values of sigma and lambda
for xx=1:ngrid
	for yy=1:ngrid
		aux=zeros(K,1);
		for j=1:K

			ind=(10*(j-1)+1):(10*j);
			%Validation set
			Xtest=X(ind);
			ytest=y(ind);

			%Training set
			Xtrain=X;ytrain=y;
			Xtrain(ind)=[];
			ytrain(ind)=[];
			%Prediction
			model=leastSquaresRBFL2(Xtrain,ytrain,lambda(yy),sigma(xx));
			yhat=model.predict(model,Xtest,Xtrain,sigma(xx));
			%plot(Xtest,yhat,'o');hold on;plot(Xtest,ytest,'r.')
			%title(['\sigma=',num2str(sigma(xx)),'\lambda=',num2str(lambda(yy))]);
			%drawnow();pause();
			%hold off;
			aux(j)=norm(yhat-ytest)/length(yhat);
		end
			errors(xx,yy)=sum(aux)/K;
	end
end
			
[s,l]=meshgrid(sigma,lambda);
contourf(s,l,errors);colorbar
xlabel('\sigma');ylabel('\lambda');title('Contour Plot of the Error');

[num, idx]=min(errors(:));
[x,y]=ind2sub(size(errors),idx);
			
	


