function [img,dim,head_vol] = simple_image_read(bin_image,vol,voxdims)
%SIMPLE_IMAGE_READ reads a binary image file, representing a medical 3D
%image file. Intended to be paired with custom SIMPLE_IMAGE_WRITE function.
%   INPUT:
%   BIN_IMAGE = the name of the binary image file created by the
%               SIMPLE_IMAGE_WRITE function
%   VOL = 3D image volume data extracted from a matlab image file
%   VOXDIMS = Dimensions of the image voxels
%
%   OUTPUT:
%   IMG = the 3D image file (3D matrix of doubles)
%   DIM = dimensions of the individual voxels as read by the file header
%   (1x3 matrix of doubles)
%   HEAD_VOL = the size of the image, as read by the file header
%   (1x3 matrix of doubles)

readfile =fopen(bin_image,'r'); %read the input binary file
header= fread(readfile, [1,5]); %extract the first 5 values as the file header
head_vol= header(1:3); % the first 3 values are the image volume size
head_vox= header(4:5); % next two are the voxel size

%reading the image data
vol = fread(readfile,numel(vol),'int16'); %read the values that are int16 and correspond to number of values in 'vol' file
img = reshape(vol, head_vol); %reshape it to fit the head_vol dimensions

%reading voxel data
voxdims = fread(readfile, numel(voxdims),'single'); %read the values that are single precision corresponding to number of elements in voxdims
dim = reshape(voxdims, head_vox); %reshape to fit head_vox dimensions

end

