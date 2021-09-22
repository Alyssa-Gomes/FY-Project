%% Eggholder Function
function z = eggholder(x)
    
    x1 = x(1);
    x2 = x(2);
    z = -(x2 + 47)*sin(sqrt(abs(x2+(x1/2)+47))) - x1*sin(sqrt(abs(x1 - (x2 + 47))));

end