% Normal Distribution class function
% 
% INPUTS: 
% N - The number of data points
% mu - 2x1 vector - the mean of the random variable
% sigma - 2x2 matrix - the covariance matrix of the random variable
% 
% 
% This function returns a correlated sample matrix

function normed_class = normal_distribution(N, mu , sigma)
    normed_class = repmat(mu',[N , 1]) + randn(N , 2) * chol(sigma);
end