function [ model ] = densityBernoulli(X,alpha)

[n,d] = size(X);

%theta = mean(X);

model.theta = theta_generator(X,alpha);
odel.predict = @predict;
model.sample = @sample;
end

function nlls = predict(model, Xhat)
[t,d] = size(Xhat);
theta = model.theta;

nlls = -sum(prod0(Xhat,repmat(log(theta),[t 1])) + prod0(1-Xhat,repmat(log(1-theta),[t 1])),2);
end

function samples = sample(model,t)
theta = model.theta;
d = length(theta);

samples = zeros(t,d);
for i = 1:t
    samples(i,:) = rand(1,d) < theta;
end
end

function theta=theta_generator(X,alpha)
	%Generates theta with Laplace smoothing
	
	[n,d]=size(X);
	N1=sum(X);
	numerator=N1+(alpha-1);
	denom=repmat(1/(n+2*alpha-2),1,d);
	theta=numerator.*denom;
end
	
