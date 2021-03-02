% As NN, 5NN are a function of the individual data points, you will need to generate separate training and testing sets.
%% NN
disp('NN Error analysis:');

% Generate seperating test set
classA_test = normal_distribution(N_a,mu_a, sigma_a);
classB_test = normal_distribution(N_b,mu_b, sigma_d);
classC_test = normal_distribution(N_c,mu_c, sigma_c);
classD_test = normal_distribution(N_d,mu_d, sigma_d);
classE_test = normal_distribution(N_e,mu_e, sigma_e);

% Generate seperating training set
classA_test_classifier = NN_kNN(1,classA_test(:,1),classA_test(:,2),class_a,class_b);
classB_test_classifier = NN_kNN(1,classB_test(:,1),classB_test(:,2),class_a,class_b);
classC_test_classifier = NN_kNN(1,classC_test(:,1),classC_test(:,2),class_c,class_d,class_e);
classD_test_classifier = NN_kNN(1,classD_test(:,1),classD_test(:,2),class_c,class_d,class_e);
classE_test_classifier = NN_kNN(1,classE_test(:,1),classE_test(:,2),class_c,class_d,class_e);

% Compute Confusion matrix for case 1 and 2 respectively
[AB_NN_conf_matrix] = get_NN_confusion_matrix_c1(classA_test_classifier,classB_test_classifier);
[CDE_NN_conf_matrix] = get_NN_confusion_matrix_c2(classC_test_classifier,classD_test_classifier,classE_test_classifier);

% Probability of Error (P(E)) for case 1 and 2 respectively
P_e_AB_NN = (AB_NN_conf_matrix(1,2) + AB_NN_conf_matrix(2,1))/(N_a + N_b);
P_e_CDE_NN = (CDE_NN_conf_matrix(1,2) + CDE_NN_conf_matrix(1,3) + ... 
    CDE_NN_conf_matrix(2,1) + CDE_NN_conf_matrix(2,3) + ... 
    CDE_NN_conf_matrix(3,1) + CDE_NN_conf_matrix(3,2))/...
    (N_c + N_d + N_e);

%% Print Error Analysis for NN
disp('Case 1 NN:');
disp('Confusion matrix for AB_NN:');
disp(AB_NN_conf_matrix);

disp('P(e) for AB_NN:');
disp(P_e_AB_NN);

disp('Case 2 NN:');
disp('Confusion matrix for CDE_NN:');
disp(CDE_NN_conf_matrix);

disp('P(e) for CDE_NN:');
disp(P_e_CDE_NN);

%% kNN
disp('kNN Error analysis:');

% Generate seperating test set
classA_test = normal_distribution(N_a,mu_a, sigma_a);
classB_test = normal_distribution(N_b,mu_b, sigma_d);
classC_test = normal_distribution(N_c,mu_c, sigma_c);
classD_test = normal_distribution(N_d,mu_d, sigma_d);
classE_test = normal_distribution(N_e,mu_e, sigma_e);

% Generate seperating training set
classA_test_kNN_classifier = NN_kNN(5,classA_test(:,1),classA_test(:,2),class_a,class_b);
classB_test_kNN_classifier = NN_kNN(5,classB_test(:,1),classB_test(:,2),class_a,class_b);
classC_test_kNN_classifier = NN_kNN(5,classC_test(:,1),classC_test(:,2),class_c,class_d,class_e);
classD_test_kNN_classifier = NN_kNN(5,classD_test(:,1),classD_test(:,2),class_c,class_d,class_e);
classE_test_kNN_classifier = NN_kNN(5,classE_test(:,1),classE_test(:,2),class_c,class_d,class_e);

% Compute Confusion matrix for case 1 and 2 respectively
[AB_kNN_conf_matrix] = get_NN_confusion_matrix_c1(classA_test_kNN_classifier,classB_test_kNN_classifier);
[CDE_kNN_conf_matrix] = get_NN_confusion_matrix_c2(classC_test_kNN_classifier,classD_test_kNN_classifier,classE_test_kNN_classifier);

% Probability of Error (P(E)) for case 1 and 2 respectively
P_e_AB_kNN = (AB_kNN_conf_matrix(1,2) + AB_kNN_conf_matrix(2,1))/(N_a + N_b);
P_e_CDE_kNN = (CDE_kNN_conf_matrix(1,2) + CDE_kNN_conf_matrix(1,3) + ... 
    CDE_kNN_conf_matrix(2,1) + CDE_kNN_conf_matrix(2,3) + ... 
    CDE_kNN_conf_matrix(3,1) + CDE_kNN_conf_matrix(3,2))/...
    (N_c + N_d + N_e);

%% Print Error Analysis for NN
disp('Case 1 kNN:');
disp('Confusion matrix for AB_kNN:');
disp(AB_kNN_conf_matrix);

disp('P(e) for AB_kNN:');
disp(P_e_AB_kNN);

disp('Case 2 kNN:');
disp('Confusion matrix for CDE_kNN:');
disp(CDE_kNN_conf_matrix);

disp('P(e) for CDE_kNN:');
disp(P_e_CDE_kNN);
%% Recall 0 = A, 1 = B
function [confusion_matrix] = get_NN_confusion_matrix_c1(a,b)
   [TA,FA] = get_error(length(a),a, @(d) d == 0);
   [TB,FB] = get_error(length(b),b, @(d) d == 0);
   confusion_matrix = [
    [TA, FA];
    [TB, FB];
    ];
end
%% Recall % 0 = C, 1 = D, 2 = E
function [confusion_matrix] = get_NN_confusion_matrix_c2(c,d,e)
   TC = length(find(c==0));
   TC_FD = length(find(c==1));
   TC_FE = length(find(c==2));
   TD_FC = length(find(d==0));
   TD = length(find(d==1));
   TD_FE = length(find(d==2));
   TE_FC = length(find(e==0));
   TE_FD = length(find(e==1));
   TE = length(find(e==2));

confusion_matrix = ...
    [TC, TC_FD, TC_FE; 
     TD_FC, TD, TD_FE;
     TE_FC, TE_FD, TE];

end