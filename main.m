clear ; close all; clc
%Get the data
X =  textread('input.txt'); 
y = textread('output.txt');
s_o_d = 18; %size of data - number of observations in the first class

%Data normalization
x1 = X(:,1); %first feature
x2 = X(:,2); %second feature
minVal1 = min(x1);
maxVal1 = max(x1);
norm_data1 = (x1 - minVal1) / ( maxVal1 - minVal1 );
minVal2 = min(x2);
maxVal2 = max(x2);
norm_data2 = (x2 - minVal2) / ( maxVal2 - minVal2 );
X = [norm_data1,norm_data2];
data = [X,y];
cv = cvpartition(size(data,1),'HoldOut',0.5);
idx = cv.test;

% Separate dataset into training and testing set
dataTrain = data(~idx,:);
dataTest  = data(idx,:);
X = dataTrain(:,1:2);
y = dataTrain(:,3);
X_test = dataTest(:,1:2);
y_test = dataTest(:,3);
[m, n] = size(X);
for ii=1:m
    if y_test(ii,1) == 0 
        s_o_d = ii-1;
        break
    end;
end;
X_test = mapFeature(X_test(:,1), X_test(:,2));
X = mapFeature(X(:,1), X(:,2));

%Initializing weights
initial_theta1 = rand(5,28)*0.01;
initial_theta2 = rand(5,5)*0.01;
initial_theta3 = rand(1,5)*0.01;
initial_theta = [initial_theta1(:) ; initial_theta2(:); initial_theta3(:)];

%Training the data using back propagation
options = optimset('GradObj', 'on', 'MaxIter', 1000);
[theta, cost] = ...
	fminunc(@(t)(costFunction(t, X, y)), initial_theta, options);
 
% Predict and Accuracy 
[p,q,TP,FP,FN,TN,OPTI,OPTI2,pp] = predict(theta, X_test,s_o_d);
k=double(pp == y_test);
%Calculate Accuracy using F1 method.
TP1=0;FP1=0;TN1=0;FN1=0;
      for i=1:length(y_test);
          if(pp(i,1)==1 & y_test(i,1)==1);
              TP1=TP1+1;
          elseif(pp(i,1)==0 & y_test(i,1)==1);
              FN1=FN1+1;
          elseif(pp(i,1)==0 & y_test(i,1)==0);
              TN1=TN1+1;
          else
              FP1=FP1+1;
          end
      end;
%Calculate Accuracy using orginal method.
accuracy = mean(double(p == y_test)) * 100; 

fprintf('Train Accuracy using orginal method: %f\n', accuracy);
fprintf('\n');

% Plot Boundary
[pred_mesh] = plotDecisionBoundary(theta, X_test, y_test,OPTI);








