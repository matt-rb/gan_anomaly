
src_name = 'target'; % target, output
feat_dir = ['/home/mahdyar/Documents/MATLAB/crowd_segmentation/data/latest_net_G_test/images/feats/' src_name];
out_file = ['/home/mahdyar/Documents/MATLAB/crowd_segmentation/code/gan/feats_for_gan/' src_name '.mat'];
load('variables/boxes_ped2.mat');

%% binarization
load('variables/W_conv5_8bit_ped2');
load('variables/itq_8_conv5_ped2');

%% cluster centers
load('variables/W_conv5_clusters_128_ped2');
load('variables/bg_mask_clusters_128_ped2.mat');

%% read raw feats
feats = merge_feats(feat_dir);

%% project feature vectors to binary/cluster space
bin_feats = project_feat2bin(feats, project_mat, mean_fc7);
clus_feats = project_feat2clusters( feats, cluster_centers, mean_data);


%% save projected feats
save (out_file,'bin_feats','clus_feats');