clear;
clc;

matrix = [];

for i = 1:5
    for j = 1:2
        for k = 1:5
            new = [i,j,k];
            matrix = [matrix;new];
        end
    end
end

matrix