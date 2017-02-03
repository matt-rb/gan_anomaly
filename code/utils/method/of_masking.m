function app_heats_masked = of_masking( app_heatmap_root, of_root )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
dispstat('','init');
feat_list = dir([of_root '*.jpg']);
app_heats_masked=cell(length(feat_list),1);
for frm_no=1:length(feat_list)
    dispstat(sprintf('masking %04d/%04d %s',frm_no,length(feat_list)));
    % read OF image
    frm_of = imread ([of_root feat_list(frm_no).name]);
    tt = frm_of(:,:,3);
    mm= tt-130>1;
    resize_to = size(tt);
    
    % Load heatmap file
    load( [app_heatmap_root feat_list(frm_no).name '.mat']);
    heatmap = imresize(heatmap,resize_to);
    
    % masking heatmap by OF
    diff=(double(heatmap) .* double(mm));
    app_heats_masked{frm_no} = diff;
end
end

