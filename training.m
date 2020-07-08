clear ; close all; clc

X = xlsread('input.xlsx'); y = xlsread('output of p300.xlsx');




[m, n] = size(X);
X = [ones(m, 1) X];
%X = [ones(m, 1) X];
%initial_theta = zeros(n + 1, 3);
theta = zeros(3,1)
m = length(y); % number of training examples
i = 0;
iterations = 1000;
lr = 0.1;
g = 0;
J = 0; % dayman lazem 76 8eyam 2waliee 9efer
grad = zeros(size(theta));  % dayman lazem 76 8eyam 2waliee 9efer
for i = 1:iterations
    i = i+1
    g = sigmoid(X*theta);
    % hal2 bedy 27sob al cost function yly howe 3ebara 3n logcost function ( there is a lot of types of cost functions depends of the goal of the application[ classification of regression] and with a classification problem we use logcost .. with regression we use another cost functions )
    J = mean((-y).* log(g)- (1-y).* log(1 - g));

    grad = 1/m * X' * ( g - y);
    theta = theta + lr*grad;
end
