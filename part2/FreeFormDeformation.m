classdef FreeFormDeformation
    %FREEFORMDEFORMATION This class consists of a constructor function
    %'FREEFORMDEFORMATION' as well as 4 functions related to the deformatin
    %of a set of 3d points;RANDOM_TRANSFORM_GENERATOR, WARP_IMAGE, and
    %RANDOM_TRANSFORM
    
    properties
        mesh_x
        mesh_y
        mesh_z
        coor_x;
        coor_y;
        coor_z
        control
        tfm_control
    end
    
    methods (Static)
        function FF = FreeFormDeformation(num_control,rg)
        %FREEFORMDEFORMATION is a class constructor function that takes an
        %input control matrix and range of values
            %control = 1 x 3 matrix defining number of control points for
                     %x,y,z
            %arg2; check class if it if Image3D or different. Run the
            %optional constructor accordingly.
                %Two possible data types:
                    %1. Image3D; consists of size of the image (img_size)
                    %as well as voxel dimensions (voxdims), and image range matrix (img_rg). This allows
                    %calculation of the respective mesh.
                    
                    %2. rg; a 2 x 3 matrix, where each column identifies a
                    %single variable (x, y, z), row1 = Min_Val, row2=
                    %Max_vals
            
            
            
            if strcmp(class(rg),'Image3D')==1
               [img_mesh_x img_mesh_y img_mesh_z]= meshgrid(((linspace(rg.img_min(1),rg.img_max(1),num_control(1)))*rg.voxdims(1)),((linspace(rg.img_min(2),rg.img_max(2),num_control(2)))*rg.voxdims(2)),((linspace(rg.img_min(3),rg.img_max(3),num_control(3)))*rg.voxdims(3)));
                %check not repeated in Image3D
               
                FF.mesh_x = img_mesh_x;
                FF.mesh_y = img_mesh_y;
                FF.mesh_z = img_mesh_z;
            else
                coor_x = linspace(rg(1,1), rg(2,1), num_control(1));
                coor_y = linspace(rg(1,2), rg(2,2), num_control(2));
                coor_z = linspace(rg(1,3), rg(2,3), num_control(3));
                
                [rg_mesh_x rg_mesh_y rg_mesh_z]= meshgrid(coor_x,coor_y,coor_z);
                
                FF.mesh_x = rg_mesh_x;
                FF.mesh_y = rg_mesh_y;
                FF.mesh_z = rg_mesh_z;
                FF.coor_x = coor_x;
                FF.coor_y = coor_y;
                FF.coor_z = coor_z;
                FF.control = [FF.mesh_x FF.mesh_y FF.mesh_z];
            end
            
            
        end
        
        function [tfm_control] = random_transform_generator(FF,img_size,strength)
            %RANDOM_TRANSFORM_GENERATOR seeks to randomly transform a 3D
            %point by a randomly generated transformation matrix. This is
            %controlled relative to the size of the desired image
            %transform, and is controlled by a selected 'strength' value
            %that modulates the intensity of the randomness.
            
            start = ones(4,1); %initialise 4xn matrix of ones
            start(1:3) = FF.control; %convert control points to allow manipulation by 4x4 translation matrix
            
            %creating a scaler that allows for 0 to produce an identity
            %matrix
            
            %strength = rand(1) %generate a number between 0 and 1; randomly normal
            scaler = randi([-1 1]) %randomly select either -1 or 1 
            strength = 1+ (strength * scaler); %scaler is either scale up or down depending on result. If strength is 0, final result is 1
            scale = diag([1 1 1 1]) * strength; %output the scale transformation matrix
            
            translate = diag([1 1 1 1]);
            translate(:,4) = [randi((img_size(1)/2)); randi((img_size(2)/2)); randi((img_size(3)/2)); 1]; %limit on translation so doesnt surpass image dimensions; how to prevent further?

            tfm = scale * translate;
            %tfm(:,4) = translate;
            tfm_control = tfm*start
            
            for val= 1:3 %across all 3 coordinates
                if tfm_control(val) > img_max(val)
                    tfm_control(val) = img_max(val)
                end
                
                if tfm_control(val) < img_min(val)
                    tfm_control(val) = img_min(val)
                end
            end
            %rotate;
            %shear; dont include as deforms body
            
            FF.tfm_control = tfm_control;
        end
        
        function [warp_image] = warp_image(FF,Image3D,RBFSpline,lambda, sigma)
            %WARP_IMAGE applies the principles from class RBFSpline to
            %facilitate the warping of a selected image. First, the image
            %is trained upon a set of control variables generated from the
            %FreeFormDeformation class, and based on randomly distributed
            %points. Next, it is evaluated against the image itself
            %againsty the transformed points, where the new outcome
            %coordinates are output.
            spline = RBFSpline.fit(FF.control,FF.tfm_control,lambda,sigma);
            
            warp_eval = RBFSpline.evaluate([Image3D.img_x Image3D.img_y Image3D.img_z], tfm_control, spline, sigma);
            
            warp_image = warp_eval;
        end
        
        function[image]= random_transform(FF,RBFSpline,num_control,Image3D,img_size,strength,lambda,sigma)
            %main function that applies all the other functions in the
            %class to execute for an Image3D.
            FreeForm = FreeFormDeformation(num_control,Image3D);
            [tfm_control] = FF.random_transform_generator(FF.control,img_size,strength)
            [warp_image] = FF.warp_image(FF,Image3D,RBFSpline,lambda, sigma)
            
        end
    end
end

