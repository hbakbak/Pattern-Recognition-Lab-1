%% MED
disp('MED Error analysis:');

%% Case 1: 

% MED Discriminant values for class A samples
classA_disc = MED_dis_err(mu_a', mu_b', class_a);

% Get error for MED on class A samples
[TA, FA] = get_error(N_a, classA_disc, @(d) d < 0);

% Error for MED on class B samples (1 line)
[TB, FB] = get_error(N_b, MED_dis_err(mu_a', mu_b', class_b), @(d) d > 0);

% Join both arrays to form confusion matrix
AB_MED_conf_matrix = [
    [TA, FB];
    [FA, TB];
];
disp('Confusion matrix for AB_MED:');
disp(AB_MED_conf_matrix);

P_e_AB_MED = (FA + FB)/(N_a + N_b);
disp('P(e) for AB_MED:');
disp(P_e_AB_MED);

%% Case 2:
MED_C_cd = MED_dis_err(mu_c', mu_d', class_c);
MED_C_de = MED_dis_err(mu_d', mu_e', class_c);
MED_C_ec = MED_dis_err(mu_e', mu_c', class_c);

MED_D_cd = MED_dis_err(mu_c', mu_d', class_d);
MED_D_de = MED_dis_err(mu_d', mu_e', class_d);
MED_D_ec = MED_dis_err(mu_e', mu_c', class_d);

MED_E_cd = MED_dis_err(mu_c', mu_d', class_e);
MED_E_de = MED_dis_err(mu_d', mu_e', class_e);
MED_E_ec = MED_dis_err(mu_e', mu_c', class_e);

TC = 0;
TD = 0;
TE = 0;

TC_FD = 0;
TC_FE = 0;

TD_FC = 0;
TD_FE = 0;

TE_FC = 0;
TE_FD = 0;

% Confusion matrix of the form:
%       Predicted:    C       D     E
% Actual:         C [ TC   TC_FD  TC_FE ]
%                 D [ TD_FC   TD  TD_FE ]
%                 E [ TE_FC TE_FD    TE ]

for i = 1:length(class_c)
   class = classifyPoint(MED_C_cd(i), MED_C_de(i), MED_C_ec(i));
   if class == 1 % Class C
       TC = TC + 1;
   elseif class == 2 % Class D
       TC_FD = TC_FD + 1;
   elseif class == 3 % Class E
       TC_FE = TC_FE + 1;
   end
end

for i = 1:length(class_d)
   class = classifyPoint(MED_D_cd(i), MED_D_de(i), MED_D_ec(i));
   if class == 1 % Class C
       TD_FC = TD_FC + 1;
   elseif class == 2 % Class D
       TD = TD + 1;
   elseif class == 3 % Class E
       TD_FE = TD_FE + 1;
   end
end

for i = 1:length(class_e)
   class = classifyPoint(MED_E_cd(i), MED_E_de(i), MED_E_ec(i));
   if class == 1 % Class C
       TE_FC = TE_FC + 1;
   elseif class == 2 % Class D
       TE_FD = TE_FD + 1;
   elseif class == 3 % Class E
       TE = TE + 1;
   end
end

% Form confusion matrix
CDE_MED_conf_matrix = [
    [TC, TC_FD, TC_FE];
    [TD_FC, TD, TD_FE];
    [TE_FC, TE_FD, TE];
];
disp('Confusion matrix for CDE_MED:');
disp(CDE_MED_conf_matrix);
P_e_CDE_MED = (TC_FD + TC_FE + TD_FC + TD_FE + TE_FC + TE_FD)/(N_c + N_d + N_e);
disp('P(e) for CDE_MED:');
disp(P_e_CDE_MED);