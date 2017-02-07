

load('/home/mahdyar/Documents/MATLAB/gan_anomaly/code/variables/ped2.mat')

original_frm_dir='/home/mahdyar/Documents/MATLAB/gan_anomaly/data/UCSD/ped2/frm/test/';
generated_frm_dir='/home/mahdyar/Documents/MATLAB/gan_anomaly/data/UCSD/ped2/of2app/of2app_output/';

original_of_dir='/home/mahdyar/Documents/MATLAB/gan_anomaly/data/UCSD/ped2/of/test/';
generated_of_dir='/home/mahdyar/Documents/MATLAB/gan_anomaly/data/UCSD/ped2/app2of/output_of/';

output_dir='/home/mahdyar/Documents/MATLAB/gan_anomaly/code/results/ped2/visualization/conf/';

frame_no = get_frame_number( 3, 65, ds_info );

gt_frm=imread(sprintf('%s%04d.jpg',original_frm_dir,frame_no));
fk_frm=imread(sprintf('%s%04d.jpg',generated_frm_dir,frame_no));
fk_frm=imresize(fk_frm,[ size(gt_frm,1) size(gt_frm,2)]);
gt_of=imread(sprintf('%s%04d.jpg',original_of_dir,frame_no));
fk_of=imread(sprintf('%s%04d.jpg',generated_of_dir,frame_no));
fk_of=imresize(fk_of,[ size(gt_of,1) size(gt_of,2)]);

imwrite(gt_frm,sprintf('%s%04d_frame_original.jpg',output_dir,frame_no));
imwrite(fk_frm,sprintf('%s%04d_frame_fake.jpg',output_dir,frame_no));
imwrite(gt_of,sprintf('%s%04d_of_original.jpg',output_dir,frame_no));
imwrite(fk_of,sprintf('%s%04d_of_fake.jpg',output_dir,frame_no));