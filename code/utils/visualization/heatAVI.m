function heatAVI( dic_img, feat_matrix, out_avi,tp_size )
% This function is for visualizing heat map using a heat matrix and image
% directory. "dic_img" is directory of images. matrix is heat map 3d matrix.
% "tp_size" is the internval we use for frame sampling.
% frame names are starting with "frame*"
% Code is written by Moin Nabi
%   heatAVI( 'C:TEMP\', matrix, 50 )
%   dic_img='C:\temp\new\'
%   tp_size=50;

dispstat('','init');
dispstat('Creating video file...','keepthis');
dirlist = dir([dic_img, '***.jpg']);
num_files = length(dirlist);
filenames = cell(num_files, 1);

for i = 1 : num_files
    filenames{i} = dirlist(i).name;
end

%aviobj1 = avifile('out.avi','compression','None','fps',3);
aviobj1 = VideoWriter(out_avi);
aviobj1.FrameRate = 15;
open(aviobj1);

%for frame = 1 : uint16(floor(num_files/tp_size))
for frame = 1 : size(feat_matrix,3)
    dispstat(['writing frame ' num2str(frame) '/' num2str(size(feat_matrix,3)) ]);
    %filename = [dic_img, filenames{( (frame-1)*10+5 )}];
    filename = [dic_img, filenames{frame+tp_size}];
    filename=fullfile(video_folder,frame_names(frm_no).name);
    h_fg = imagesc(imread(filename)); set(gca,'xtick',[],'ytick',[]); saveas(h_fg,'fg.jpg'); B_tmp = imread('fg.jpg'); B = imresize(B_tmp, [480 720]);
    tempo = feat_matrix(:,:,frame)'; %tempo = fliplr(tempo);
    h_bg = imagesc(tempo); set(gca,'xtick',[],'ytick',[]) %axis off; set(h,'edgecolor','none');
    saveas(h_bg,'bg.jpg'); F_tmp = imread('bg.jpg'); F = imresize(F_tmp, [480 720]);
    close all;
    display_img1_on_img2(F, B, 0.5); figure(gcf);
    Frame_avi = getframe(gcf);
    close all;
    %aviobj1 = addframe(aviobj1,Frame_avi);
    writeVideo(aviobj1,Frame_avi);     
end
%aviobj1 =  close(aviobj1);
close(aviobj1);
close all;
end

