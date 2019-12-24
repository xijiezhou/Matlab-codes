function beta = ols_beta (z,X,Y)
if z ~= 0
    X = [ones(numel(X(:,1)),1) X];
end
beta = inv(X'*X)*X'*Y;