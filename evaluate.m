function [perf, pred] = evaluate(pred, Y, flag_label)
%  perf = evaluate(pred, Y)
% suppose we know the number of labels for  ground truth
% calculate the precision, recall and F1 for each label
% as well as micro-F1
% pred: the prediction scores
% Y:  a SPARSE matrix of 0 or 1   (size: n X k)

 

  % remove those instances without labels
  index =sum(Y,2)>0;
  pred = pred(index, :);
  Y = Y(index, :);
 
  [n, k] = size(Y);
   
  if nargin == 2
    flag_label = 0; 
  end 

  if flag_label==1
    [pred] = evaluate_by_ranking_via_label(pred, Y);
  else
    [pred] = evaluate_by_ranking_via_instance(pred, Y);
  end
  
  % exact match ratio
  perf.acc =  sum(sum(xor(pred ,Y), 2) == 0) /n;
  
  
  temp = pred & Y;
  num_correct = sum(temp, 1);
  num_true = sum(Y,   1);
  num_pred  = sum(pred, 1);
  
  % the precision/recall/F1 for each label
  perf.precision = num_correct./num_pred;
  perf.recall = num_correct ./num_true;
  perf.F1 = (2*num_correct)./(num_true+num_pred);
  
  perf.precision(num_correct==0)=0;
  perf.recall(num_correct==0)=0;
  perf.F1(num_correct==0)=0;
  
  perf.macro_precision = mean(perf.precision);
  perf.macro_recall = mean(perf.recall);
  perf.macro_F1 = mean(perf.F1);
  
  % micro_F1
  perf.micro_precision = sum(num_correct) /  sum(num_pred);
  perf.micro_recall = sum(num_correct) / sum(num_true);
  perf.micro_F1 = 2*sum(num_correct)/(sum(num_true) + sum(num_pred));
  
  
  
function [pred] = evaluate_by_ranking_via_instance(pred, Y)
  % rank the labels by the scores directly
  [n, k] = size(Y);
  [val, index] = sort(full(pred), 2, 'descend');
  
  numlabel = sum(Y,2); % the number of labels for each instance
  clear val;
  
  pred = construct_indicator(index, numlabel);
  pred = sparse(pred);
  
%  pred = sparse(n,k); 
%   for I = 1:n
%     pred(I, index(I, 1:numlabel(I))) = 1;    
%   end
  
  
function [pred] = evaluate_by_ranking_via_label(pred, Y)
% evalute the prediction scores based on the ranking of Y
  [n, k] = size(Y);
  [val, index] = sort(full(pred), 1, 'descend');
  clear val;
  numInst = sum(Y, 1);
  pred = construct_indicator(index', numInst)';
  pred = sparse(pred);
  
  %pred = sparse(n, k);
  
%   for I = 1:k
%       I
%     pred(index(1:numInst(I), I), I) = 1;
%   end
  
function [pred] = evalute_by_sign(pred, Y)
  % evalute the predictions cores based on the sign of the score
  
