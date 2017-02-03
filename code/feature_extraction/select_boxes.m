function  boxes = select_boxes( img_w, img_h, w , h, cell_count)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

boxes = zeros(w*h,cell_count);
w_step = floor(img_w/w);
h_step = floor(img_h/h);

box_idx=1;
for i=1:h
    for j=1:w
        if cell_count == 6
            boxes(box_idx,:)= [(j-1)*w_step+1 (i-1)*h_step+1 j*w_step i*h_step i j];
        else
            boxes(box_idx,:)= [(j-1)*w_step+1 (i-1)*h_step+1 j*w_step i*h_step];
        end
        box_idx= box_idx+1;
    end
end

end

