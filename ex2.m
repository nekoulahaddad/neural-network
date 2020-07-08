clear ; close all; clc
% get the data
X = xlsread('input.xlsx'); y = xlsread('output of p300.xlsx');
x1 = X(:,1);
x2 = X(:,2);
minVal1 = min(x1);
maxVal1 = max(x1);
norm_data1 = (x1 - minVal1) / ( maxVal1 - minVal1 );
%your_original_data = minVal + norm_data.*(maxVal - minVal)
minVal2 = min(x2);
maxVal2 = max(x2);
norm_data2 = (x2 - minVal2) / ( maxVal2 - minVal2 );
X = [norm_data1,norm_data2];
%{ 
plot the data
plotData(X, y);
hold on;
xlabel('latency')
ylabel('amplitude')
legend('target', 'not a target')
hold off;
%}
[m, n] = size(X);
X = mapFeature(X(:,1), X(:,2));
%X = [ones(m, 1) X];
%initial_theta = zeros(n + 1, 3);
%w1 = fix((-100+200*rand(1,1)))/100;
%w2 = fix((-100+200*rand(1,1)))/100;
%w3 = fix((-100+200*rand(1,1)))/100;
%w4 = fix((-100+200*rand(1,1)))/100;
%w5 = fix((-100+200*rand(1,1)))/100;
%w6 = fix((-100+200*rand(1,1)))/100;
%w8 = fix((-100+200*rand(1,1)))/100;
initial_theta1 = rand(5,28)*0.01;
initial_theta2 = rand(5,5)*0.01;
initial_theta3 = rand(1,5)*0.01;
initial_theta = [initial_theta1(:) ; initial_theta2(:); initial_theta3(:)];
%initial_theta = [0.00792207329559555;
%0.00959492426392903;
%0.00655740699156587;
%0.000357116785741896;
%0.00849129305868777;
%0.00933993247757551]
[cost, grad,g] = costFunction(initial_theta, X, y);



options = optimset('GradObj', 'on', 'MaxIter', 500);

% fminunc 3ebara 2an function mn 2smo bey6al3 al minimum
[theta, cost] = ...
	fminunc(@(t)(costFunction(t, X, y)), initial_theta, options);
 
%% Predict and Accuracy 
[p,q,TP,FP,FN,TN,OPTI,OPTI2,pp] = predict(theta, X);
k=double(pp == y);
TP1=0;FP1=0;TN1=0;FN1=0;
      for i=1:162;
          if(pp(i,1)==1 & y(i,1)==1);
              TP1=TP1+1;
          elseif(pp(i,1)==0 & y(i,1)==1);
              FN1=FN1+1;
          elseif(pp(i,1)==0 & y(i,1)==0);
              TN1=TN1+1;
          else
              FP1=FP1+1;
          end
      end;
precision = TP1 / (TP1+FP1);
recall = TP1 / (TP1+FN1);
betta = 0.4
accuracy = (1 + betta^2)*(precision*recall)/((betta^2*precision)+recall)
accuracy1 = mean(double(p == y)) * 100; 

fprintf('Train Accuracy: %f\n', accuracy * 100);
fprintf('\n');
%mean(double(p == y)) * 100
% Plot Boundary
[pred_mesh] = plotDecisionBoundary(theta, X, y,OPTI);
[pred_mesh] = plotDecisionBoundary1(theta, X, y,OPTI);

hold on;
xlabel('latency')
ylabel('amplitude')
legend('target', 'not a target')
hold off;

fprintf('\nProgram paused. Press enter to continue.\n');
pause;





