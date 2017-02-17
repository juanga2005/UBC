load quantum.mat
[n,d] = size(X);
lambdaFull = 1;

% Initialize
maxPasses = 10;
progTol = 1e-4;
w = zeros(d,1);
lambda = lambdaFull/n; % The regularization parameter on one example

% Stochastic gradient
w_old = w;
tests=100; %Testing different values of lambda
fvals=zeros(tests,2);
for lval=1:tests
	for t = 1:maxPasses*n
	    
	    % Choose variable to update
	    i = randi(n);
	    
	    % Evaluate the gradient for example i
	    [f,g] = logisticL2_loss(w,X(i,:),y(i),lambda);
	    
	    % Choose the step-size
	    alpha = 0.01/(lambda*t^(lval/50));
	    
	    % Take the stochastic gradient step
	    w = w - alpha*g;
	    
	    if mod(t,n) == 0
		change = norm(w-w_old,inf);
		func_val=logisticL2_loss(w,X,y,lambdaFull);
		fprintf('Passes = %d, function = %.4e, change = %.4f\n',t/n,func_val,change);
		if change < progTol
		    fprintf('Parameters changed by less than progTol on pass\n');
		    break;
		end
		w_old = w;
	    end
	 end
	fvals(lval,1)=lval/50;
	fvals(lval,2)=func_val;
	lval
end
