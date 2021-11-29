%% Shubert Function
function z = shubert(x)

x1 = x(1);
x2 = x(2);

sum1 = 0;
sum2 = 0;

for i = 1:5
	new1 = i * cos((i+1)*x1+i);
	new2 = i * cos((i+1)*x2+i);
	sum1 = sum1 + new1;
	sum2 = sum2 + new2;
end

z = sum1 * sum2;
    
end