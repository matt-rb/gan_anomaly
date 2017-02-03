
clear all
clc
dispstat('','init');
%% original dataset and optical flow roots
% sources roots should be contain of video frames in folders (foler per video sample)
dataset_root='/home/moin/GitHub/AbnormalityGAN/data/UCSD/frm/UCSDped1/Test/';
of_root='/home/moin/GitHub/AbnormalityGAN/data/UCSD/of/Ped1/Test/';
% output roots. all video frames will put toghether to collect data for test
dataset_out_root='/home/moin/GitHub/AbnormalityGAN/data/UCSD/train_data/Ped1/frm/';
of_out_root='/home/moin/GitHub/AbnormalityGAN/data/UCSD/train_data/Ped1/of/';
gan_ab_out_root='/home/moin/GitHub/AbnormalityGAN/data/UCSD/train_data/train_data_gan_ped1/';

sample_counter=1;

%% merge all samples together
listing = dir(dataset_root);
dataset_folder = listing([listing.isdir]);
dataset_folder= dataset_folder(arrayfun(@(x) x.name(1),dataset_folder) ~= '.');
listing = dir(of_root);
of_folder = listing([listing.isdir]);
of_folder= of_folder(arrayfun(@(x) x.name(1),of_folder) ~= '.');

for i=1:length(dataset_folder)
    frm_lst = dir([dataset_root dataset_folder(i).name]);
    frm_lst = frm_lst(arrayfun(@(x) x.name(1),frm_lst) ~= '.');
    of_list = dir([of_root of_folder(i).name]);
    of_list = of_list(arrayfun(@(x) x.name(1),of_list) ~= '.');
    for j=1:length(frm_lst)
        dispstat(sprintf('%04d - Video Sapmle %02d / %02d frame %03d / %03d',sample_counter, i,length(dataset_folder),j,length(frm_lst)));
        im_l = imread([dataset_root dataset_folder(i).name '/' frm_lst(j).name]);
        if j<length(frm_lst)
            of_l = imread([of_root of_folder(i).name '/' of_list(j).name]);
            %of_l = of_l(:,:,3);
        end
        
        im_l_name = sprintf('%s%04d.jpg', [dataset_out_root 'test/'], sample_counter);
        of_l_name = sprintf('%s%04d.jpg', [of_out_root 'test/'], sample_counter);
        imwrite(im_l, im_l_name);
        imwrite(of_l, of_l_name);
        sample_counter=sample_counter+1;
    end
end
disp(sprintf('data saved in :\n%s \n%s', dataset_out_root, of_out_root));

%% python script for creating GAN testing data foramt
disp(sprintf('to creat GAN training data run :\npython scripts/combine_A_and_B.py --fold_A %s --fold_B %s --fold_AB %s', of_out_root, dataset_out_root,gan_ab_out_root));

%% test command
disp(sprintf('to train GAN run :\nDATA_ROOT=%s name=%s which_direction=BtoA phase=test th test.lua', gan_ab_out_root,'mag_generation'));
%DATA_ROOT=./datasets/ucsd name=mag_generation which_direction=BtoA phase=test th test.lua
