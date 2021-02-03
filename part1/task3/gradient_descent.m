function [theta, new_coord] = gradient_descent(a,theta_null,alpha,epochs,margin,nabla)
%GRADIENT_DESCENT aims to optimise a multivariate function (a) via minimising the cost function 
%through the method of gradient descent.
%   GRADIENT_DESCENT optimises a 3 variable 2nd order multivariate function
%   (a) through the method of gradient descent. Algorithmically, it does so
%   by iteratively seeking the largest gradient from its current positon (using custom
%   function finite_difference_gradient; 'nabla'), weighting this by the
%   step size (alpha) and subtracting this from the current theta_null
%   value, with the aim of descending into a global minimum.
%   
%   %iterate:
%   1. initialise current position as x vector
%   2. subtract alpha*nabla
%   3. check difference between predicted and original (theta and theta null)
%   4. test clauses, if pass, update theta_null
%   3. initialise solution as new theta_null
%
%   The iteration completes when one of 2 clauses are activated:
%   1. Epochs Max: the limit of epochs or iterations has been reached
%   2. Tolerance exceeded: If the difference between the current and next
%   step is below the tolerance level

    %INPUTS:
    % a: 10x1 column vector representing coefficients of a 2nd order, 3 dimensional polynomial
    % theta_null: 3x1 column vector representing starting point; initial 3D position vector to commence
                  % gradient descent.
    % alpha: single value; step size OR learning rate. Determines how large of a step is
            % to be taken with each iteration. Large values risk overshoot, small
            % values risk undershoot/clock out. Common values: 0.001,
            % 0.003, 0.01, 0.03, 0.1, 0.3; optimise by case.
    % epochs: integer; number of iterations to be run. Larger values increase
            % compute time, smaller values may not find global minimum.
    % margin: allowed error/tolerance on individual steps. If the new change 
            % drops below this value the function is terminated.
    % nabla: initial largest vector gradient with the current position vector. 
            % Manually input or calculated using custom FINITE_DIFFERENCE_GRADIENT function.
    
    %OUTPUTS:
    % theta: the optimal function variable that minimises 'a'
    % new_coord: a matrix containing each iteration of the gradient descent
    % function, to allow evaluation of implementation

coord = zeros(length(theta_null),epochs);

for epoch_count = [1:epochs+1]
    theta = theta_null - alpha * nabla;
    diff = abs(theta - theta_null);
    
    coord(:,epoch_count) = theta;
    if diff <= margin %| theta == theta_null
        break
    else 
        theta_null = theta;
        nabla = finite_difference_gradient(a, theta_null);
    end 
end  
new_coord = coord;

end

