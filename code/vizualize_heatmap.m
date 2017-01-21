%% initialize target/output/heatmap folders
target_root = '../data/gan_out/target_of/';
output_root = '../data/gan_out/output_mag/';
heatmap_root = '../data/gan_out/heatmap_magof_vs_mag/';

%% distance methods:
% diff_of = uotput_of - target_of
% diff_mag = uotput_mag - target_mag
% diff_magof = uotput_of(:,:,3) - target_of(:,:,3)
% diff_mag_vs_magof = uotput_of(:,:,3) - target_mag
method= 'diff_mag_vs_magof'; % diff_of, diff_mag, diff_magof, diff_mag_vs_magof

%% generate heat maps
visulize_heat = 100;
sample_names= dir([target_root '*.jpg']);
generate_heatmap(target_root, output_root, heatmap_root, method, visulize_heat);