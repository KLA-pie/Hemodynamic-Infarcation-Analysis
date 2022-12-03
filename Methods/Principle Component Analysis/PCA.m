clear
close all
clc
load('heart1.csv')
rng(105)
heart1randomized = heart1(randperm(size(heart1, 1)), :);
train_data = heart1randomized(1:512,[1,3:13]);
test_data = heart1randomized(513:1024,[1,3:13]);

train_boolean = heart1randomized(1:512,14);
test_boolean = heart1randomized(513:1024,14);
Weighted_Characteristics = train_data'*train_data\train_data'*train_boolean;
Hypothesized_Train_Values = train_data*Weighted_Characteristics;

train_Correctness = mean((Hypothesized_Train_Values > 0.61 == train_boolean));
Hypothesized_Test_Values = test_data*Weighted_Characteristics;
test_Correctness = mean((Hypothesized_Test_Values > 0.61 == train_boolean));

mean_cholesterol = 220;
std_cholesterol = 20; % https://www.researchgate.net/publication/8007359_Cutoff_Point_Separating_Affected_and_Unaffected_Familial_Hypercholesterolemic_Patients_Validated_by_LDL-receptor_Gene_Mutants
mean_blood_sugar = 100;
std_blood_sugar = 12.5;

Velocity = 0.3*heart1randomized(:,8)./heart1randomized(:,4);
CholesterolZScore = (heart1randomized(:,5)-mean_cholesterol)/std_cholesterol;
Densities = zeros(1025,1);
for ii = 1:1025
    if heart1randomized(ii,6) == 1
        Densities(ii) = 2.81*0.032+0.994;
    else
        Densities(ii) = 0.994;
    end
end
Densities = Densities*1000;
max(CholesterolZScore)
Pressure = heart1randomized(:,4)*133.32;
Viscosity = normrnd(.45,.1,1025,1)/1000;
Init_Cond = [Velocity,Densities,Pressure,Viscosity];
train_cond = Init_Cond(1:512,:);
test_cond = Init_Cond(513:1024,:);
Selected_Train_Points = randi([1,512],32,1);
Selected_Test_Points = randi([513,1024],32,1);
Selected_train_conds = zeros(32,4);
Selected_test_conds = zeros(32,4);
for ii = 1:32
    Selected_train_conds(ii,:) = Init_Cond(Selected_Train_Points(ii),:);
    Selected_test_conds(ii,:) = Init_Cond(Selected_Test_Points(ii),:);
end

Sample_Train_Boolean = heart1randomized(Selected_Train_Points,14);
Sample_Test_Boolean = heart1randomized(Selected_Test_Points,14);