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