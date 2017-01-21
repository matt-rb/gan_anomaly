all_samples=21;
for sample_no=1:all_samples
for i=1:40

    %res(i) = w_matrix(bin_feats_output{sample_no, 1}(i),bin_feats_target{sample_no, 1}(i));
    %res(i) = bin_feats_output{sample_no, 1}(i)-bin_feats_target{sample_no, 1}(i);
    %res(i) = w_matrix(bin_feats_target{sample_no, 1}(i),bin_feats_target{sample_no+1, 1}(i));
    %res(i) = bin_feats_target{sample_no, 1}(i,:)-bin_feats_target{sample_no+1, 1}(i);
    res(i) = pdist([bin_feats_target{sample_no, 1}(i,:) ; bin_feats_target{sample_no+1, 1}(i,:)],'minkowski',1);

end
reshape(res,5,8)
    imagesc(reshape(res,5,8))
    %imshow(reshape(res,5,8))
file_name=['gan/result_gan/' sprintf('%.2d', sample_no) '_distance_celaster_target.png'];
print(file_name,'-dpng');
end

