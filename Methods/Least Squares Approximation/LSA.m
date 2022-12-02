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