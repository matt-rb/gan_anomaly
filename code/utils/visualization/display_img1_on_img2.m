function display_img1_on_img2(img_background, img_foreground, thershold)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

% imR= img_foreground(:,:,1);  imG= img_foreground(:,:,2);  imB= img_foreground(:,:,3);
% ind = imB>200;
% imR(ind) = 255; imB(ind) = 255; imG(ind) = 255;
% 
% im_trans = cat(3, imR,imG,imB);
% figure, imshow(img_background), hold on
% h = imshow(im_trans);
% set(h, 'AlphaData', thershold)

%% using hsv
% imB= img_foreground(:,:,3);
ind = img_foreground(:,:,1)<100 & img_foreground(:,:,2)<100 & img_foreground(:,:,3)>200;
imhsv = rgb2hsv(img_foreground);
imI = imhsv(:,:,3);
imI(ind) = 0;
imhsv(:,:,3) = imI;
im_trans = hsv2rgb(imhsv);

figure, imshow(img_background), hold on
h = imshow(im_trans);
set(h, 'AlphaData', thershold)

end
