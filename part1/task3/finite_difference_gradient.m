function [nabla] = finite_difference_gradient(a,x)
%FINITE_DIFFERENCE_GRADIENT is used to approximate the partial derivatives
%of a 3 variable, 2nd order polynomial.
%   FINITE_DIFFERENCE_GRADIENT takes in a column vector representing the
%   polynomial coefficients (a), and 3D position vector (x) and assesses the
%   partial differentials across the 3 variables. A 3 x 1 column vector, 'nabla' is
%   returned representing the scalar values of the partial differential at
%   all 3 variables.
%   This functions works for a second order, 3 variable polynomial, as defined by the form:

%   f = (a(2)*x(1)^2) + (a(3)*x(2)^2)+(a(4)*x(3)^2)+(a(5)*x(1)*x(2))+(a(6)*x(1)*x(3))+(a(7)*x(2)*x(3))+(a(8)*x(1))+(a(9)*x(2))+(a(10)*x(3))+a(1);
%   
    %INPUTS:
    % a: 10 x 1 column vector representing the coefficients of the
    % polynomial
    % x: 3 x 1 3D position vector
    
    %OUTPUT:
    %[nabla]: a 3x1 column vector containing the computed partial
    %differntial results along the 3 variables of x
    
    f_dx = 2*a(1)*x(1) + a(4)*x(2) + a(5)*x(3) + a(7)
    f_dy = 2*a(2)*x(2) + a(4)*x(1) + a(6)*x(3) + a(8)
    f_dz = 2*a(3)*x(3) + a(5)*x(1) + a(6)*x(2) + a(9)

    nabla = [f_dx; f_dy; f_dz]

end
