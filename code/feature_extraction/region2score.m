function feat = region2score(im, boxes)
% Adopted from RCNN/rcnn_features.m
% by Moin Nabi

ImageMean = load('image_mean.mat','image_mean'); image_mean = ImageMean.image_mean;
batch_size = 1;

[batches, batch_padding] = image2region(im, boxes, batch_size, image_mean); % MOIN: can be speed up with PARFOR

% compute features for each batch of region images
feat_dim = -1;
feat = [];
curr = 1;
for j = 1:length(batches)
  % forward propagate batch of region images 
  f = caffe('forward', batches(j));
  f = f{1};
  f = f(:);
  
  % first batch, init feat_dim and feat
  if j == 1
    feat_dim = length(f)/batch_size;
    feat = zeros(size(boxes, 1), feat_dim, 'single');
  end

  f = reshape(f, [feat_dim batch_size]);

  % last batch, trim f to size
  if j == length(batches)
    if batch_padding > 0
      f = f(:, 1:end-batch_padding);
    end
  end

  feat(curr:curr+size(f,2)-1,:) = f';
  curr = curr + batch_size;
end