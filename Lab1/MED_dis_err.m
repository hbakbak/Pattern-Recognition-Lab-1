function [dist] = MED_dis_err(mu1, mu2, X)
%  MED for 2 classes
% Same as MED_dis but with only X, not Y
dist = zeros(length(X), 1);
for i = 1:size(X, 1) 
    coor = X(i,:);
    dist(i) = ( (coor - mu1) * (coor - mu1)' ) - ( (coor - mu2) * (coor - mu2)' );
end
end