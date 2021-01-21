function [G]= gaussian_pdf(X,mu,sig)

%GAUSSIAN_PDF calculates the probability density function from a vector

   %GAUSSIAN_PDF applies the equation for a Gaussian Probability density
   %function to a matrix of values using the mean value (mu) and covariance (sig)
   %and returns vector containing pdf values.
        %[G] = gaussian_pdf(X,mu,sig) applies this function and returns the
        %matrix consisting of the probability density values for all parameters of a
        %multivariate matrix.
        
% INPUTS:
    %X: the original multivariate n * m vector, where n are the iterations or samples of the dataset and
    %m are the features or variables. This is the original data selected to apply the gaussian probability
    %density function to.
    %mu: the mean vector. Can either be input statically or calculated from
    %the existing dataset.
    %sig: the covariance of the data. For a multidimensional array, this
    %will be a m*m covariance matrix.
    
% OUTPUTS:
    %[G] => A column vector containing the pdf values of dataset 'X'
    
    
    %Easy Implementation; Slow run time
        %G = diag((1/(sqrt(det(covariance)).*(2*pi)^(3/2))).*exp(((-0.5).*(x(row,:)-mu))*(inv(covariance))*(x(row,:)-mu).');

    %Iterative Approach
        %Determining number of samples from data by row number
            samples = length(X);
        %null 'sample x 1' matrix to hold final result
            G_null= zeros(samples,1);
 
        %iteration across each row of the data to obtain the respective
        %gaussian value
        
            for val = 1:samples
                %gaussian implemented for sample_x_value (x1,x2,x3) matrix
                G_null(val) = (1/(sqrt(det(sig)).*(2*pi)^(3/2))).*exp(((-0.5).*(X(val,:)-mu))*(inv(sig))*(X(val,:)-mu).');
            end %vectorised form?
            
            G = G_null;
            
        clear G_null;
        clear val;
        clear samples;