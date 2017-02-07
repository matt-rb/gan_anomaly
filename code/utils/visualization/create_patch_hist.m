function create_patch_hist( bin_val_map, motion_feats_img, out_hist_dir, options )
%UNTITLED13 Summary of this function goes here
%   Detailed explanation goes here

dispstat('','init');
dispstat('Creating histogram files...','keepthis');
map_size=size(bin_val_map);
if exist(out_hist_dir,'dir')
    rmdir(out_hist_dir,'s');
end
mkdir(out_hist_dir);

for patch_y=1:map_size(1)
    for patch_x=1:map_size(2)
        dispstat(['writing hist for patch : '...
            num2str(patch_y) '-' num2str(patch_x) ' for map : '...
            num2str(map_size(1)) 'x' num2str(map_size(2)) ]);
        f=figure;
        hist_data = bin_val_map(patch_y,patch_x,:);
        bar(reshape(hist_data,[1 map_size(3)]));
        saveas(f, [out_hist_dir '/hist_h_' num2str(patch_y) '_w_' num2str(patch_x) '.png']);
        close;
    end
end

end

