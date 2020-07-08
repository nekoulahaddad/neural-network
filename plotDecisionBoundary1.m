
function [pred_mesh] = plotDecisionBoundary1(theta, X, y,OPTI)
z =1;
m = size(X, 1); % Number of training examples
p = zeros(m, 1);


figure;

%% hyperplane
hgscatter = gscatter(X(:,2),X(:,3),y);
hold on;
% decision plane
XLIMs = linspace(0, 1, 300);
YLIMs = linspace(0, 1, 300);
[xi,yi] = meshgrid(XLIMs,YLIMs);
ddd = [xi(:), yi(:)];
dd = mapFeature(ddd(:,1), ddd(:,2));
theta1 = reshape(theta(1:140),5,28);
theta2 = reshape(theta(141:165),5,5);
theta3 = reshape(theta(166:170),1,5);
h1 = max(0,dd*theta1');
h2 = max(0,h1*theta2'); 
y = sigmoid(h2*theta3'); 
pos = y>=0.5;
neg = y<0.5;
p(pos) = 1;
p(neg) = 0;
pred_mesh = p;
redcolor = [1, 0.8, 0.8];
bluecolor = [0.8, 0.8, 1];
pos = find(pred_mesh == 1);
h1 = plot(dd(pos,2), dd(pos,3),'s','color',redcolor,'Markersize',5,'MarkerEdgeColor',redcolor,'MarkerFaceColor',redcolor);
pos = find(pred_mesh == 0);
h2 = plot(dd(pos,2), dd(pos,3),'s','color',bluecolor,'Markersize',5,'MarkerEdgeColor',bluecolor,'MarkerFaceColor',bluecolor);
uistack(h1,'bottom');
uistack(h2,'bottom');
hold off;
end