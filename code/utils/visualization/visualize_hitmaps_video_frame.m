function visualize_hitmaps_video_frame( video_folder, frame_format, heatmap_folder, save_folder, video_index )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
dispstat('','init');
if ~exist(save_folder,'dir')
    mkdir(save_folder);
end

frame_names= dir(fullfile(video_folder, frame_format));
heatmap_names= dir(fullfile(heatmap_folder, '*.mat'));

for frm_no=1:length(frame_names)
dispstat(['writing frame ' num2str(frm_no) '/' num2str(length(frame_names)) ]);
filename= fullfile(video_folder,frame_names(frm_no).name);
load(fullfile(heatmap_folder,heatmap_names(frm_no).name));
heatmap(0.06>heatmap)= 0;
%heatmap(0.06<heatmap & heatmap<0.15) = 0.15;
fused_frm = heatmap_vis(filename, heatmap);
%fused_frm = red_heatmap_vis (filename, heatmap);
imwrite(fused_frm,fullfile(save_folder,[num2str(video_index) '_' frame_names(frm_no).name]));
end
end

function fused_frm = red_heatmap_vis (filename, heatmap)
frm = imread(filename);
bg = repmat(frm,[1 1 3]);
fg = repmat(uint8(255.*heatmap),[1 1 3]);
fused_frm = imfuse(fg,bg,'Scaling','independent','ColorChannels',[1 2 2]);
end

function fused_frm = heatmap_vis (filename, heatmap)
    h_fg = imagesc(heatmap); set(gca,'xtick',[],'ytick',[]); colormap(jet); saveas(h_fg,'fg.jpg'); B_tmp = imread('fg.jpg'); B = imresize(B_tmp, [480 720]);
    tempo = imread(filename); %tempo = fliplr(tempo);
    h_bg = imagesc(repmat(tempo,[1 1 3])); set(gca,'xtick',[],'ytick',[]) %axis off; set(h,'edgecolor','none');
    saveas(h_bg,'bg.jpg'); F_tmp = imread('bg.jpg'); F = imresize(F_tmp, [480 720]);
    close all;
    display_img1_on_img2(F, B, 0.4); figure(gcf);
    fused_frm = getframe(gcf);
    fused_frm = fused_frm.cdata;
    close all;
    delete('bg.jpg','fg.jpg');
end
