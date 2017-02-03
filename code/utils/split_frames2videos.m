function per_video = split_frames2videos( all_frames, ds_info , options)
%split all video frames into a cell matrix per video
%   all_frames : Cell matrix include all video feat frames
%   ds_info : matrix states each video sample has how many frames

dispstat('','init');
video_count = length(ds_info);
per_video = cell (video_count,max(ds_info));
sample_no=1;
for vid_no=1:video_count
    for frm_no=1:ds_info(vid_no)
        dispstat(sprintf('video %02d/%02d frame %03d/%03d',vid_no,video_count,frm_no,ds_info(vid_no)));
        if ~isfield(options, 'resize_to')
            per_video{vid_no,frm_no} = double(all_frames{sample_no});
        else
            per_video{vid_no,frm_no} = double(imresize(all_frames{sample_no},options.resize_to));
        end
        sample_no = sample_no+1;
    end
end

end

