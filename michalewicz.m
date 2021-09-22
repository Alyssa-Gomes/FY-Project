%% Michalewicz Function
function z = michalewicz(x)

d = length(x);
m = 10;
sum = 0;

for i = 1:d
	xi = x(i);
	sol = sin(xi)*sin((i*xi^2)/pi)^(2*m);
	sum  = sum + sol;
end

z = -sum;

end