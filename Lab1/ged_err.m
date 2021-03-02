function [disc] = ged_err(mu1, cov1, mu2, cov2, X)
%UNTITLED10 Summary of this function goes here
%   Calculate discriminant for class of samples

% Same as ged but with only X, not Y
disc = zeros(length(X), 1);
for i = 1:size(X, 1)
    coor = X(i,:);
    disc(i) = ( (coor - mu1) * inv(cov1)* (coor - mu1)' ) - ( (coor - mu2) * inv(cov2)* (coor - mu2)' );
end
end
