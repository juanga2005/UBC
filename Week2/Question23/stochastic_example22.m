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
wstored=zeros(d,n*maxPasses);



%Creating weights for different strategies
weights=1:1:(maxPasses*n); %Vector with weights
weights=weights.^(-1);












for t = 1:maxPasses*n
    
    % Choose variable to update
    i = randi(n);
    
    % Evaluate the gradient for example i
    [f,g] = logisticL2_loss(w,X(i,:),y(i),lambda);
    
    % Choose the step-size
    alpha = 1/(lambda*t^(lval/50));
    
    % Take the stochastic gradient step
    w = w - alpha*g;
    wstored(:,t)=w;
    
    if mod(t,n) == 0
	%Weighting techniques	
	%w=1/t*wstored(:,1:t)*ones(t,1);
	w=wstored(:,1:t)*weights(1:t);
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
