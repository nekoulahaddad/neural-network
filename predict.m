function [p,q,TP,FP,FN,TN,OPTI,OPTI2,pp] = predict(theta, X)
m = size(X, 1); % Number of training examples
p = zeros(m, 1);
pp = zeros(m, 1);

theta1 = reshape(theta(1:140),5,28);
theta2 = reshape(theta(141:165),5,5);
theta3 = reshape(theta(166:170),1,5);
h1 = max(0,X*theta1');
h2 = max(0,h1*theta2'); 
y = sigmoid(h2*theta3'); 
q = y;

class_1 = q(1:21,1); %(1)
class_2 = q(22:162,1); %(0)
[TP,FP,FN,TN,OPTI,OPTI2] = roc_curve(class_2,class_1);

poss = y>=0.5;
negg = y<0.5;
pp(poss) = 1;
pp(negg) = 0;

pos = y>=OPTI;
neg = y<OPTI;

p(pos) = 1;
p(neg) = 0;








% =========================================================================


end
