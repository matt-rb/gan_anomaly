
%% feature extraction
setenv('LC_ALL','C')
addpath('/home/moin/GitHub/AbnormalityGAN/feature_extraction/');
addpath('/home/moin/GitHub/AbnormalityGAN/utils/');
dispstat('','init');

caffe_path = '/home/moin/GitHub/WeaSupObjDet/fast-rcnn/caffe-fast-rcnn/matlab/';
addpath(genpath(caffe_path));

% set the GPU ID
n = '/home/moin/GitHub/AbnormalityGAN/feature_extraction/model/bvlc_reference_caffenet.caffemodel';
d = '/home/moin/GitHub/AbnormalityGAN/feature_extraction/model/imagenet_conv5.prototxt';

caffe('init', d, n, 'test')
caffe('set_mode_gpu');

feat_type='conv5';

dataset_roots={'/home/moin/GitHub/AbnormalityGAN/data/of2app_ped1/target/',...
               '/home/moin/GitHub/AbnormalityGAN/data/of2app_ped1/output/'};
save_feats_roots={['/home/moin/GitHub/AbnormalityGAN/data/of2app_ped1/feats/target/' feat_type '/'],...
    ['/home/moin/GitHub/AbnormalityGAN/data/of2app_ped1/feats/output/' feat_type '/']};

%dataset_roots={'/home/moin/GitHub/AbnormalityGAN/data/of2app_squred/target/',...
%               '/home/moin/GitHub/AbnormalityGAN/data/of2app_squred/output/'};
%save_feats_roots={['/home/moin/GitHub/AbnormalityGAN/data/of2app_squred/feats/target/' feat_type '/'],...
%    ['/home/moin/GitHub/AbnormalityGAN/data/of2app_squred/feats/output/' feat_type '/']};

for dt_idx=1:length(dataset_roots)
    
dataset_root = dataset_roots{dt_idx};
save_feats_root = save_feats_roots{dt_idx};

video_names = dir([dataset_root 'f*']);
num_videos = length(video_names);

for video_idx=1:num_videos

video_feat_path_folder = [save_feats_root video_names(video_idx).name];
if ~exist(video_feat_path_folder,'dir')
    mkdir(video_feat_path_folder)
end
% Data
dataset_path = [dataset_root video_names(video_idx).name];
img_names = dir([dataset_path '/*.jpg']);

num_image = length(img_names);
% im_selected = img_ids(1:num_image);
% fc7 = cell(num_image,1);

for im = 1 : num_image
    dispstat(['dataset: ' num2str(dt_idx) ' video ' num2str(video_idx) '/' num2str(num_videos) ' -- farme: ' num2str(im),' / ',num2str(num_image)]);
    image_name = [dataset_path,'/',img_names(im).name];
    img = imread(image_name);
    feat = caffe('forward', {single(img)}); 
    feat = feat{1};
    %save([save_feats_root video_names(video_idx).name '/patch_feats',sprintf('_image_%-3.6d', im),'.mat'],'fc7','-v7.3');
    save([video_feat_path_folder '/',img_names(im).name,'.mat'],'feat','-v7.3');
    %save([video_feat_path_folder '/patch_feats_',sprintf('_image_%-3.6d', im),'.mat'],'fc7','-v7.3');
    %disp(['saved to :' video_feat_path_folder '/patch_feats_',sprintf('_image_%-3.6d', im),'.mat']);
end
end
end