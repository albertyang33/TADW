function [predscore] = SocioDim(V, labels, index_tr, index_te, C)
% Build a SVM classifier and make predictions based on given social dimensions
% [pred, trtime, tetime] = SocioDim(V, labels, index_tr, index_te, C)
%
% INPUT: 
% - V: the extracted social dimensions from the network
% - labels: the labels of the nodes of index_tr
% - index_tr: indecies of labeleld nodes
% - index_te: indecies of unlabeled nodes
% - C: the trade-off parameter of SVM classifier
% 
% OUTPUT: 
% - pred: prediction scores  of nodes of index_te, positive scores denote +1
% - trtime: training time
% - tetime: test time
% 
% Updated by Lei Tang on Sep. 23rd, 2009.

if nargin < 5
    C = 100;  % the SVM trade-off parameter
end

numU = length(index_te);  % number of test instances

% build the SVM classifier
X = V(index_tr, :);
model = linearsvm(X, labels, C);

% prediction 
predscore = V(index_te, :) * model.W + repmat(model.bias, numU, 1);




