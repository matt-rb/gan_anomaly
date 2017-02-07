function heatmaps_per_video = load_heatmaps( folder_root, folders_name )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

dispstat('','init');
video_folders= dir(folder_root);
video_folders = video_folders([video_folders.isdir]);
video_folders= video_folders(arrayfun(@(x) x.name(1),video_folders) ~= '.');
heatmaps_per_video = cell(size(video_folders,1),1);
for numtext=1:size(video_folders,1)
    video_name = sprintf('%s%03d',folders_name,numtext);
    load_video_folder = fullfile(folder_root, video_name);
    total_frms = length(dir(fullfile(load_video_folder,'*.mat')));
    for iM=1 : total_frms
        dispstat(sprintf('saving heatmap %03d/%03d frame %03d/%03d',numtext,size(heatmaps_per_video,1),iM,total_frms));
        frm_name = sprintf('%03d.mat',iM);
        load (fullfile(load_video_folder,frm_name),'heatmap');
        heatmaps_per_video{numtext,iM} = heatmap;
    end
end

end

