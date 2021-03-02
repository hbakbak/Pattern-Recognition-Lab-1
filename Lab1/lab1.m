% SYDE Lab 1 - Clusters and Classification Boundaries
% Names and IDs: M. Musaab Siddiqui  20706799
%                Haneen Bakbak 
%                Michelle Watson 20786347
% Last Updated : Feb. 26, 2021

clear all % clears all variable from memory
close all % closes all open figures

%% Initializing the sample size, mean and the variance of five classes
% Class A
N_a = 200;
mu_a = [5 10]';
sigma_a = [8 0; 0 4];

% Class B
N_b = 200;
mu_b = [10 15]';
sigma_b = [8 0; 0 4];

% Class C
N_c = 100;
mu_c = [5 10]';
sigma_c = [8 4; 4 40];

% Class D
N_d = 200;
mu_d = [15 10]';
sigma_d = [8 0; 0 8];

% Class E
N_e = 150;
mu_e = [10 5]';
sigma_e = [10 -5; -5 20];

%% produce a normally distributed data  
class_a = normal_distribution(N_a , mu_a , sigma_a);
class_b = normal_distribution(N_b , mu_b , sigma_b);
class_c = normal_distribution(N_c , mu_c , sigma_c);
class_d = normal_distribution(N_d , mu_d , sigma_d);
class_e = normal_distribution(N_e , mu_e , sigma_e);

%% create a standard deviation contour 
[Vec_a , Val_a , theta_a] = stdev_contour(sigma_a);
[Vec_b , Val_b , theta_b] = stdev_contour(sigma_b);
[Vec_c , Val_c , theta_c] = stdev_contour(sigma_c);
[Vec_d , Val_d , theta_d] = stdev_contour(sigma_d);
[Vec_e , Val_e , theta_e] = stdev_contour(sigma_e);

%% Generate mesh grids 
    % Case 1
x = min([class_a(:,1);class_b(:,1)])-1:0.1:max([class_a(:,1);class_b(:,1)])+1;
y = min([class_a(:,2);class_b(:,2)])-1:0.1:max([class_a(:,2);class_b(:,2)])+1;
[X1, Y1] = meshgrid(x, y);
    % Case 2
x = min([class_c(:,1);class_d(:,1);class_e(:,1)])-1:0.1:max([class_c(:,1);class_d(:,1);class_e(:,1)])+1;
y = min([class_c(:,2);class_d(:,2);class_e(:,2)])-1:0.1:max([class_c(:,2);class_d(:,2);class_e(:,2)])+1;
[X2, Y2] = meshgrid(x, y);

%% Classifiers for Case 1

% MED 
MED_CASE_1 = zeros(size(X1,1), size(Y1,2)); 
MED_dis_1 = MED_dis(X1,Y1,mu_a',mu_b');
for i =1:size(X1,1)
    for j=1:size(Y1,2)
        if MED_dis_1(i,j) >= 0 
            MED_CASE_1(i,j) = 1;
        elseif MED_dis_1(i,j) <=0 
            MED_CASE_1(i,j) = 2; 
        else 
            disp('uh oh...')
        end
    end
end

% GED/MICD
micd_1 = zeros(size(X1,1), size(Y1,2)); 
ged_1 = ged( X1, Y1, mu_a', sigma_a , mu_b', sigma_b);
for i = 1:size(X1,1)
    for j = 1:size(Y1,2)
        if ged_1(i,j) >= 0 
            micd_1(i,j) = 1;
        elseif ged_1(i,j) <= 0 
            micd_1(i,j) = 2; 
        else 
            disp('uh oh...')
        end
    end
end

% MAP
map_1 = zeros(size(X1,1), size(Y1,2)); 
ged_map_1 = ged_map( X1, Y1, mu_a', sigma_a , N_a , mu_b', sigma_b, N_b);
for i = 1:size(X1,1)
    for j = 1:size(Y1,2)
        if ged_map_1(i,j) >= 0 
            map_1(i,j) = 1;
        elseif ged_map_1(i,j) <= 0 
            map_1(i,j) = 2; 
        else 
            disp('uh oh...')
        end
    end
end

% NN
NN1_1 = NN_kNN(1,X1,Y1, class_a, class_b);

% kNN
kNN5_1 = NN_kNN(5,X1,Y1, class_a, class_b);
%% Plots for Case 1: section 2 Clusters
figure(1) % Section 2: Sample and unit standard deviation contour of Class A and Class B
hold on
% plotting all the figures
a_scatter = scatter(class_a(:,1) , class_a(:,2), 'rx');
b_scatter = scatter(class_b(:,1) , class_b(:,2), 'ko');

% plotting unit stdev contour/ellipse for case 1
plt_stdev_contour(mu_a, theta_a, Val_a , 'r');
plt_stdev_contour(mu_b, theta_b, Val_b , 'k');

% Save fig for section 2
title('Sample contours for Class A and Class B');
legend({'Class A', 'Class B'}, 'location' , 'southeast');
xlabel('x1')
ylabel('x2')
savefig(strcat('AB_ClusterContour','.fig')); 
hold off
%% Plots for Case 1: section 3 Classifiers (1)
figure(2) % MAP, MICD , MED
hold on
% plotting all the figures
a_scatter = scatter(class_a(:,1) , class_a(:,2), 'rx');
b_scatter = scatter(class_b(:,1) , class_b(:,2), 'ko');

% Contour plots for the classifiers - MED, GED, MAP
contour(X1, Y1, MED_CASE_1, 'c');
contour(X1, Y1, micd_1, 'm'); % GED, under MAP
contour(X1, Y1, map_1, 'g--');

% plotting unit stdev contour/ellipse for case 1
plt_stdev_contour(mu_a, theta_a, Val_a , 'r');
plt_stdev_contour(mu_b, theta_b, Val_b , 'k');

title('Sample contours for Class A and Class B - MED, GED, MAP');
legend({'Class A', 'Class B' , 'MED', 'GED', 'MAP'}, 'location' , 'southeast');
xlabel('x1')
ylabel('x2')
savefig(strcat('AB_MED_MICD_MAP','.fig'));
hold off

%% Plots for Case 1: section 3 Classifiers (2)
figure(3) % NN, kNN
hold on
% plotting all the figures
a_scatter = scatter(class_a(:,1) , class_a(:,2), 'rx');
b_scatter = scatter(class_b(:,1) , class_b(:,2), 'ko');

% Contour plots for the classifiers - NN, kNN
contour(X1, Y1, NN1_1, 'c');
contour(X1, Y1, kNN5_1, 'm');

% plotting unit stdev contour/ellipse for case 1
plt_stdev_contour(mu_a, theta_a, Val_a , 'r');
plt_stdev_contour(mu_b, theta_b, Val_b , 'k');

title('Sample contours for Class A and Class B - NN, kNN');
legend({'Class A', 'Class B', 'NN', 'kNN (k=5)'}, 'location' , 'southeast');
xlabel('x1')
ylabel('x2')
savefig(strcat('AB_NN_kNN','.fig'));
hold off

%% Classifiers for Case 2

% MED
cd = MED_dis(X2,Y2,mu_c',mu_d');
de = MED_dis(X2,Y2,mu_d',mu_e');
ec = MED_dis(X2,Y2,mu_e',mu_c');

MED_CASE_2 = zeros(size(X2,1), size(Y2,2)); 

for i = 1:size(X2, 1) 
    for j= 1: size(Y2,2)
        if (cd(i,j) >= 0) && (de(i,j) <= 0) 
            MED_CASE_2(i,j) = 2;
        elseif (cd(i,j) <= 0) && (ec(i,j) >= 0)
            MED_CASE_2(i,j) = 1;
        elseif (ec(i,j) <= 0) && (de(i,j) >= 0)  
            MED_CASE_2(i,j) = 3;
        else
            disp('uh oh...')
        end
    end
end

% GED/MICD
micd_2 = zeros(size(X2,1), size(Y2,2)); 
ged_cd = ged(X2,Y2,mu_c',sigma_c,mu_d', sigma_d);
ged_de = ged(X2,Y2,mu_d',sigma_d,mu_e', sigma_e);
ged_ec = ged(X2,Y2,mu_e', sigma_e,mu_c', sigma_c);

for i = 1:size(X2, 1) 
    for j= 1:size(Y2,2)
        if ged_cd(i,j) >= 0 && ged_de(i,j) <= 0 
            micd_2(i,j) = 1;
        elseif ged_cd(i,j) <= 0 && ged_ec(i,j) >= 0
            micd_2(i,j) = 2;
        elseif ged_ec(i,j) <= 0 && ged_de(i,j) >= 0  
            micd_2(i,j) = 3;
        else
            disp('uh oh...')
        end
    end
end

% MAP
map_2 = zeros(size(X2,1), size(Y2,2)); 
ged_map_cd = ged_map(X2,Y2,mu_c', sigma_c , N_c ,mu_d', sigma_d , N_d );
ged_map_de = ged_map(X2,Y2,mu_d', sigma_d , N_d ,mu_e', sigma_e , N_e );
ged_map_ec = ged_map(X2,Y2,mu_e', sigma_e , N_e ,mu_c', sigma_c , N_c );

for i = 1:size(X2, 1) 
    for j= 1: size(Y2,2)
        if ged_map_cd(i,j) >= 0 && ged_map_de(i,j) <= 0 
            map_2(i,j) = 1;
        elseif ged_map_cd(i,j) <= 0 && ged_map_ec(i,j) >= 0
            map_2(i,j) = 2;
        elseif ged_map_ec(i,j) <= 0 && ged_map_de(i,j) >= 0  
            map_2(i,j) = 3;
        else
            disp('uh oh...')
        end
    end
end

% NN
NN1_2 = NN_kNN(1,X2,Y2, class_c, class_d, class_e);

% kNN
kNN5_2 = NN_kNN(5,X2,Y2, class_c, class_d, class_e);
%% Plots for Case 1: section 2 Clusters
figure(4) % Section 2: Sample and unit standard deviation contour of Class C, D, E
hold on
% plotting all the figures
c_scatter = scatter(class_c(:,1) , class_c(:,2), 'rx');
d_scatter = scatter(class_d(:,1) , class_d(:,2), 'kv');
e_scatter = scatter(class_e(:,1) , class_e(:,2), 'b+');

% plotting unit stdev contour/ellipse for case 2
plt_stdev_contour(mu_c, theta_c, Val_c , 'r');
plt_stdev_contour(mu_d, theta_d, Val_d , 'k');
plt_stdev_contour(mu_e, theta_e, Val_e , 'b');

title('Sample contours for Class C, Class D and Class E');
legend({'Class C', 'Class D', 'Class E'}, 'location' , 'southeast');
xlabel('x1')
ylabel('x2')

% Save fig for section 2
savefig(strcat('CDE_ClusterContour','.fig')); 
hold off

%% Plots for Case 2: section 3 Classifiers (1)
figure(5) % MAP, MICD , MED
hold on
% plotting all the figures
c_scatter = scatter(class_c(:,1) , class_c(:,2), 'rx');
d_scatter = scatter(class_d(:,1) , class_d(:,2), 'kv');
e_scatter = scatter(class_e(:,1) , class_e(:,2), 'b+');

% Plotting the contours - MED, GED, MAP
contour(X2, Y2, MED_CASE_2, 'c');
contour(X2, Y2, micd_2, 'm');
contour(X2, Y2, map_2, 'g');

% plotting unit stdev contour/ellipse for case 2
plt_stdev_contour(mu_c, theta_c, Val_c , 'r');
plt_stdev_contour(mu_d, theta_d, Val_d , 'k');
plt_stdev_contour(mu_e, theta_e, Val_e , 'b');

title('Sample contours for Class C, D, E -  MED, MICD, MAP');
legend({'Class C', 'Class D', 'Class E', 'MED','GED', 'MAP'}, 'location' , 'southeast');
xlabel('x1')
ylabel('x2')

% Save fig for section 3
savefig(strcat('CDE_MED_MICD_MAP','.fig')); 
hold off

%% Plots for Case 2: section 3 Classifiers (2)
figure(6) % NN, kNN
hold on

% plotting all the figures
c_scatter = scatter(class_c(:,1) , class_c(:,2), 'rx');
d_scatter = scatter(class_d(:,1) , class_d(:,2), 'kv');
e_scatter = scatter(class_e(:,1) , class_e(:,2), 'b+');

% Contour plots for the classifiers - NN, kNN
contour(X2, Y2, NN1_2, 'c');
contour(X2, Y2, kNN5_2, 'm');

% plotting unit stdev contour/ellipse for case 1
plt_stdev_contour(mu_c, theta_c, Val_c , 'r');
plt_stdev_contour(mu_d, theta_d, Val_d , 'k');
plt_stdev_contour(mu_e, theta_e, Val_e , 'b');

title('Sample contours for Class C, D, E - NN, kNN');
legend({'Class C', 'Class D', 'Class E', 'NN', 'kNN (k=5)'}, 'location' , 'southeast');
xlabel('x1')
ylabel('x2')
savefig(strcat('CDE_NN_kNN','.fig'));
hold off

%% 5: Error Analysis
MED_error_analysis;
GED_error_analysis;
MAP_error_analysis;
NN_error_analysis;