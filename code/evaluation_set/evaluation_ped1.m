%% Setting Options
clear all
clc;
startup;
dispstat('','init');
options.resize_to = [158 238];


%% Collecting data
% prepare data from appearance and optical-flow streams features
disp('1- Collecting heatmaps data...');
%% 1.1- collect CNN appearance heatmaps(distances between cnn feats_target and feats_output)
disp('Generate Appearance heatmaps...');
target_root = '/home/mahdyar/Documents/MATLAB/gan_anomaly/data/UCSD/ped1/of2app/target_conv5/';
output_root = '/home/mahdyar/Documents/MATLAB/gan_anomaly/data/UCSD/ped1/of2app/output_conv5/';
of_root = '/home/mahdyar/Documents/MATLAB/gan_anomaly/data/UCSD/ped1/of/';
app_heatmap_root = '/home/mahdyar/Documents/MATLAB/gan_anomaly/data/UCSD/ped1/of2app/heatmaps_conv5/';
generate_heatmap_app(  target_root, output_root, app_heatmap_root );
app_heats = of_masking( app_heatmap_root, of_root );
save([app_heatmap_root 'all_heats/heatmaps_ofsub.mat'],'app_heats','-v7.3');
%load([app_heatmap_root 'all_heats/heatmaps_ofsub.mat']);

%% 1.2- collect OF heatmaps
disp('Generate OF heatmaps...');
target_root = '/home/mahdyar/Documents/MATLAB/gan_anomaly/data/UCSD/ped1/app2of/target/';
output_root = '/home/mahdyar/Documents/MATLAB/gan_anomaly/data/UCSD/ped1/app2of/output/';
of_root = '/home/mahdyar/Documents/MATLAB/gan_anomaly/data/UCSD/ped1/of/';
of_heatmap_root = '/home/mahdyar/Documents/MATLAB/gan_anomaly/data/UCSD/ped1/app2of/heatmaps_of/';
% distance methods:
% 1- diff_of = uotput_of - target_of
% 2- diff_mag = uotput_mag - target_mag
% 3- diff_magof = uotput_of(:,:,3) - target_of(:,:,3)
% 4- diff_mag_vs_magof = uotput_of(:,:,3) - target_mag
% 5- dif_sum_rgb = sum(out_of2app,3) - sum(taget_of2app,3)
% 6- dif_magof_ofMasked = ((target(:,:,1)-out(:,:,1)) *. (OF>th)
method= 'diff_magof';
generate_heatmap_of(target_root, output_root, of_heatmap_root, method);
of_heats = of_masking( of_heatmap_root, of_root );
save(sprintf('%s/all_heats/heatmaps_%s.mat',of_heatmap_root,method), 'of_heats','-v7.3');
load(sprintf('%s/all_heats/heatmaps_%s.mat',of_heatmap_root,method));


%% 2- Split frames per video
load ('/home/mahdyar/Documents/MATLAB/gan_anomaly/code/variables/ped1.mat')
disp('2- Splitting frames per videos for OF...');
of_per_video = split_frames2videos( of_heats, ds_info , options);
clear 'of_heats';
disp('Splitting frames per videos for App...');
app_per_video = split_frames2videos( app_heats, ds_info , options);
clear 'app_heats';


%% 3- Normalization per video sequence
disp('3- Normalize heatmaps per videos...');
of_seg_all = normalize_data_per_video( of_per_video );
clear 'of_per_video';
app_seg_all = normalize_data_per_video( app_per_video );
clear 'app_per_video';


%% 4- Feature fusion
disp('4- Fusing features...');
seg_all = fuse_features( app_seg_all , of_seg_all );
%seg_all = normalize_data_per_video( seg_all );


%% 5- Evaluation 
disp('5- Evaluation started...');
%% 5.1- Creat GT and Evaluation setup
%UCSDped1;
%gt_folder = '/home/mahdyar/Documents/MATLAB/gan_anomaly/data/UCSD/ped1/gt';
%[ImgGrandtruth,TestVideoFile_new] = Create_GT_UCSD_Frame(gt_folder,TestVideoFile);
%save('/home/mahdyar/Documents/MATLAB/gan_anomaly/code/variables/gt_ped1.mat','ImgGrandtruth','TestVideoFile_new','-v7.3');
load('/home/mahdyar/Documents/MATLAB/gan_anomaly/code/variables/gt_ped1.mat');

options.itrnum = 21;
options.ClipOfFrame = 0;
options.threshold_pixellevel = 0.39;
options.th_roc = 300;
options.eval_filename ='2_roc_fuse2x1';

%% 5.2- Evaloation frame level
options.roc_file_name = ['/home/mahdyar/Documents/MATLAB/gan_anomaly/code/results/ped1/roc/frame/' options.eval_filename '.png'];
result = SegmentResultMatrix_frame_level(seg_all,TestVideoFile_new,options);
TP1 = TruePositiveValue_frame_level(result,seg_all,options);
[TPR,FPR,Roc1] = ROCValue_frame_level(TP1,seg_all,options);
Roc1(:,2)=1-Roc1(:,2);
auc_frm = trapz(Roc1(:,2),Roc1(:,1));
roc_frm = Roc1;
fprintf('AUC frame-level : %f\n',auc_frm);

close all
disp('Plot ROC');
plot(Roc1(:,2),Roc1(:,1),'-*')
hold on
plot([0 1] ,[1 0],'red')
grid on
xlabel('FPR'); ylabel('TPR')
title('ROC frame-level')
print(options.roc_file_name,'-dpng');

%% 5.3- Evaloation pixel level
options.roc_file_name = ['/home/mahdyar/Documents/MATLAB/gan_anomaly/code/results/ped1/roc/pixel/' options.eval_filename '.png'];
result = SegmentResultMatrix(seg_all,TestVideoFile_new,ImgGrandtruth,options);
TP1 = TruePositiveValue(result,seg_all,options);
[TPR,FPR,Roc1] = ROCValue(TP1,seg_all,options);
auc_pixel = trapz(Roc1(:,2),Roc1(:,1));
roc_pixel = Roc1;
fprintf('AUC pixel-level : %f\n',auc_pixel);

close all
disp('Plot ROC');
plot(Roc1(:,2),Roc1(:,1),'-*')
hold on
plot([0 1] ,[1 0],'red')
grid on
xlabel('FPR'); ylabel('TPR')
title('ROC pixel-level')
print(options.roc_file_name,'-dpng');

save(['/home/mahdyar/Documents/MATLAB/gan_anomaly/code/results/ped1/roc/' options.eval_filename '.mat'],'auc_pixel','auc_frm','roc_frm','roc_pixel');
