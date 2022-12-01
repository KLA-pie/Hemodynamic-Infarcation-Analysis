load('heart1.csv')
rng(105)
heart1randomized = heart1(randperm(size(heart1, 1)), :);
train_data = heart1randomized(1:512,[1,4:13]);
test_data = heart1randomized(513:1024,[1,4:13]);

train_boolean = heart1randomized(1:512,[1,4:13]);
test_boolean = heart1randomized(513:1024,[1,4:13]);