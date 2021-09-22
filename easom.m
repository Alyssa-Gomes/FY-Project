%% Easom Function
function z = easom(x)
    
    x1 = x(1);
    x2 = x(2);
    z = -cos(x1)*cos(x2)*exp(-(x1 - pi)^2 - (x2 - pi)^2);

end