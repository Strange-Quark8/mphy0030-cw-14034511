%% load image file
%load matfile from current directory
load 'data/example_image.mat'
%% write image to a file
simple_image_write('data/image.sim',vol,voxdims);

%% read image stored
[img,dim,head_vol] = simple_image_read('data/image.sim',vol,voxdims);

%% Plot images

img_size = head_vol;
short_var= min(img_size); %choosing shortest variable to slice image as 'z'
start_slice = randi(short_var-2); %randomising values along short-var; need to have 3 slices
slice = [start_slice, (start_slice+1), (start_slice+2)]; %selects next three slices to compare visually

for n = [1:3] %iterate through the 3 slices
    pic= img(:,:,slice(n)); %x,y are fixed, z variable on slice values
    min_val = min(pic(:)); %determine min intensity value across entire plot
    max_val = max(pic(:)); %max intensity value for plot

    %imshow(pic);
    figure;
    imshow(pic,[min_val, max_val]); %plot image with max value in white min value in black
    title(['Z-Slice  #',sprintf('%d',n)]) 
    ylabel('y');
    xlabel('x');
    hold on
    axis on
    save_name=['data/slice_',num2str(n),'.png'];
    saveas(gcf,save_name); %save images as png into 'data' folder
end

clear all 