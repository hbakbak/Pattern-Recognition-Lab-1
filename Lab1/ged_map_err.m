% Generalized Euclidian Distance Function with priori probabilites
% % Returns the discriminant functions for the two classes

function [discriminant] = ged_map_err(mu1, cov1,N_1, mu2, cov2, N_2, X)
% %
discriminant = zeros(length(X), 1);
% The two posteriors
P1 = N_1/(N_1 + N_2);
P2 = N_2/(N_1 + N_2);

Q0 = inv(cov1) - inv(cov2);
Q1 = 2*((mu2*inv(cov2)) - (mu1*inv(cov1)));
Q2 = (mu1*inv(cov1)*mu1') - (mu2*inv(cov2)*mu2');
Q3 = log(P2/P1);
Q4 = log(det(cov1)/det(cov2));

for i = 1:size(X,1)
    coor = X(i,:);
    discriminant(i) = coor*Q0*coor' + Q1*coor' + Q2 + 2*Q3 + Q4;
end
end