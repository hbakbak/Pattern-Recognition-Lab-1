function [Vec,Val,theta] = stdev_contour(sigma)
    [Vec,Val] = eig(sigma);
    theta = atan(Vec(1,2)/Vec(1,1)); %finding the angle to orient the axes 
end