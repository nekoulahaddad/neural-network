function [J, gradVec,g] = costFunction(theta, X, y)
% ( had 2hm file hon 3m 27sob al cost function(j) w al gradient descent tb3o (grad) )
% Initialize some useful values
m = length(y); % number of training examples
hidden_n = 5;    % number of nodes in the hidden layers
derivative_relu1 = zeros(m,hidden_n);
derivative_relu2 = zeros(m,hidden_n);
g = 0;
J = 0; % dayman lazem 76 8eyam 2waliee 9efer
gradVec = zeros(size(theta));  % dayman lazem 76 8eyam 2waliee 9efer

theta1 = reshape(theta(1:140),5,28);
theta2 = reshape(theta(141:165),5,5);
theta3 = reshape(theta(166:170),1,5);
h1 = max(0,X*theta1');
h2 = max(0,h1*theta2'); 
g = sigmoid(h2*theta3'); 
% hal2 bedy 27sob al cost function yly howe 3ebara 3n logcost function ( there is a lot of types of cost functions depends of the goal of the application[ classification of regression] and with a classification problem we use logcost .. with regression we use another cost functions )
J = mean((-y).* log(g)- (1-y).* log(1 - g)); 
retta = ( g - y)*theta3;
betta = retta*theta2;
%(160*2) 

for i = 1:m;
    for j =1:hidden_n;
        if h2(i,j) < 0;
            derivative_relu2(i,j) = 0;
        elseif h2(i,j) > 0;
            derivative_relu2(i,j) = 1;
        else 
            derivative_relu2(i,j) = 1;
        end;
    end;
end;
for i = 1:m;
    for j =1:hidden_n;
        if h1(i,j) < 0;
            derivative_relu1(i,j) = 0;
        elseif h1(i,j) > 0;
            derivative_relu1(i,j) = 1;
        else 
            derivative_relu1(i,j) = 1;
        end;
    end;
end;

netta = retta.*derivative_relu2;
letta = betta.*derivative_relu1;
grad1 = 1/m * X' * letta; 
grad1 = grad1'; 
grad2 = 1/m * h1' * netta; 
grad2 = grad2';
grad3 = 1/m * h2' * ( g - y); 
grad3 = grad3';
%doaf = h'*(1-h) %derivite of activation function (2*2)
%netta = theta2 * doaf %(1,2)
%retta = ( g - y)* netta %(160,2)
gradVec = [grad1(:);grad2(:);grad3(:)];
% hon had 8anon al gradient descent 2no al da5el * lr * al fare2 ben al
% predicted output w al real output ... w 2asamet 3la 3adad al 3ayenat
% l2no 3m 2shte3`el ma9fofat ... 2alabet al x l2n 2na bedy 3adad al 2s6or
% mn al 7ad al 2wal ysawy 3adad al 23mede mn al 7ad al tany


end
