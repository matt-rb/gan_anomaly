function [batches, batch_padding] = image2region(im, boxes, batch_size, image_mean)
% Apodped from RCNN/rcnn_extract_regions.m
% by Moin
im = single(im(:,:,[3 2 1]));
num_boxes = size(boxes, 1);
%batch_size = 256;
num_batches = ceil(num_boxes / batch_size);
batch_padding = batch_size - mod(num_boxes, batch_size);
if batch_padding == batch_size
  batch_padding = 0;
end

crop_mode = 'warp';
%image_mean = rcnn_model.cnn.image_mean;
crop_size = size(image_mean,1);
crop_padding = 16;%rcnn_model.detectors.crop_padding;

batches = cell(num_batches, 1);
%for batch = 1:num_batches
%par
for batch = 1:num_batches
  batch_start = (batch-1)*batch_size+1;
  batch_end = min(num_boxes, batch_start+batch_size-1);

  ims = zeros(crop_size, crop_size, 3, batch_size, 'single');
  for j = batch_start:batch_end
    bbox = boxes(j,:);
    crop = rcnn_im_crop(im, bbox, crop_mode, crop_size, ...
        crop_padding, image_mean);
    % swap dims 1 and 2 to make width the fastest dimension (for caffe)
    ims(:,:,:,j-batch_start+1) = permute(crop, [2 1 3]);
  end

  batches{batch} = ims;
end