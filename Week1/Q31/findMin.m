function [w,f] = findMin(funObj,w,maxEvals,verbose,CGfunc,varargin)
% Find local minimizer of differentiable function





%AA=varargin{1,1};LL=varargin{1,3};AA=AA(:,1:2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Defining L %%%%%%%%%%%%%%%%%%%%%%%%%%
%L=0.25*max(eig(AA'*AA))+LL;display(L);pause();
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Parameters of the Optimizaton
optTol = 1e-2;
gamma = 1e-4;

% Evaluate the initial function value and gradient
[f,g,H] = funObj(w,varargin{:});
funEvals = 1;

alpha = 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
backtracking_count=0;
iter_total=0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
while 1
	
    %Number of iterations
    iter_total=iter_total+1;
    %% Compute search direction%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %d=H\g;		
    %R=chol(H);u=R'\g;
		
    %d = R\u;

	%display(varargin);pause();
    Hv=@(v)CGfunc(w,v,varargin{:})
	tol=1e-3;
    d=pcg(Hv,g,tol);
	%display(size(d));pause();	
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    %% Line-search to find an acceptable value of alpha
	w_new = w - alpha*d;
	[f_new,g_new,H_new] = funObj(w_new,varargin{:});
	funEvals = funEvals+1;
    dirDeriv = g'*d;
    while f_new > f - gamma*alpha*dirDeriv
        if verbose
            fprintf('Backtracking...\n');
	    backtracking_count=backtracking_count+1;
        end
        %alpha = alpha^2*dirDeriv/(2*(f_new - f + alpha*dirDeriv));
	%alpha=alpha/2;
	
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%alpha=1\L;
        w_new = w - alpha*d;
        [f_new,g_new,H_new] = funObj(w_new,varargin{:});
        funEvals = funEvals+1;
    end
    alphaFinal = alpha;

    %% Update step-size for next iteration
    %alpha = 1;

    %%%%%%%%%Reseting alpha according to the Barzilai-Borwein step-size condition %%%%%%%%%%%%%%%%%%%%%
    %v=g_new-g;
    %alpha=-alpha*(v'*g)/norm(v)^2;
    %% Sanity check on step-size
    if ~isLegal(alpha) || alpha < 1e-10 || alpha > 1e10
       alpha = 1; 
    end
    
    %% Update parameters/function/gradient
    w = w_new;
    f = f_new;
    g = g_new;
    H=H_new;
	
    %% Test termination conditions
	optCond = norm(g,'inf');
    if verbose
        fprintf('%6d %6d  %6d  %15.5e %15.5e %15.5e\n',backtracking_count,iter_total,funEvals,alphaFinal,f,optCond);
    end
	
	if optCond < optTol
        if verbose
            fprintf('Problem solved up to optimality tolerance\n');
        end
		break;
	end
	
	if funEvals >= maxEvals
        if verbose
            fprintf('At maximum number of function evaluations\n');
        end
		break;
	end
end
end

function [legal] = isLegal(v)
legal = sum(any(imag(v(:))))==0 & sum(isnan(v(:)))==0 & sum(isinf(v(:)))==0;
end
