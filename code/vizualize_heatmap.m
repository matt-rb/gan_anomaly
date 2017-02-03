%% initialize target/output/heatmap folders
%target_root = '../data/gan_out/target_of/';
%output_root = '../data/gan_out/output_mag/';
%heatmap_root = '../data/gan_out/heatmap_magof_vs_mag/';

target_root = 'results/of2app_unet/images/target/';
output_root = 'results/of2app_unet/images/output/';
of_root = 'results/of2app_unet/images/of/';
heatmap_root = 'results/of2app_unet/images/heatmap_sub/';

%% distance methods:
% diff_of = uotput_of - target_of
% diff_mag = uotput_mag - target_mag
% diff_magof = uotput_of(:,:,3) - target_of(:,:,3)
% diff_mag_vs_magof = uotput_of(:,:,3) - target_mag
% dif_sum_rgb = sum(out_of2app,3) - sum(taget_of2app,3)
% dif_rgb_ofsub
method= 'dif_rgb_ofsub'; % diff_of, diff_mag, diff_magof, diff_mag_vs_magof

%% generate heat maps
visulize_heat = 30;
sample_names= dir([target_root '*.jpg']);
heatmap = generate_heatmap_of(target_root, output_root, heatmap_root, method, visulize_heat,of_root);