function simple_image_write(bin_image,vol,voxdims)
%SIMPLE_IMAGE_WRITE takes in an input of a 3D matlab image file, with image
%volume 'VOL' and voxel dimensions 'VOXDIMS', and writes a binary file with
%the volume in 16-bit integers and voxel dimensions in 32bit float.
%   INPUTS:
%   BIN_IMAGE = desired name for written output file
%   VOL = 3D image volume data extracted from a matlab image file
%   VOXDIMS = Dimensions of the image voxels

%   OUTPUTS:
%   BIN_IMAGE= a binary file specified by name BIN_IMAGE to be read and viewed as a 3D image. See
%   'simple_image_read'.

writefile= fopen(bin_image, 'w');

img_size = uint8(size(vol)); %determine the size of the image
vox_size = uint8(size(voxdims)); %determine size of vox dimensions

%create a binary write file named 'bin', with full write permissions

%bit_vol = int16(vol); %converting volume sizes to 16-bit integert equivalent
%bit_vox = single(voxdims);  %single precision is 32-bit floating equivalent

fwrite(writefile, [img_size, vox_size]); %storing of image file size as a header
fwrite(writefile, vol,'int16'); %writing of volume data
fwrite(writefile, voxdims,'single'); %writing of voxel data

fclose(writefile);

end

