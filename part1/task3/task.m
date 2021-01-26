%% Initialisation of Parameters

%clean workspace
clear all;

%Defining a 10 x 1 column vector for 'a' (input parameters)
a= randi(10,[10,1]); %range 1-10

%initialising x values; assume convex, random initialisation is ok
    %test for convexity, double diff & positve semi-definite hessian?
x= randi(10, [3,1]); %range 1-10

% Current function solution
%f = (a(2)*x(1)^2) + (a(3)*x(2)^2)+(a(4)*x(3)^2)+(a(5)*x(1)*x(2))+(a(6)*x(1)*x(3))+(a(7)*x(2)*x(3))+(a(8)*x(1))+(a(9)*x(2))+(a(10)*x(3))+a(1);

%% Computing Multivariate 3D Polynomial on initial parameters
Qpoly = quadratic_polynomial(a,x);

%% Minimisation of fixed function via gradient descent
%selection of gradient descent parameters
% NOTE: Still need to optimise..
theta_null = x; %initial pos vector
alpha = 0.3; %step size
epochs = 100; %iterations
margin = 0.1 % tolerance level
nabla = finite_difference_gradient(a,x); %initial vector gradient

%optimised gradient descent solution
theta = gradient_descent(a,theta_null,alpha,epochs,margin,nabla)


%% Validation of descent?
