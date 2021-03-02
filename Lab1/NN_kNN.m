function [NN_boundary] = NN_kNN(k, X1, Y1, sampleA, sampleB, sampleC)
%for a given point you wish to classify, compute the distance between that sample
%point and all labeled samples, and assign the point the same class as its
%nearest neighbour.

% Formula to calculate distance between two points

%CASE 1
NN_boundary = zeros(size(X1,1),size(Y1,2));
for i = 1:size(X1, 1)
    for j = 1:size(X1, 2)
        %find distances for each sample
        point = [X1(i,j) Y1(i,j)];
        sample_distance_A = distance_sample(sampleA, point);
        sample_distance_B = distance_sample(sampleB, point);
        %---------------------------------------------
        % classify each point
        % nargin = Number of function input arguments
        if nargin > 5
            sample_distance_C = distance_sample(sampleC,point);
            NN_boundary(i,j) = compare_distances_to_classify_pt_case2(k,sample_distance_A,sample_distance_B,sample_distance_C);
        else
            NN_boundary(i,j) = compare_distances_to_classify_pt_case1(k,sample_distance_A,sample_distance_B);
        end
    end
end
end

%% Compare distances for Case 1
% PURPOSE: Classify the unknown sample point by choosing the class of the closest point/mean.
% 0 = A, 1 = B
function class = compare_distances_to_classify_pt_case1(k,sample_distance_A_to_sort,sample_distance_B_to_sort)

% Sort the samples by distance to ensure you're comparing the unknown point
% to the nearest neighbours
sample_distance_A_sorted = sort(sample_distance_A_to_sort);
sample_distance_B_sorted = sort(sample_distance_B_to_sort);

% Check the number of neighbours. k==1 => NN
if k == 1
    % Case 1
    if sample_distance_A_sorted(1,1) < sample_distance_B_sorted(1,1)
        class = 0;
    else
        class = 1;
    end
else
    % Get mean sample prototype of kNN
    cluster_avg_A = mean(sample_distance_A_sorted(1:k,1));
    cluster_avg_B = mean(sample_distance_B_sorted(1:k,1));
    % Case 1 Classification
    if cluster_avg_A < cluster_avg_B
        class = 0;
    else
        class = 1;
    end
end

end

% 0 = C, 1 = D, 2 = E
function class = compare_distances_to_classify_pt_case2(k,sample_distance_C_to_sort,sample_distance_D_to_sort,sample_distance_E_to_sort)
% Sort the samples by distance to ensure you're comparing the unknown point
% to the nearest neighbours
sample_distance_C_sorted = sort(sample_distance_C_to_sort);
sample_distance_D_sorted = sort(sample_distance_D_to_sort);
sample_distance_E_sorted = sort(sample_distance_E_to_sort);

% Check the number of neighbours. k==1 => NN
if k == 1
    if sample_distance_C_sorted(1,1) < sample_distance_D_sorted(1,1)
        class = 0;
        if sample_distance_C_sorted(1,1) > sample_distance_E_sorted(1,1)
            class = 2;
        end
    else
        class = 1;
        if sample_distance_D_sorted(1,1) > sample_distance_E_sorted(1,1)
            class = 2;
        end
    end
    % kNN
else
    % Get mean sample prototype of kNN
    cluster_avg_C = mean(sample_distance_C_sorted(1:k,1));
    cluster_avg_D = mean(sample_distance_D_sorted(1:k,1));
    cluster_avg_E = mean(sample_distance_E_sorted(1:k,1));
    if cluster_avg_C < cluster_avg_D
        class = 0;
        if cluster_avg_C > cluster_avg_E
            class = 2;
        end
    else
        class = 1;
        if cluster_avg_D > cluster_avg_E
            class = 2;
        end
    end
end
end
