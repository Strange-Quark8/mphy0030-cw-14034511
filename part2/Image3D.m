classdef Image3D
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    properties 
        img_x
        img_y
        img_z
        img_size
        voxdims
        img_min
        img_max
    end
    methods %(Static)
        function obj = Image3D(vol,voxdims)
            %UNTITLED Construct an instance of this class
            %   Detailed explanation goes here
            %create mesh structure to scale image grid by defined voxel size 
            %NOTE: min and max?
            img_size = size(vol);
            img_min = [0 0 0]
            img_max = [img_size.*voxdims];
            %non-square 3D matrix
            
            %for n=[1:ndims(vol)]
               %[frame(:,n)] = ([0:size(img_size(n))-1].').*voxdims;
            %end

            %create a 3D meshgrid
            [img_x img_y img_z]= meshgrid(((linspace(0,img_size(1),img_size(1)))*voxdims(1)),((linspace(0,img_size(2),img_size(2)))*voxdims(2)),((linspace(0,img_size(3),img_size(3)))*voxdims(3)));
            
            %mesh_x = mesh_x .*voxdims(1);
            %mesh_y = mesh_y .*voxdims(2);
            %mesh_z = mesh_z .*voxdims(3);
            obj.img_min = img_min;
            obj.img_max = img_max;
            obj.img_size= img_size;
            obj.img_x= img_x;
            obj.img_y= img_y;
            obj.img_z= img_z;
            obj.voxdims = voxdims;
        end
    end
end

