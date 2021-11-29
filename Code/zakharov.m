%% Zakharov Function
function z = zakharov(x)
    
d = length(x);
sum1 = 0;
sum2 = 0;

for i = 1:d
	xi = x(i);
	sum1 = sum1 + xi^2;
	sum2 = sum2 + 0.5*i*xi;
end

z = sum1 + sum2^2 + sum2^4;

end