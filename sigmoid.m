function g = sigmoid(z)
g = zeros(size(z));
g = ones(size(z))./(1 + exp(-z));
end