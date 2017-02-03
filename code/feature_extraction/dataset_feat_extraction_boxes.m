
clear
addpath('../utils');
dispstat('','init');
setenv('LC_ALL','C');

caffe_path = '/home/moin/GitHub/WeaSupObjDet/fast-rcnn/caffe-fast-rcnn/matlab/';
ss_path = '/home/moin/GitHub/WeaSupObjDet/rcnn/selective_search/';
addpath(genpath(caffe_path));
addpath(genpath(ss_path));


% Net init
n = 'model/bvlc_reference_caffenet.caffemodel';
d = 'model/imagenet_layer5.prototxt';
caffe('init', d, n, 'test')
caffe('set_mode_gpu');

feat_type='pool5';

dataset_roots={'/home/moin/GitHub/AbnormalityGAN/data/of2app_unet_samples/target/',...
               '/home/moin/GitHub/AbnormalityGAN/data/of2app_unet_samples/output/'};
save_feats_roots={['/home/moin/GitHub/AbnormalityGAN/data/of2app_unet_samples/feats/target/' feat_type '/'],...
    ['/home/moin/GitHub/AbnormalityGAN/data/of2app_unet_samples/feats/output/' feat_type '/']};

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
    image = imread(image_name);
    if size(image,3) ==1
        clear im_tmp;
        im_tmp(:,:,1) = image; im_tmp(:,:,2) = image; im_tmp(:,:,3) = image;
        clear image;
        image = im_tmp;
    end
    [h_,w_,c_]= size(I_f);
    boxes = select_boxes( w_, h_, 8 , 5 , 6);
    %boxes=boxes(:,[2 1 4 3]);
    % FC7 Extraction
    fc7 = region2score(image, boxes);
    %save([save_feats_root video_names(video_idx).name '/patch_feats',sprintf('_image_%-3.6d', im),'.mat'],'fc7','-v7.3');
    save([video_feat_path_folder '/feats_',img_names(im).name,'.mat'],'fc7','-v7.3');
    %save([video_feat_path_folder '/patch_feats_',sprintf('_image_%-3.6d', im),'.mat'],'fc7','-v7.3');
    %disp(['saved to :' video_feat_path_folder '/patch_feats_',sprintf('_image_%-3.6d', im),'.mat']);
end
end
end
