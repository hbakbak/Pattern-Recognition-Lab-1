function [T,F] = get_error(num_samples,dist,compare_condition)
%GET_ERROR Compute error of classifier b/w 2 classes
%   Returns array of correct hits and false hits
T = 0;
for i=1:length(dist)
    point = dist(i);
    if compare_condition(point)
        T = T + 1;
    end
end
F = num_samples - T;

