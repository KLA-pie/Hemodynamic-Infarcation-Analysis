clear
close all
clc
load('heart1.csv')
rng(105)
heart1randomized = heart1(randperm(size(heart1, 1)), :);
train_data = heart1randomized(1:512,[1,4:13]);
test_data = heart1randomized(513:1024,[1,4:13]);

train_boolean = heart1randomized(1:512,3);
test_boolean = heart1randomized(513:1024,3);
for ii = 1:512
    if test_boolean(ii) ~= 0
        test_boolean(ii) = 1;
    end
    if train_boolean(ii) ~= 0
        train_boolean(ii) = 1;
    end
end

Weighted_Characteristics = train_data'*train_data\train_data'*train_boolean;
Hypothesized_Train_Values = train_data*Weighted_Characteristics;

train_Correctness = mean((Hypothesized_Train_Values > 0.61 == train_boolean));
Hypothesized_Test_Values = test_data*Weighted_Characteristics;
test_Correctness = mean((Hypothesized_Test_Values > 0.61 == train_boolean));