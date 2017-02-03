function seg_all = normalize_data_per_video( seg_all )
dispstat('','init');
    for vide_sample=1:size(seg_all,1)
        dispstat(sprintf('normalizing video %02d/%02d',vide_sample,size(seg_all,1)));
        tt = seg_all(vide_sample,:);
        max_val_video = max(max([tt{:,:}]));
        tt = cellfun(@(x) x/max_val_video, tt, 'UniformOutput',false);
        seg_all(vide_sample,:) = tt;
    end
end

