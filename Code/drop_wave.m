%% Drop-Wave Function
function z = drop_wave(x)

x1 = x(1);
x2 = x(2);

fract1 = 1 + cos(12*sqrt(x1^2+x2^2));
fract2 = 0.5*(x1^2+x2^2) + 2;

z = -fract1/fract2;

end