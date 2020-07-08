clear all;
%class_1 = 0.5*randn(100,1);
%class_2 = 0.5+0.5*randn(100,1);

q = [2;3;5;4;5;66;5;5;4;4;4;4;5;8;4;4]
class_1 = q(1:4,1)
class_2 = q(5:16,1)

%roc_curve1(class_1, class_2);