%% MAP
disp('MAP Error analysis:');
% Note it has the same structure as the other error analysis *.m so I will use less comments

%% Case 1:

% Error for MAP on class A samples
[TA, FA] = get_error(N_a, ged_map_err(mu_a', sigma_a, N_a, mu_b', sigma_b, N_b, class_a), @(d) d < 0);
[TB, FB] = get_error(N_b, ged_map_err(mu_a', sigma_a, N_a, mu_b', sigma_b, N_b, class_b), @(d) d > 0);

% Confusion matrix
AB_MAP_conf_matrix = [
    [TA, FB];
    [FA, TB];
];
disp('Confusion matrix for AB_MAP:');
disp(AB_MAP_conf_matrix);

% Experimental error rate
P_e_AB_MAP = (FA + FB)/(N_a + N_b);
disp('P(e) for AB_MAP:');
disp(P_e_AB_MAP);

% Notice that the error analysis is the same as GED/MICD bc the 2 terms
% that make MAP diff from GED are 0 here
%% Case 2:

MAP_C_cd = ged_map_err(mu_c', sigma_c, N_c, mu_d', sigma_d, N_d, class_c);
MAP_C_de = ged_map_err(mu_d', sigma_d, N_d, mu_e', sigma_e, N_e, class_c);
MAP_C_ec = ged_map_err(mu_e', sigma_e, N_e, mu_c', sigma_c, N_c, class_c);

MAP_D_cd = ged_map_err(mu_c', sigma_c, N_c, mu_d', sigma_d, N_d, class_d);
MAP_D_de = ged_map_err(mu_d', sigma_d, N_d, mu_e', sigma_e, N_e, class_d);
MAP_D_ec = ged_map_err(mu_e', sigma_e, N_e, mu_c', sigma_c, N_c, class_d);

MAP_E_cd = ged_map_err(mu_c', sigma_c, N_c, mu_d', sigma_d, N_d, class_e);
MAP_E_de = ged_map_err(mu_d', sigma_d, N_d, mu_e', sigma_e, N_e, class_e);
MAP_E_ec = ged_map_err(mu_e', sigma_e, N_e, mu_c', sigma_c, N_c, class_e);

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
   class = classifyPoint(MAP_C_cd(i), MAP_C_de(i), MAP_C_ec(i));
   if class == 1 % Class C
       TC = TC + 1;
   elseif class == 2 % Class D
       TC_FD = TC_FD + 1;
   elseif class == 3 % Class E
       TC_FE = TC_FE + 1;
   end
end

for i = 1:length(class_d)
   class = classifyPoint(MAP_D_cd(i), MAP_D_de(i), MAP_D_ec(i));
   if class == 1 % Class C
       TD_FC = TD_FC + 1;
   elseif class == 2 % Class D
       TD = TD + 1;
   elseif class == 3 % Class E
       TD_FE = TD_FE + 1;
   end
end

for i = 1:length(class_e)
   class = classifyPoint(MAP_E_cd(i), MAP_E_de(i), MAP_E_ec(i));
   if class == 1 % Class C
       TE_FC = TE_FC + 1;
   elseif class == 2 % Class D
       TE_FD = TE_FD + 1;
   elseif class == 3 % Class E
       TE = TE + 1;
   end
end

% Form confusion matrix
CDE_MAP_conf_matrix = [
    [TC, TC_FD, TC_FE];
    [TD_FC, TD, TD_FE];
    [TE_FC, TE_FD, TE];
];
disp('Confusion matrix for CDE_MAP');
disp(CDE_MAP_conf_matrix);
P_e_CDE_MAP = (TC_FD + TC_FE + TD_FC + TD_FE + TE_FC + TE_FD)/(N_c + N_d + N_e);
disp('P(e) for CDE_MAP:');
disp(P_e_CDE_MAP);