% Generalized Euclidian Distance Function
% % Returns the discriminant functions for the two classes
function [discriminant] = ged(X,Y, mu1, cov1, mu2, cov2)
%   Calculate discriminant values for mesh grid 
discriminant = zeros(size(X,1), size(Y,2));
for i = 1:size(X, 1) 
    for j = 1:size(Y,2)
        coor = [X(i,j) Y(i,j)];
        discriminant(i,j) = ( (coor - mu1) * inv(cov1)* (coor - mu1)' ) - ( (coor - mu2) * inv(cov2)* (coor - mu2)' );
    end
end
end