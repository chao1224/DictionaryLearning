%% Lasso regularization example
% Copyright (c) 2011, The MathWorks, Inc.

%% Introduction to using LASSO 
% This demo explains how to start using the lasso functionality introduced
% in R2011b. It is motivated by an example in Tibshiranis original paper
% on the lasso. 

% Tibshirani, R. (1996). Regression shrinkage and selection via the lasso. 
% J. Royal. Statist. Soc B., Vol. 58, No. 1, pages 267-288).

% The data set that were working with in this demo is a wide
% dataset with correlated variables. This data set includes 8 different
% variables and only 20 observations. 5 out of the 8 variables have
% coefficients of zero. These variables have zero impact on the model. The
% other three variables have non negative values and impact the model

%% Clean up workspace and set random seed

Y = [ 1; 2];
X = [ 1, 2; 2, 2];

w = lasso(X, Y);


X = randn(100,5);
r = [0;2;0;-3;0]; % only two nonzero coefficients
Y = X*r + randn(100,1)*.1; % small added noise

B = lasso(X,Y);
[r,c] = size(B);
B(:,25)

