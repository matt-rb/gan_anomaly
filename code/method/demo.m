% by MAtt

% 1 - compute OF on UCSD
compute_of_ped1;

% 2 - creat input to pix-pix GAN
train_data_preparation_ped1
test_data_preparation_ped1

% convert to jpg
data_lst = dir('pix2pix/datasets/ucsd/train/');
for i=3:length(data_lst)
     im_l = imread(['pix2pix/datasets/ucsd/train/' data_lst(i).name]);
     imwrite(im_l,sprintf('%s%05d.jpg', 'pix2pix/datasets/ucsd/train2/', i-2));
end



% train GAN
% DATA_ROOT=../data/UCSD/pix2pix_train_data name=of_generation which_direction=BtoA th train.lu
 
%% test GAN AtoB
% DATA_ROOT=./datasets/ucsd name=ap_generation which_direction=AtoB phase=test th test.lua
% DATA_ROOT=./datasets/train_data_gan name=mag2app_unet which_direction=AtoB phase=test th test.lua

%% test GAN BtoA
% DATA_ROOT=./datasets/train_data_gan name=mag_generation_unet which_direction=BtoA phase=test th test.lua