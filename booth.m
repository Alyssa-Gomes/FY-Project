%% Booth Function
function z = booth(x)
    
    x1 = x(1);
    x2 = x(2);
    z = (x1 + 2*x2 - 7)^2 + (2*x1 + x2 - 5)^2;

end