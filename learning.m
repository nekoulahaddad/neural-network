clear all;
x = [-5 0;0 -5;12 5;15 -6;-1 0]
m = length(x)
n = max(0,x)
g= zeros(5,2)
for i = 1:5;
    for j =1:2;
        if x(i,j) < 0;
            g(i,j) = 0;
        elseif x(i,j) > 0;
            g(i,j) = 1;
        else
            g(i,j) = 1
        end
    end;
end;
        