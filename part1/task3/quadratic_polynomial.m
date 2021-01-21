function [outputArg1,outputArg2] = quadratic_polynomial(inputArg1,inputArg2)
%QUADRATIC_POLYNOMIAL Summary of this function goes here
%   Detailed explanation goes here

%assume input matrix is already in symbolic form...
x1=x(1);
x2=x(2);
x3=x(3);

syms x1 x2 x3 

f=solve('a(2)*((x1)^2)+a(3)*((x2)^2)+a(4)*((x3)^2)+a(5)*(x1)*(x2)+a(6)*x(1)*(x3)+a(7)*(x2)*(x3)+a(8)*(x1)+a(9)*(x2)+a(10)*(x3)+a(1)',[x1,x2,x3]);

x1_sol= f.x1
x2_sol= f.x2
x3_sol= f.x3
roots(a);

outputArg1 = inputArg1;
outputArg2 = inputArg2;
end

