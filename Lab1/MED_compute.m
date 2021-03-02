%Compute the MED classification boundaries using the discriminant functions
%per each case


%CASE 1
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


%CASE 2
cd = MED_dis(X2,Y2,mu_c',mu_d');
de = MED_dis(X2,Y2,mu_d',mu_e');
ec = MED_dis(X2,Y2,mu_e',mu_c');

MED_CASE_2 = zeros(size(X2,1), size(Y2,2)); 

for i = 1:size(X2, 1) 
    for j=size(Y2,2)
        if cd(i,j) >= 0 && de(i,j) <= 0 
            MED_CASE_2(i,j) = 1;
        elseif cd(i,j) <= 0 && ec(i,j) >= 0
            MED_CASE_2(i,j) = 2;
        elseif ec(i,j) <= 0 && de(i,j) >= 0  
            MED_CASE_2(i,j) = 3;
        else
            disp('uh oh...')
        end
    end
end

