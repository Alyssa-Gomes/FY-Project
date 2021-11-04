%% Golenski Case Study
% Journal Article: Design Optimization of a Speed Reducer Using Deterministic Techniques
% Paper no. 7 (in drive folder)
% Authors: Ming-Hua Lin,Jung-Fa Tsai,Nian-Ze Hu,and Shu-Chuan Chang
% Pg no. 3

% Best known solution ranges between: 3019.583365 with error <10^-1 to 2876.219475 with error <10^0
% Paper referred to - optimal soln: 2994.471921 with error in const <10^-6


function z = golenski_case_study(x)

% Variables
x1 = x(1);
x2 = x(2);
x3 = x(3);
x4 = x(4);
x5 = x(5);
x6 = x(6);
x7 = x(7);

rm = 200;

% Initialization of penalty values
m = 0;

%Constraints
p(1) = 27*x1^(-1)*x2^(-2)*x3^(-1) - 1;
if p(1) <= 0
    m(1) = 0;
else
    m(1) = p(1);
end

p(2) = 397.5*x1^(-1)*x2^(-2)*x3^(-2) - 1;
if p(2) <= 0
    m(2) = 0;
else
    m(2) = p(2);
end

p(3) = 1.93*(x4^3)*x2^(-1)*x3^(-1)*x6^(-4) - 1;
if p(3) <= 0
    m(3) = 0;
else
    m(3) = p(3);
end

p(4) = 1.93*(x5^3)*x2^(-1)*x3^(-1)*x7^(-4) - 1;
if p(4) <= 0
    m(4) = 0;
else
    m(4) = p(4);
end

p(5) = (745^2)*(x4^2)*(x2^-2)*(x3^-2) - (110^2)*(x6^6) + (16.9*10^6);
if p(5) <= 0
    m(5) = 0;
else
    m(5) = p(5);
end

p(6) = (745^2)*(x5^2)*(x2^-2)*(x3^-2) - (85^2)*(x7^6) + (157.5*10^6);
if p(6) <= 0
    m(6) = 0;
else
    m(6) = p(6);
end

p(7) = x2*x3 - 40;
if p(7) <= 0
    m(7) = 0;
else
    m(7) = p(7);
end

p(8) = 5*x2 - x1;
if p(8) <= 0
    m(8) = 0;
else
    m(8) = p(8);
end

p(9) = x1 - 12*x2;
if p(9) <= 0
    m(9) = 0;
else
    m(9) = p(9);
end

p(10) = 1.5*x6 - x4 + 1.9;
if p(10) <= 0
    m(10) = 0;
else
    m(10) = p(10);
end

p(11) = 1.1*x7 - x5 + 1.9;
if p(11) <= 0
    m(11) = 0;
else
    m(11) = p(11);
end

% Total Penalty
penalty = sum(m);

% Objective Function
f = (0.7854*3.3333)*x1*(x2^2)*(x3^2) + (0.7854*14.9334)*x1*(x2^2)*x3 ...
    - (0.7854*43.0934)*x1*(x2^2) - 1.508*x1*(x6^2) - 1.508*x1*(x7^2) ...
    + 7.4777*(x6^3) + 7.4777*(x7^3) + 0.7854*x4*(x6^2) + 0.7854*x5*(x7^2);

% Final result (with constraints and penalty)
z = f + rm*penalty;

% Print Output 
%disp(['Best Sol = ' num2str(z) ', Penalty = ' num2str(penalty) ', x1 = ' num2str(x1) ...
%    ', x2 = ' num2str(x2) ', x3 = ' num2str(x3) ', x4 = ' num2str(x4) ', x5 = ' num2str(x5) ...
%    ', x6 = ' num2str(x6) ', x7 = ' num2str(x7)]);

end