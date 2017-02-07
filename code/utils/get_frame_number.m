function frm_no_t = get_frame_number( video_no, frm_no, ds_info )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
frm_no_t= sum(ds_info(1:video_no-1))+frm_no;
end

