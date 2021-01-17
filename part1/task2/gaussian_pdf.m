function [G]= gaussian_pdf(X,mu,sig)
%GAUSSIAN_PDF calculates the probability density function from a vector

   %GAUSSIAN_PDF applies the equation for a Gaussian Probability density
   %function and applies it to a vector of values, using a mean vector
   %denoted by mu and a covariance matrix (sig)
        %[G] = gaussian_pdf(X,mu,sig) applies this function and returns the
        %matrix consisting of the probability density values for all three
        %directions (x,y,z).
        
% INPUTS:
    %X: the original 3D vector selected to apply the gaussian probability
    %density function to
    %mu: the mean vector
    %sig: the covariance matrix
% OUTPUTS:
    %[G] => matrix consisting of the probability density for each x1, x2,
    %x3 in the original vector matrix
    
G = (1/sqrt(det(sig)).*(2*pi).^(3/2)).*exp(((-0.5).*(X-mu))*(sig.^(-1)).*(X-mu).');