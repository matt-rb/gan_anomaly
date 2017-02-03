
clear all
setenv('LC_ALL','C')
%startup
% AddPath
caffe_path = '/home/moin/GitHub/WeaSupObjDet/fast-rcnn/caffe-fast-rcnn/matlab/';
ss_path = '/home/moin/GitHub/WeaSupObjDet/rcnn/selective_search/';
addpath(genpath(caffe_path));
addpath(genpath(ss_path));


% Net init
n = 'model/bvlc_reference_caffenet.caffemodel';
d = 'model/imagenet_layer6.prototxt';
caffe('init', d, n, 'test')
caffe('set_mode_gpu');

% Data
dataset_path = '../../data/Test001';
img_names = dir([dataset_path '/*.tif']);
%[~,img_names] = textread([dataset_path,'/','images.txt'],'%d %s');
%[~,x,y,w,h] = textread([dataset_path,'/','bounding_boxes.txt'],'%d %f %f %f %f');
%bb_gt_all = [x,y,w+x-1,h+y-1]; % conver to [x1,y1,x2,y2]

num_image = length(img_names);
% im_selected = img_ids(1:num_image);
% fc7 = cell(num_image,1);

for im = 1 : num_image

    disp([num2str(im),' / ',num2str(num_image)]);
    image_name = [dataset_path,'/',img_names(im).name];
    image = imread(image_name);
    if size(image,3) ==1
        clear im_tmp;
        im_tmp(:,:,1) = image; im_tmp(:,:,2) = image; im_tmp(:,:,3) = image;
        clear image;
        image = im_tmp;
    end
    [h_,w_,c_]= size(image);
    boxes = select_boxes( w_, h_, 8 , 5 ,4);
    %boxes=boxes(:,[2 1 4 3]);
    % FC7 Extraction
    fc7 = region2score(image, boxes);
    save(['../../data/output/feat_fc6_nomean_test001/patch_feats',sprintf('_image_%-3.6d', im),'.mat'],'fc7','-v7.3');
end

