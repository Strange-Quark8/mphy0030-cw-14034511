%Generate 10,000 random samples
X=randn(3,100);
%alternative, use poissrnd(20,1,10000)

mu=mean(X,2); %mean across rows
sigma=cov(X.'); %

%computing mean vector for data of each dimension
%mu=mean(X.').';
%sigma=cov(X);

% N = 4;
% x=linspace(-N, N,100);
% y=x;
% z=x;
% arr=meshgrid(x,y,z);


%pdf=gaussian_pdf(X,mu,sigma);
G = (1/sqrt(det(sigma)).*(2*pi)^(3/2)).*exp(((-0.5).*(X-mu).')*(inv(sigma))*(X-mu));


%% Using Mesh Method

X=randn(100,3);

mumat=mean(X);
cov_mat=cov(X);

%create mesh
x = -3:.4:3; y = -3:.4:3; z=-3:.4:3;

[X,Y,Z] = meshgrid(x,y,z);
X = X-mumat(1); 
Y = Y-mumat(2);
Z = Z-mumat(3);

W = [X(:) Y(:) Z(:)];
