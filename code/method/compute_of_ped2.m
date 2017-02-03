clear all
clc
dispstat('','init');
addpath(genpath('compute_optical_flow_images'));
% compute OF on UCSD
dirbase = '/home/moin/GitHub/AbnormalityGAN/data/UCSD/frm/UCSDped2/Test/';
dirout = '/home/moin/GitHub/AbnormalityGAN/data/UCSD/OF/Test/';
listing = dir(dirbase);
dirFolder = listing([listing.isdir]);
dirFolder= dirFolder(arrayfun(@(x) x.name(1),dirFolder) ~= '.');

for i = 1:length(dirFolder)
    %dispstat(sprintf('Compute OF for video %02d / %02d', i,length(dirFolder)));
    mkdir([dirout,dirFolder(i).name]);
    computeCVOF([dirbase,dirFolder(i).name], [dirout,dirFolder(i).name])
end