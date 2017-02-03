function fused_feats = fuse_features( app_feats , of_feats, method )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
dispstat('','init');
fused_feats = cell(size(app_feats));
for vidnum=1:size(app_feats,1)
    dispstat(['processing video : ' num2str(vidnum)])
    for iM=1 : length(find(~cellfun(@isempty,app_feats(vidnum,:))))
        %fused_feats{vidnum,iM} = app_feats{vidnum,iM} .* of_feats{vidnum,iM};
        %fused_feats{vidnum,iM} = (app_feats{vidnum,iM} + of_feats{vidnum,iM})/2;
        %fused_feats{vidnum,iM} = (app_feats{vidnum,iM}*2) .* of_feats{vidnum,iM};
        fused_feats{vidnum,iM} = (app_feats{vidnum,iM} + (of_feats{vidnum,iM}*3))/4;
    end
end
%fused_feats = normalize_data_per_video( seg_all );
end

