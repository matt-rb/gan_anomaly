for i=1:size(all_OF,1)
    mkdir(sprintf('of_hoss/Ped2/Test/Test%03d',i))
    for j=1:size(all_OF,2)
        I = all_OF{i, j};
        if ~isempty(I)
        imwrite(I,sprintf('of_hoss/Ped2/Test/Test%03d/%3d.jpg',i,j));
        end
    end
end

of_root='of_hoss/Ped2/Test/';
of_out_root='of_hoss/Ped2/all_of/';

sample_counter=1;
listing = dir(of_root);
of_folder = listing([listing.isdir]);
of_folder= of_folder(arrayfun(@(x) x.name(1),of_folder) ~= '.');

for i=1:length(of_folder)
    of_list = dir([of_root of_folder(i).name]);
    of_list = of_list(arrayfun(@(x) x.name(1),of_list) ~= '.');
    for j=1:length(of_list)
        of_l = imread([of_root of_folder(i).name '/' of_list(j).name]);
        %of_l = of_l(:,:,3);
        of_l_name = sprintf('%s%04d.jpg', of_out_root, sample_counter);
        imwrite(of_l, of_l_name);
        sample_counter=sample_counter+1;
    end
end



target_root = 'results/of2app_unet/images/target/';
output_root = 'results/of2app_unet/images/output/';
sample_names= dir([target_root '*.jpg']);
targets =zeros(170,256,length(sample_names));
outputs=zeros(170,256,length(sample_names));
for i=1:length(sample_names)
    tt = imread([target_root '/' sample_names(i).name]);
    ot = imread([output_root '/' sample_names(i).name]);
    targets(:,:,i)= tt(:,:,1);
    outputs(:,:,i) = ot(:,:,1);
end
mean_target = mean(targets,3);
mean_output=mean(outputs,3);

tt = of(:,:,3);
mm= tt-130>1;
ft = repmat(uint8(mean_target),1,1,3)-target;
fo= repmat(uint8(mean_target),1,1,3)-out;
image(((ft(:,:,1)-fo(:,:,1)) .* uint8(mm)));

image(((repmat(uint8(mean_target),1,1,3)-target) .* uint8(mm)).^2);
image(repmat(uint8(mean_target),1,1,3))
image(target)
image(abs(target-repmat(uint8(mean_target),1,1,3)))
image((target(:,:,1)-uint8(mean_target)));
imshow(targets(:,:,4))
