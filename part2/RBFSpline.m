classdef RBFSpline
    %RBFSpline consists of 3 constituent functions, FIT, EVALUATE, and
    %kernel_gaussian. These are used to create and evaluate a spline
    %function from a set of query and control points
    
    properties
        Property1
    end
    
    methods (Static)
        function [spline] = fit(p,q,lambda,sigma)
            %FIT determines the mapping of source points (p) to target
            %points (q) according to an RBF Gaussian kernel. Inversion of a
            %non-square matrix is done using the pseudoinverse function.
            %   INPUTS:
            %   p= source points
            %   q= target points
            %   sigma = tunable Hyperparameter, sigma general weights of individual landmarks, nx1 matrix.
                      % reccomended as 1
            %
            %   OUTPUTS:
            %   spline = spline coefficient values that represent mapping
            %   of spline.
            
            if nargin == 3   % if the number of inputs is 3
                 W = 1 ;%eye(lambda(size)); % Assign W to be the identity matrix of size lambda
            end

            r = norm(p-q);        
            phi = exp(-(r)^2/2*(sigma)^2);
            
            %W = diag(1/(sigma(n)).^2;
            %W_tag = W.';
            
            Q = (phi+(lambda.*(W.'))) ; %solving for constituent matrix of phi and weights
            %Q_i = eye(size(Q)); %identity matrix the size of Q
            spline = (pinv(Q)).*q; %output an array of values that are the coefficients. Cannot assume Q invertible, use pseudoinverse
        end
        
        function [predict]=evaluate(query, control, spline, sigma)
            % EVALUATE compares a set of 'new' query points, compares these
            % with a set of control points, and applies the fitted spline
            % to 
            %now query are initial values, calculate the transformed
            %results
            r = norm(query - control); %distance between 
            phi = exp(-(r)^2/2*(sigma)^2);% need to redefine r
            Q = (phi);
            predict = Q.*spline; %matrix containing the transformed points in 3 dimensions
        end 
        
        function [K]= kernel_gaussian(query, control,sigma) %phi outputs 3D matrix of kernal values
            r = norm(query-control); 
            phi = exp(-(r)^2/2*(sigma)^2);
            K = phi;
        end
    end
end

