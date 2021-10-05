clear
clc

% Variables
x1 = 2.6;
x2 = 0.7;
x3 = 17;
x4 = 7.3;
x5 = 7.7153;
x6 = 3.3502;
x7 = 5.2867;

rm = 200;

% Initialization of penalty values
m = 0;

%Constraints
g(1) = 27*x1^(-1)*x2^(-2)*x3^(-1) - 1;
if g(1) <= 0
    m(1) = 0;
else
    m(1) = g(1);
end

g(2) = 397.5*x1^(-1)*x2^(-2)*x3^(-2) - 1;
if g(2) <= 0
    m(2) = 0;
else
    m(2) = g(2);
end

g(3) = 1.93*(x4^3)*x2^(-1)*x3^(-1)*x6^(-4) - 1;
if g(3) <= 0
    m(3) = 0;
else
    m(3) = g(3);
end

g(4) = 1.93*(x5^3)*x2^(-1)*x3^(-1)*x7^(-4) - 1;
if g(4) <= 0
    m(4) = 0;
else
    m(4) = g(4);
end

g(5) = (745^2)*(x4^2)*x2^(-2)*x3^(-2) - (110^2)*(x6^6) + (16.9*10^6);
if g(5) <= 0
    m(5) = 0;
else
    m(5) = g(5);
end

g(6) = (745^2)*(x5^2)*x2^(-2)*x3^(-2) - (85^2)*(x7^6) + (157.5*10^6);
if g(6) <= 0
    m(6) = 0;
else
    m(6) = g(6);
end

g(7) = x2*x3 - 40;
if g(7) <= 0
    m(7) = 0;
else
    m(7) = g(7);
end

g(8) = 5*x2 - x1;
if g(8) <= 0
    m(8) = 0;
else
    m(8) = g(8);
end

g(9) = x1 - 12*x2;
if g(9) <= 0
    m(9) = 0;
else
    m(9) = g(9);
end

g(10) = 1.5*x6 - x4 + 1.9;
if g(10) <= 0
    m(10) = 0;
else
    m(10) = g(10);
end

g(11) = 1.1*x7 - x5 + 1.9;
if g(11) <= 0
    m(11) = 0;
else
    m(11) = g(11);
end

% Total Penalty
penalty = sum(m);
g(5)

% Objective Function
f = (0.7854*3.3333)*x1*(x2^2)*(x3^2) + (0.7854*14.9334)*x1*(x2^2)*x3 ...
    - (0.7854*43.0934)*x1*(x2^2) - 1.508*x1*(x6^2) - 1.508*x1*(x7^2) ...
    + 7.4777*(x6^3) + 7.4777*(x7^3) + 0.7854*x4*(x6^2) + 0.7854*x5*(x7^2);

% Final result (with constraints and penalty)
z = f + rm*(penalty);

% Print Output 
disp(['Best Sol = ' num2str(z) ', Penalty = ' num2str(penalty) ', x1 = ' num2str(x1) ...
    ', x2 = ' num2str(x2) ', x3 = ' num2str(x3) ', x4 = ' num2str(x4) ', x5 = ' num2str(x5) ...
    ', x6 = ' num2str(x6) ', x7 = ' num2str(x7)]);
