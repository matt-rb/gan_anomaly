function visualize_heat_avi( out_avi, img_folder, feat_matrix , bin_val_map,options)
%% Visualize heatmap on the frames. Fusion heat matrix over farmes with
% "shift" frames.
%   input:
%       - out_avi : output file address
%       - img_folder : folder contains .jpg frames
%       - feat_matrix : 3D matrix [X Y N], where [X Y] are heat matrix for
%                       each frame, and N is totall number of heat maps.
%       - shift : to adjust beginig frame.
%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% read frame folder and initialize video writer object
dispstat('','init');
dispstat('Creating video file...','keepthis');
dirlist = dir([img_folder, '***.tif']);
dirlist_gt = dir([options.gt_folder, '***.bmp']);
aviobj1 = VideoWriter(out_avi);
aviobj1.FrameRate = 15;
open(aviobj1);

%% fusion heatmaps and frames
for sample_no=1:size(feat_matrix,3)
    dispstat(['writing frame ' num2str(sample_no) '/' num2str(size(feat_matrix,3)) ]);
    img_background= feat_matrix(:,:,sample_no);
    img_org_name = [img_folder dirlist(sample_no+options.shift).name];
    img_gt_name = [options.gt_folder dirlist_gt(sample_no+options.shift).name];
    img_gt=imread(img_gt_name);
    org_img= imread(img_org_name);
    % Moin touch
    max_val=max(img_background(:));
    img_background = img_background .* (1/max_val);
    fusion = imfuse(img_background,org_img,'Scaling','none', 'ColorChannels',[1 2 2]);
    %fusion = imfuse(fusion,img_gt, 'ColorChannels',[1 1 2]);
    %fusion = imfuse(img_background,org_img,'Scaling','independent','ColorChannels',[1 2 2]);
    h_th = floor(size(feat_matrix,1)/size(bin_val_map,1));
    w_th = floor(size(feat_matrix,2)/size(bin_val_map,2));
    fusion = imresize(fusion,options.resize_vis);
%     for h_idx=1:size(bin_val_map,1)
%         for w_idx=1:size(bin_val_map,2)
%             position = [(w_idx-1)*w_th*options.resize_vis (h_idx-1)*h_th*options.resize_vis+30];
%             fusion = insertText(fusion,position,bin_val_map(h_idx,w_idx,sample_no),'AnchorPoint','LeftBottom');
%         end
%     end
    if options.save_frames
        save_dir = ['../data/output/frms/ped1/' options.name_ext ];
        if ~exist(save_dir,'dir')
            mkdir(save_dir);
        end
        imwrite(fusion,[save_dir '/' dirlist(sample_no+options.shift).name]);
    end
    writeVideo(aviobj1,fusion);
end
close(aviobj1);
end

