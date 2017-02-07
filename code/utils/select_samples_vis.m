%fprintf('\nPress any key: ') ;
%ch = getkey ;
%fprintf('%c\n',ch) ;
load('/home/mahdyar/Documents/MATLAB/gan_anomaly/code/variables/ped2.mat')
heatmaps_folder = '/home/mahdyar/Documents/MATLAB/gan_anomaly/data/UCSD/visualizations/ped1/fused/';

original_frm_dir='/home/mahdyar/Documents/MATLAB/gan_anomaly/data/UCSD/ped1/frm/test/';
generated_frm_dir='/home/mahdyar/Documents/MATLAB/gan_anomaly/data/UCSD/ped1/of2app/of2app_output/';

original_of_dir='/home/mahdyar/Documents/MATLAB/gan_anomaly/data/UCSD/ped1/of/test/';
generated_of_dir='/home/mahdyar/Documents/MATLAB/gan_anomaly/data/UCSD/ped1/app2of/output_of/';

output_vis='/home/mahdyar/Documents/MATLAB/gan_anomaly/code/results/ped1/visualization/good/';
output_conf='/home/mahdyar/Documents/MATLAB/gan_anomaly/code/results/ped1/visualization/conf/';


 vid_idx=36;
frames_name = dir(fullfile(heatmaps_folder, sprintf('Test%03d/*.tif',vid_idx)));
frame_vid = 92;
while (frame_vid<200)
frame_no=(200*(vid_idx-1))+frame_vid;
figure('Name',sprintf('video %03d frame %03d',vid_idx, frame_vid),'units','normalized','outerposition',[0 0 1 1]);
%set(gcf, 'Position', get(0, 'Screensize'));
gt_frm=imread(sprintf('%s%04d.jpg',original_frm_dir,frame_no));
fk_frm=imread(sprintf('%s%04d.jpg',generated_frm_dir,frame_no));
fk_frm=imresize(fk_frm,[ size(gt_frm,1) size(gt_frm,2)]);
heat_img=imread(sprintf('%sTest%03d/%s',heatmaps_folder,vid_idx,frames_name(frame_vid).name));
heat_img_dsp = imresize(heat_img,[ size(gt_frm,1) size(gt_frm,2)]);
gt_of=imread(sprintf('%s%04d.jpg',original_of_dir,frame_no));
fk_of=imread(sprintf('%s%04d.jpg',generated_of_dir,frame_no));
fk_of=imresize(fk_of,[ size(gt_of,1) size(gt_of,2)]);
imshow([heat_img_dsp repmat(gt_frm,[1 1 3]) fk_frm gt_of fk_of]);
ch = getkey ;
close all
if ch == 27
    close all;
    break;
end
if ch == 29
    frame_vid=frame_vid+1;
end
if ch == 28 && frame_vid>1 
    frame_vid=frame_vid-1;
end
if ch == 99 %% 'C' key to select confusion samples
    imwrite(heat_img,sprintf('%s%04d.jpg',output_conf,frame_no));
    imwrite(gt_frm,sprintf('%s%04d_frame_original.jpg',output_conf,frame_no));
    imwrite(fk_frm,sprintf('%s%04d_frame_fake.jpg',output_conf,frame_no));
    imwrite(gt_of,sprintf('%s%04d_of_original.jpg',output_conf,frame_no));
    imwrite(fk_of,sprintf('%s%04d_of_fake.jpg',output_conf,frame_no));
end
if ch == 13 %% 'ENTER' key to select good frames
    imwrite(heat_img,sprintf('%s%04d.jpg',output_vis,frame_no));
    imwrite(gt_frm,sprintf('%s%04d_frame_original.jpg',output_vis,frame_no));
    imwrite(fk_frm,sprintf('%s%04d_frame_fake.jpg',output_vis,frame_no));
    imwrite(gt_of,sprintf('%s%04d_of_original.jpg',output_vis,frame_no));
    imwrite(fk_of,sprintf('%s%04d_of_fake.jpg',output_vis,frame_no));
end
end