clear ; close all; clc

X = xlsread('input.xlsx'); y = xlsread('output of p300.xlsx');
x1 = X(:,1).*0.0001
x2 = X(:,2).*0.001
X = [x1,x2]
%plotData(X, y);

X = X'
y = y'

%hold on;


%xlabel('latency')
%ylabel('amplitude')



%legend('target', 'not a target')
%hold off;

%fprintf('\nProgram paused. Press enter to continue.\n');
%pause;
[m, n] = size(X);
%X = [ones(m, 1) X];
%initial_theta = zeros(n + 1, 3);
m = length(y); % number of training examples
iterations = 1000;
lr = 0.1;
g = 0;
J = 0; % dayman lazem 76 8eyam 2waliee 9efer
initial1 = rand(10,2)*0.01;
initial2 = rand(1,10)*0.01;
theta1 = initial1
theta2 = initial2
grad1 = zeros(size(theta1));  % dayman lazem 76 8eyam 2waliee 9efer
grad2 = zeros(size(theta2));
for i = 1:iterations
    z = theta1*X;
    h = tansig(z);
    g = sigmoid(theta2*h)
    % hal2 bedy 27sob al cost function yly howe 3ebara 3n logcost function ( there is a lot of types of cost functions depends of the goal of the application[ classification of regression] and with a classification problem we use logcost .. with regression we use another cost functions )
    J = mean((-y).* log(g)- (1-y).* log(1 - g));
    delta2 = ( g - y);
    %doaf = h'*(1-h) %derivite of activation function (2*2)
    %netta = theta2 * doaf %(1,2)
    %retta = ( g - y)* netta %(160,2)
    delta1 = theta2'*delta2.*(1-h.^2);%(160*2)
    grad1 = 1/m .* delta1 * X';
    grad2 = 1/m .* delta2 * h';
    theta1 = theta1 + lr*grad1;
    theta2 = theta2 + lr*grad2;
end
% hon had 8anon al gradient descent 2no al da5el * lr * al fare2 ben al
% predicted output w al real output ... w 2asamet 3la 3adad al 3ayenat
% l2no 3m 2shte3`el ma9fofat ... 2alabet al x l2n 2na bedy 3adad al 2s6or
% mn al 7ad al 2wal ysawy 3adad al 23mede mn al 7ad al tany
