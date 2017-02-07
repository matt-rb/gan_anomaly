function save_heatmaps(heatmaps_per_video, save_folder, folders_name)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
dispstat('','init');
for numtext=1:size(heatmaps_per_video,1)
    video_name = sprintf('%s%03d',folders_name,numtext);
    save_video_folder = fullfile(save_folder, video_name);
    if ~exist(save_video_folder,'dir')
        mkdir(save_video_folder);
    end 
    total_frms = length(find(~cellfun(@isempty,heatmaps_per_video(numtext,:))));
    for iM=1 : total_frms
        dispstat(sprintf('saving heatmap %03d/%03d frame %03d/%03d',numtext,size(heatmaps_per_video,1),iM,total_frms));
        heatmap = heatmaps_per_video{numtext,iM};
        frm_name = sprintf('%03d',iM);
        save (fullfile(save_video_folder,frm_name),'heatmap');
    end
end
end

