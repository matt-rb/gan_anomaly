
%% Heatmaps and frames directories (test videos)
heatmaps_root = '/home/mahdyar/Documents/MATLAB/gan_anomaly/data/UCSD/ped2/fused_heatmaps/';
videos_root = '/home/mahdyar/Documents/MATLAB/gan_anomaly/data/UCSD_original/ped2/test/';
save_root = '/home/mahdyar/Documents/MATLAB/gan_anomaly/data/UCSD/visualizations/ped2/fused/';
video_lst = dir(videos_root);
video_lst = video_lst([video_lst.isdir]);
video_lst= video_lst(arrayfun(@(x) x.name(1),video_lst) ~= '.');
frame_format = '*.tif'; % image frames format

%% Create visualization
for i=1:length(video_lst)
    fprintf('visualizing video %03d/%03d\n',i,length(video_lst));
    video_name = video_lst(i).name;
    video_folder = fullfile(videos_root, video_name);
    heatmap_folder = fullfile(heatmaps_root, video_name);
    save_folder = fullfile(save_root, video_name);
    visualize_hitmaps_video_frame( video_folder, frame_format, heatmap_folder, save_folder, i );
end