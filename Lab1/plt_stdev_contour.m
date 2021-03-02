function plt_stdev_contour(mu , angle , eigval , c) 
%using the plot_ellipse fn to plot the stdev contour
    plot_ellipse(mu(1), mu(2), angle, sqrt(eigval(1,1)), sqrt(eigval(2,2)), c);
end