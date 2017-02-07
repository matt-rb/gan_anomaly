
clear ;
startup;
%% 1 - Load video features
load('../data/input/sec1.mat');
options.bin_size = 8;
options.tracklet_len=10;
options.shift_step=1;
options.hex = 0;
options.feat_type = 'dif_bin';
motion_feats = feats;
shift=0;

%% 2 - ITQ training over features
% scripted in : "train_itq_fc7.m"
disp('3 - ITQ training');
dims = size(motion_feats);
n_iter = 300;
temp_motion_feats=reshape(motion_feats,[dims(1)*dims(2)*dims(3) dims(4)]);
[ mean_fc7,itq_rot_mat,pca_mapping ] = train_itq( options.bin_size, n_iter, temp_motion_feats );

%% 3 - Convert fc7 feature maps to binary feature maps (for evaluation)
feat_dir = '../data/output/sp_val_alex/';
out_dir = '../data/input/sec_sp_val.mat';
fprintf('Read data files...\n');
feats = concat_feats_cell( feat_dir , 0);
fprintf(['Save data to a single file: ' out_dir '\n']);
save(out_dir, 'feats');


disp('4 - Generate binary features');
dims = size(feats);
h_img_size = dims(3);
w_img_size = dims(2);

project_mat = pca_mapping * itq_rot_mat;
tt = repmat(mean_fc7(1,:),[h_img_size 1]);
tt2 = repmat(tt,[w_img_size 1]);
tt2 = reshape(tt2,[w_img_size h_img_size 4096]);
feats_binary = zeros(dims(1),dims(2),dims(3),options.bin_size);

for idx=1:dims(1)
    data_features=reshape(feats(idx,:,:,:),[dims(2) dims(3) dims(4)]);
    data_features=bsxfun(@minus,tt2,data_features);
    data_features=bsxfun(@rdivide,data_features,sqrt(sum(data_features.^2,2)));
    c = multiprod(project_mat', permute(data_features,[3 2 1]));
    feats_binary(idx,:,:,:) = sign(max(permute(c,[3 2 1]),0));
end

%% 4 - Visualize and save heatmap video
disp('5 - Visualize heatmaps');
out_avi = '../data/output/out_sp_val.avi';
img_folder = '../data/validation_spatial_alex/';
resize_vis=3;

dims = size(feats_binary);
h_img_size = dims(2);
w_img_size = dims(3);
dirlist = dir([img_folder, '***.jpg']);
src_image = imread([img_folder dirlist(1).name]);

feats_img = zeros(size(src_image,1),size(src_image,2),dims(1));
bin_val_map = zeros(dims(2), dims(3), dims(1));
for sample_no=1:dims(1)
    result = reshape(feats_binary(sample_no,:,:,:),[dims(2) dims(3) options.bin_size]);
    img = zeros(h_img_size,w_img_size);
    for i=1:h_img_size
        for j=1:w_img_size
            img(i,j) = bi2de( reshape(result(i,j,:),[1 options.bin_size]), 'left-msb');
        end
    end
    %img = flip(img,1);
    %img = flip(img,2);
    bin_val_map(:,:,sample_no) = img;
    img = resize_binary_map( src_image, img );
    %img = flip(img,1);
    feats_img(:,:,sample_no) = img;
end
visualize_heat_avi( out_avi, img_folder, feats_img, shift, resize_vis,bin_val_map,options);

