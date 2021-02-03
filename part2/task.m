% Load image
load('data/example_image.mat')

%instantiate Image3D object
obj = Image3D(vol,voxdims)

%define all constraints 

num_control = [ 100 100 100 ];%assign number of control values along each axis

rg = [0, 10 , 12 ; 200, 250, 300];%assign number of control values along each axis

sigma = 0.1;

lambda = 2;

strength = rand(1);

FF = FreeFormDeformation(control,rg)
RB = RBFSpline
FF.mesh_x
FF.mesh_y
FF.mesh_z

rand_z = randperm(obj.img_size(3),5) %create 5 random z values within limits of img_size z directions

for n = 1:10
  [image]= FF.random_transform(FF,RB,num_control,obj,obj.img_size,strength,lambda,sigma);
  
  %for z = 1:5 %loop for z-depths
    
   
   
  %end
end


%Generate 10 random values