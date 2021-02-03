function QPoly = quadratic_polynomial(a,x)
%QUADRATIC_POLYNOMIAL takes in a 10x1 coefficient vector and a 3x1 variable vector
                        %and outputs the solution to the function QPoly.
%   QUADRATIC_POLYNOMIAL takes in a 10x1 coefficient vector and a 3x1
%   variable vector representing the terms in a 3-variable 2nd order
%   polynomial equation. The function outputs a value, which is the
%   solution to the quadratic polynomial function, avoiding the use of
%   symbolic algebra toolboxes.
%   
%   If a 10 value coeffecient matrix is not input for A, the remaining
%   values will be populated as zero.
%   
%   INPUTS
%   a : a 10x1 column vector that represents the coefficient values of the
%   quadratic polynomial
%   x : a 3x1 column vector representing the variables in the polynomial
%
%   OUTPUTS
%   Qpoly :  An numerical value representing the solution to the quadratic
%   polynomial.

%test that a matrix contains  10 values
if length(a) > 10
    fprintf('Error: Please use a 10 parameter vector for A')
    return  
end 

if length(a) < 10
    fprintf('WARNING: matrix A shorter than expected, populating with zeros')
    a_new = zeros(10,1);
    a_new(1:length(a)) = a(1:length(a));
    a = a_new   ;
end

%if less than 10, replace with 0s?

%test that variable matrix contains only 3 variables
if length(x) ~= 3
    fprintf('Error: Use a 3 variable vector for x')
    return 
end 

QPoly = (a(2)*x(1)^2) + (a(3)*x(2)^2)+(a(4)*x(3)^2)+(a(5)*x(1)*x(2))+(a(6)*x(1)*x(3))+(a(7)*x(2)*x(3))+(a(8)*x(1))+(a(9)*x(2))+(a(10)*x(3))+a(1);

end

