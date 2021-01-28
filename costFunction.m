function [J, gradVec,g] = costFunction(theta, X, y)

% Initialize some useful values
m = length(y); % number of training examples
hidden_n = 5;    % number of nodes in the hidden layers
derivative_relu1 = zeros(m,hidden_n);
derivative_relu2 = zeros(m,hidden_n);
g = 0;
J = 0; 
gradVec = zeros(size(theta));  
theta1 = reshape(theta(1:140),5,28);
theta2 = reshape(theta(141:165),5,5);
theta3 = reshape(theta(166:170),1,5);
%Start training
h1 = max(0,X*theta1'); %output of the first layer
h2 = max(0,h1*theta2'); %output of the second layer
g = sigmoid(h2*theta3'); %final output
J = mean((-y).* log(g)- (1-y).* log(1 - g)); %cost function

%Calculate the derivative of RelU activation function
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

retta = ( g - y)*theta3;
betta = retta*theta2; 
netta = retta.*derivative_relu2;
letta = betta.*derivative_relu1;

grad1 = 1/m * X' * letta; 
grad1 = grad1'; %first gradient
grad2 = 1/m * h1' * netta; 
grad2 = grad2'; %second gradient
grad3 = 1/m * h2' * ( g - y); 
grad3 = grad3'; %third gradient
gradVec = [grad1(:);grad2(:);grad3(:)];
end
