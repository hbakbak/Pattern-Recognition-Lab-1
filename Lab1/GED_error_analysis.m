%% GED/MICD
disp('GED Error analysis:');

%% Case 1:

% Error for GED/MICD on class A samples
[TA, FA] = get_error(N_a, ged_err(mu_a', sigma_a, mu_b', sigma_b, class_a), @(d) d < 0);
[TB, FB] = get_error(N_b, ged_err(mu_a', sigma_a, mu_b', sigma_b, class_b), @(d) d > 0);

% Join both arrays to form confusion matrix
AB_GED_conf_matrix = [
    [TA, FB];
    [FA, TB];
];
disp('Confusion matrix for AB_GED:');
disp(AB_GED_conf_matrix);

P_e_AB_GED = (FA + FB)/(N_a + N_b);
disp('P(e) for AB_GED:');
disp(P_e_AB_GED);

%% Case 2:
% Note it has the same structure as MED_error_analysis but just calling the
% ged func instead

GED_C_cd = ged_err(mu_c', sigma_c, mu_d', sigma_d, class_c);
GED_C_de = ged_err(mu_d', sigma_d, mu_e', sigma_e, class_c);
GED_C_ec = ged_err(mu_e', sigma_e, mu_c', sigma_c, class_c);

GED_D_cd = ged_err(mu_c', sigma_c, mu_d', sigma_d, class_d);
GED_D_de = ged_err(mu_d', sigma_d, mu_e', sigma_e, class_d);
GED_D_ec = ged_err(mu_e', sigma_e, mu_c', sigma_c, class_d);

GED_E_cd = ged_err(mu_c', sigma_c, mu_d', sigma_d, class_e);
GED_E_de = ged_err(mu_d', sigma_d, mu_e', sigma_e, class_e);
GED_E_ec = ged_err(mu_e', sigma_e, mu_c', sigma_c, class_e);

TC = 0;
TD = 0;
TE = 0;
TC_FD = 0;
TC_FE = 0;
TD_FC = 0;
TD_FE = 0;
TE_FC = 0;
TE_FD = 0;

for i = 1:length(class_c)
   class = classifyPoint(GED_C_cd(i), GED_C_de(i), GED_C_ec(i));
   if class == 1 % Class C
       TC = TC + 1;
   elseif class == 2 % Class D
       TC_FD = TC_FD + 1;
   elseif class == 3 % Class E
       TC_FE = TC_FE + 1;
   end
end

for i = 1:length(class_d)
   class = classifyPoint(GED_D_cd(i), GED_D_de(i), GED_D_ec(i));
   if class == 1 % Class C
       TD_FC = TD_FC + 1;
   elseif class == 2 % Class D
       TD = TD + 1;
   elseif class == 3 % Class E
       TD_FE = TD_FE + 1;
   end
end

for i = 1:length(class_e)
   class = classifyPoint(GED_E_cd(i), GED_E_de(i), GED_E_ec(i));
   if class == 1 % Class C
       TE_FC = TE_FC + 1;
   elseif class == 2 % Class D
       TE_FD = TE_FD + 1;
   elseif class == 3 % Class E
       TE = TE + 1;
   end
end

% Form confusion matrix
CDE_GED_conf_matrix = [
    [TC, TC_FD, TC_FE];
    [TD_FC, TD, TD_FE];
    [TE_FC, TE_FD, TE];
];
disp('Confusion matrix for CDE_GED:');
disp(CDE_GED_conf_matrix);
P_e_CDE_GED = (TC_FD + TC_FE + TD_FC + TD_FE + TE_FC + TE_FD)/(N_c + N_d + N_e);
disp('P(e) for CDE_GED:');
disp(P_e_CDE_GED);