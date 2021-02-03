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
%   but may be extended to other 3 variable polynomials.

    %INPUTS:
    % a: 10 x 1 column vector representing the coefficients of the
    % polynomial
    % x: 3 x 1 3D position vector
    
    %OUTPUT:
    %[nabla]: a 3x1 column vector containing the computed partial
    %differntial results along the 3 variables of x
    
        %brute force partial-derivation
        %f_dx = 2*a(1)*x(1) + a(5)*x(2) + a(6)*x(3) + a(8)
        %f_dy = 2*a(2)*x(2) + a(4)*x(1) + a(6)*x(3) + a(8)
        %f_dz = 2*a(3)*x(3) + a(5)*x(1) + a(6)*x(2) + a(9)

        %nabla = [f_dx; f_dy; f_dz]

        %Forward diff method --> nabla = (f(x+h)- f(x))/h )
    %     tic
    %     h=0.01; %step size
    %     nabla1 = zeros(3,1); %null matrix to store each partial diff value
    %     
    %     
    %     for n = 1:length(x) %iterate along variables of x
    %         %f_shift = x(n)+h;
    %          % creating holding matrix to not affect initial x
    %         x_new = x;
    %         x_new(n) = x(n)+h;
    %         nabla1(n) = (quadratic_polynomial(a,x_new) - quadratic_polynomial(a,x))/h;
    %     end
    %     toc
%    
   %Central diff method --> f(x+h) - f(x-h) / 2h
   %increased accuracy, slower speed
    
   %tic
   h = 0.001; % step value
   nabla = zeros(3,1); %initialise null matrix to populate 
   for n = 1:length(x) %iterate along variables of x
        x_low = x ; %create duplicated matrix to not affect initial x
        x_low(n) = x(n)-h; %lower
        x_high = x; % creating holding matrix to not affect initial x
        x_high(n)= x(n)+h;
        nabla(n) = (quadratic_polynomial(a,x_high) - quadratic_polynomial(a,x_low))/(2*h);
   end
   
   %toc
end
