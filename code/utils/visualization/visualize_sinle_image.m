clc
clear
startup;

load('../data/input/sec1.mat');
feats = x;
load('../data/output/itq_fc7.mat');

dims = size(feats);
h_img_size = dims(3);
w_img_size = dims(2);

project_mat = pca_mapping * itq_rot_mat;
tt = repmat(mean_fc7(1,:),[h_img_size 1]);
tt2 = repmat(tt,[w_img_size 1]);
tt2 = reshape(tt2,[w_img_size h_img_size 4096]);
feats_binary = zeros(dims(1),dims(2),dims(3),bin_size);

for idx=1:dims(1)
    data_features=reshape(feats(idx,:,:,:),[dims(2) dims(3) dims(4)]);
    data_features=bsxfun(@minus,tt2,data_features);
    data_features=bsxfun(@rdivide,data_features,sqrt(sum(data_features.^2,2)));
    c = multiprod(project_mat', permute(data_features,[3 1 2]));
    feats_binary(idx,:,:,:) = sign(max(permute(c,[2 3 1]),0));
end