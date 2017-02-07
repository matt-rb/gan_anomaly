function visualize_heat_parzen_window( out_avi, img_folder, feat_matrix , resize_vis, bin_val_map,options)
%% Visualize parzen window heatmap on the frames. Fusion heat matrix over farmes with
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
dirlist = dir([img_folder, '***.jpg']);
aviobj1 = VideoWriter(out_avi);
aviobj1.FrameRate = 15;
open(aviobj1);

dims= size(feat_matrix);
frms=dims(3);
n_feats = floor((frms-options.tracklet_len)/options.shift_step); 

%% fusion heatmaps and frames

for sample_no=1:n_feats
    dispstat(['writing frame ' num2str(sample_no) '/' num2str(n_feats) ]);
    start=1;
    avg_feats = zeros(dims(1),dims(2));
    for w=1:dims(2)
        for h=1:dims(1)
           tracklet_feats=feat_matrix(h,w,start:start+options.tracklet_len-1);
           tmp_avg_feats = mean(tracklet_feats,3);
           avg_feats(h,w)=tmp_avg_feats;
        end
    end
    
    img_background= abs(feat_matrix(:,:,sample_no+options.tracklet_len)-avg_feats);
    
    img_org_name = [img_folder dirlist(sample_no+options.tracklet_len).name];
    org_img= imread(img_org_name);
    fusion = imfuse(img_background,org_img,'Scaling','independent','ColorChannels',[1 2 0]);

    h_th = floor(size(feat_matrix,1)/size(bin_val_map,1));
    w_th = floor(size(feat_matrix,2)/size(bin_val_map,2));
    fusion = imresize(fusion,resize_vis);
    for h_idx=1:size(bin_val_map,1)
        for w_idx=1:size(bin_val_map,2)
            position =  [(w_idx-1)*w_th*resize_vis (h_idx-1)*h_th*resize_vis+30];
            if strcmp(options.feat_type,'dif_bin')
                if options.hex
                    dist = mean(bin_val_map(h_idx,w_idx,sample_no:sample_no+options.tracklet_len-1));
                    fusion = insertText(fusion,position,abs(bin_val_map(h_idx,w_idx,sample_no+options.tracklet_len)-dist),'AnchorPoint','LeftBottom');
                else
                val1= de2bi( bin_val_map(h_idx,w_idx,sample_no), options.bin_size, 'left-msb');
                val2 = de2bi( bin_val_map(h_idx,w_idx,sample_no+1),options.bin_size, 'left-msb');
                %fusion = insertText(fusion,position,abs(val1-val2),'AnchorPoint','LeftBottom');
                fusion = insertText(fusion,position,pdist([val1 ; val2], 'minkowski',1),'AnchorPoint','LeftBottom');
                end
            else
                fusion = insertText(fusion,position,bin_val_map(h_idx,w_idx,sample_no),'AnchorPoint','LeftBottom');
            end
        end
    end
    %imwrite(fusion,['../data/output/frms/' dirlist(sample_no+shift).name]);
    writeVideo(aviobj1,fusion);
    %w = waitforbuttonpress;
end
close(aviobj1);
end

