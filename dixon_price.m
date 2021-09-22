%% Dixon-Price Function
function z = dixon_price(x)

x1 = x(1);
d = length(x);
sol1 = (x1 - 1)^2;

sum = 0;
for ii = 2:d
    xi = x(ii);
    x0 = x(ii-1);
    sol2 = ii*(2*xi^2 - x0)^2;
    sum = sum + sol2;
end

z = sol1 + sum;

end