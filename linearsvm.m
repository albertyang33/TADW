function [model] = linearsvm(X, Y, C, dual)
  % [model] = linearsvm(X, Y, C, dualparam);
  % Build linear svm using liblinear package
  % X: the instance X feature sparse matrix
  % Y: the label Y each column is  a label, the negative class could be -1 or 0
  % C: the trade-off parameter of SVM
  % dual: whether or not use primal or dual solver (optional)
  %
  %  model: the constructed SVM classifier
  %  to obtain prediction score of test set X of n test instances
  %      prediction_score = X * model.W + repmat(model.bias, n, 1)
  
  
  if nargin < 4
	dual = 0;	
  end
  
  param.alpha = C;
  %C = param.alpha;
  [n, T] = size(Y);
  [n, d] = size(X);
  
%   if issparse(Y)
%     Y = full(Y);
%   end
  if ~issparse(X)
      X = sparse(X);
  end
  
  
  %Y(Y==0)=-1;
  if dual==0
  paramstr = sprintf('-s 2 -c %f -B 1 -q', param.alpha)
  else
  paramstr = sprintf('-s 1 -c %f -B 1 -q', param.alpha)
  end	
  
%% ===PLEASE uncomment the following code if you use liblinear <1.5 ======
%   if dual==0
%   	paramstr = sprintf('-s 2 -c %f', param.alpha)
%   else
%   	paramstr = sprintf('-s 1 -c %f', param.alpha)
%   end	
%% =======================================================================


  W = zeros(d,T);
  bias = zeros(1,T);
  
  for t=1:T
    t
    y = -1*ones(n, 1);     
    y(Y(:, t)==1)=1;
    mod_ind = train(y, X, paramstr);
    % fprintf('the size of vector w is %d: %d\n', length(mod_ind.w), d);
    W(:, t) = mod_ind.w(1:d);
    bias(t) = mod_ind.w(end);
    if mod_ind.Label(1)==-1
       W(:,t)= -W(:,t);
       bias(t) = -bias(t);
    end
  end
  model.W = W;
  model.bias = bias;
  model.method = 'svm';
  model.param = param;
  
