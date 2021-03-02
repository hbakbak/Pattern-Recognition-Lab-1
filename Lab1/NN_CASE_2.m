function [NN_boundary] = NN_CASE_2(k, sampleA, sampleB, sampleC, X1, Y1)
%for a given point you wish to classify, compute the distance between that sample
%point and all labeled samples, and assign the point the same class as its
%nearest neighbour. 

%CASE 2

  NN_boundary = zeros(size(X1,1),size(Y1,2));
for i = 1:size(X1, 1) 
    for j = 1:size(X1, 2)
        %find distances for each sample 
    
        point = [X1(i,j) Y1(i,j)];
         sample_distance_A = distance_sample(sampleA, point); 
        sample_distance_B = distance_sample(sampleB, point); 
        sample_distance_C = distance_sample(sampleC, point);
        %---------------------------------------------
        %classify each point
        sample_distance_A2 = sort(sample_distance_A);
        sample_distance_B2 = sort(sample_distance_B);
        sample_distance_C2 = sort(sample_distance_C);
        if k==1
            if sample_distance_A2(1,1) < sample_distance_B2(1,1)
                NN_boundary(i,j) = 0;
             if sample_distance_A2(1,1) > sample_distance_C2(1,1)
                 NN_boundary(i,j) = 2;
             end
            else
                NN_boundary(i,j) = 1;
                if sample_distance_B2(1,1) > sample_distance_C2(1,1)
                    NN_boundary(i,j) = 2;
                end
            end
             if sample_distance_A2(1,1) < sample_distance_B2(1,1)
                    NN_boundary(i,j) = 0;
             else
                    NN_boundary(i,j) = 1;
             end
         else 
             sampleA_mean = mean(sample_distance_A(1:k, 1));
             sampleB_mean = mean(sample_distance_B(1:k, 1));
             sampleC_mean = mean(sample_distance_C(1:k, 1));
             if sampleA_mean < sampleB_mean
                 NN_boundary(i,j) = 0;
                 if sampleA_mean > sampleC_mean
                     NN_boundary(i,j) = 2;
                 end
             else
                 NN_boundary(i,j) = 1;
                 if sampleB_mean > sampleC_mean
                     NN_boundary(i,j) = 2;
                 end
             end
        end
        
    end
end
end

