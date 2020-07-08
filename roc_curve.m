function [TP,FP,FN,TN,OPTI,OPTI2] = roc_curve(class_1, class_2)

% first of all --> when dealing with precision i need to add the line 15
% --> and i can use it of delete it with Specificity



%C = unique(A) returns the same data as in A, but with no repetitions. C is in sorted order
s_data = unique(sort([class_1; class_2]));   % sorts the elements of A in ascending order. with deleting repetitions
d_data = diff(s_data);                      % Difference between consecutive points / al fare2 been two elements wara b3d
d_data(length(d_data)+1,1) = d_data(length(d_data)); % Last point  // i added an element in the end of the array to make the length of d_data equal the length of s_data // this element is equal to the last element in the array d_data
thres(1,1) = s_data(1) - d_data(1); % First point
thres(2:length(s_data)+1,1) = s_data + d_data./2;   % Threshold values

%thres = thres(1:162,1);  % it used when dealing with precision preventing an error // cuz the last element giving NAN 
% Calculating the sensibility(true positive rate) and specificity of each threshold 
% false positive rate = (1-specificity)

 curve = zeros(size(thres,1),2);
    distance = zeros(size(thres,1),1);
    for id_t = 1:1:length(thres)
        TP = length(find(class_2 >= thres(id_t)));    % True positives
        FP = length(find(class_1 >= thres(id_t)));    % False positives
        FN = length(find(class_2 < thres(id_t)));     % False negatives
        TN = length(find(class_1 < thres(id_t)));     % True negatives
        
        curve(id_t,1) = TP/(TP + FN);   % Sensitivity
        curve(id_t,2) = TN/(TN + FP);	% Specificity
        %curve(id_t,2) = TP/(TP + FP);   % precision %i used precision because in our case (classifying P300) we have a different number of samples in every class
        % Distance between each point and the optimum point (0,1)
        
        distance(id_t)= sqrt((1-curve(id_t,1))^2+(curve(id_t,2)-1)^2);
    end
    
    % Optimum threshold and parameters
    [~, opt] = min(distance);
    TP = length(find(class_2 >= thres(opt)));    % No. true positives
    FP = length(find(class_1 >= thres(opt)));    % No. false positives 
    FN = length(find(class_2 < thres(opt)));     % No. false negatives                                 
    TN = length(find(class_1 < thres(opt)));     % No. true negatives       
    
    OPTI = thres(opt,1)
    OPTI2 = thres(opt)
    % Output parameters
    param.Sensi = curve(opt,1);                 % Sensitivity
    param.Speci = curve(opt,2);                 % Specificity
    param.AROC  = abs(trapz(1-curve(:,2),curve(:,1))); % Area under curve
    param.Accuracy = (TP+TN)/(TP+TN+FP+FN);     % Accuracy using the general method
    
    
    % Plotting 
    figure;
    fill_color = [11/255, 208/255, 217/255];
    fill([1-curve(:,2); 1], [curve(:,1); 0], fill_color,'FaceAlpha',0.5);
    hold on; plot(1-curve(:,2), curve(:,1), '-g', 'LineWidth', 2);
    hold on; plot(1-curve(opt,2), curve(opt,1), 'or', 'MarkerSize', 10);
    hold on; plot(1-curve(opt,2), curve(opt,1), 'xr', 'MarkerSize', 12);
    hold off; axis square; grid on; xlabel('1 - specificity'); ylabel('sensibility');
    title(['Area under curve = ' num2str(param.AROC)]);
    
    ROC_data.param = param;
    ROC_data.curve = curve;
end