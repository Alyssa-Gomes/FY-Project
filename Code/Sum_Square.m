%% Sum Square Function
function z = Sum_Square(x)

d = length(x);
sum = 0;

for i = 1:d
    xi = x(i);
    sum = sum + i*xi^2;
end

    z = sum;

end