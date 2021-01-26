%% Generate 10,000 random samples
X=randn(10000,3);

%alternative, use poissrnd(20,1,10000)?

%% fitting Gaussian
mu=mean(X); %mean 
sig=cov(X); %covariance matrix as multivariate

G= gaussian_pdf(X,mu,sig); %calling personal gaussian function

%% Determining Percentiles on G
G_10=prctile(G,10); %10th percentile
G_50=prctile(G,50); %50th percentile
G_90=prctile(G,90); %90th percentile

%% Calculating & Plotting Ellpisoids
%Create delaunay triangulation method for each percentile option and plot
%the mesh.
%Delaunay requires minimum 4 points to work

cutoff= 1000; %standardising number of points to use across plots, larger value causes smoother plot but tradeoff on accuracy

%90th Percentile ellipsoid
    %method to find values closest to percentile score
    
    diff = abs(G-G_90); %find how far each value is from 'ideal' percentile score
    idx= (1:length(G)).'; %create index vector
    diff = [idx diff]; %append to create master vector

    sort_diff = sortrows(diff,2); %sort the rows based on the absolute difference

    top_vals= (sort_diff(1:cutoff)).'; %establish the indices of top values to use for the surf plot

    G90_dt = delaunay(X(top_vals,:));

    G90_x1_surf= X(top_vals,1);
    G90_x2_surf= X(top_vals,2);
    G90_x3_surf= X(top_vals,3);

    clear diff sort_diff top_vals dt

%50th Percentile

    diff = abs(G-G_50); %find how far each value is from 'ideal' percentile score
    diff = [idx diff]; %append both to create master vector

    sort_diff = sortrows(diff,2); %sort the rows based on the absolute difference

    top_vals= (sort_diff(1:cutoff)).'; %establish the indexes of top values to use for the surf plot

    G50_dt = delaunay(X(top_vals,:));

    G50_x1_surf= X(top_vals,1);
    G50_x2_surf= X(top_vals,2);
    G50_x3_surf= X(top_vals,3);

    clear diff sort_diff top_vals dt

%10th Percentile

    diff = abs(G-G_10); %find how far each value is from 'ideal' percentile score
    diff = [idx diff]; %append both to create master vector

    sort_diff = sortrows(diff,2); %sort the rows based on the absolute difference

    top_vals= (sort_diff(1:cutoff)).'; %establish the indexes of top values to use for the surf plot

    G10_dt = delaunay(X(top_vals,:));

    G10_x1_surf= X(top_vals,1);
    G10_x2_surf= X(top_vals,2);
    G10_x3_surf= X(top_vals,3);
    
    clear diff sort_diff top_vals dt idx
    
%Assigining adaptive limits for comparison
%tagged to 10th percentile as ellipsoid will be largest
x1_lim= round(max(G10_x1_surf));
x2_lim= round(max(G10_x2_surf));
x3_lim= round(max(G10_x3_surf));

%plots using trisurf to generate 3D surface
    %all plots saved as PNG to current directory

%10th Percentile
figure('Name','10th Percentile');
trisurf(G10_dt,G10_x1_surf,G10_x2_surf,G10_x3_surf);
xlabel("x1");
ylabel("x2");
zlabel("x3");
title("Gaussian - 10th Percentile Ellipsoid");
axis([-(x1_lim) x1_lim -(x2_lim) x2_lim -(x3_lim) x3_lim]);
saveas(gcf,'10th Percentile Ellipsoid.png')

%50th Percentile
figure('Name','50th Percentile');
trisurf(G50_dt,G50_x1_surf,G50_x2_surf,G50_x3_surf);
xlabel("x1");
ylabel("x2");
zlabel("x3");
title("Gaussian - 50th Percentile Ellipsoid");
axis([-(x1_lim) x1_lim -(x2_lim) x2_lim -(x3_lim) x3_lim]);
saveas(gcf,'50th Percentile Ellipsoid.png')

%90th Percentile
figure('Name','90th Percentile');
trisurf(G90_dt,G90_x1_surf,G90_x2_surf,G90_x3_surf);
xlabel("x1");
ylabel("x2");
zlabel("x3");
title("Gaussian - 90th Percentile Ellipsoid");
axis([-(x1_lim) x1_lim -(x2_lim) x2_lim -(x3_lim) x3_lim]);
saveas(gcf,'90th Percentile Ellipsoid.png')

clear x1_lim x2_lim x3_lim cutoff 

%NOTE: attempt tetramesh?
