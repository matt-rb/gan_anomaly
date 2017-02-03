function generate_heatmap_app(  target_root, output_root, heatmap_root )
%generate_heatmap_app create a heat map for target set and output set
%   target_root : directory of all the target cnn feats (GT)
%   output_root : directory of all the output cnn feats (generated)
%   heatmap_root : directory of all the computed heatmaps (distances)

if ~exist(heatmap_root,'dir')
    mkdir(heatmap_root)
end

img_names = dir([target_root '/*.mat']);
fprintf('%03d samples found!\n',size(img_names,1));

num_image = length(img_names);
for im = 1 : num_image
    dispstat(sprintf('generate heatmap %04d/%04d',im,num_image));
    load([output_root,img_names(im).name],'feat');
    image_output = feat;
    load([target_root,img_names(im).name],'feat');
    image_target = feat;
    [s1,s2,~]= size(image_target);
    heatmap=zeros(s1,s2);
    for i=1:s1
        for j = 1:s2
            heatmap(i,j) = norm(reshape(image_output(i,j,:),[1,size(feat,3)]) - reshape(image_target(i,j,:),[1,size(feat,3)]));
        end
    end
    save(sprintf('%s%s',heatmap_root,img_names(im).name), 'heatmap');
end
end



