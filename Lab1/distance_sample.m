function [distances] = distance_sample(sample,point)
    distances = zeros(size(sample,1),1);
    for i = 1:size(sample,1)
             x_a = sample(i,:);
            distances(i,1) = sqrt( ( x_a(1,1) - point(1,1) )^2 + ( x_a(1,2) - point(1,2) )^2 ); 
     end
end
