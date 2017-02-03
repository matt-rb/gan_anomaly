function result = SegmentResultMatrix_frame_level(seg_all,TestVideoFile_new,options)
dispstat('','init');
for numtext=1:size(seg_all,1)
    for iM=1 : length(find(~cellfun(@isempty,seg_all(numtext,:))))
        for jj=1:options.itrnum
            dispstat(['processing video : ' num2str(numtext)])
            Abnormal_part= seg_all{numtext,iM}>=1-(jj/options.itrnum);
            result{jj}{numtext,iM}(1) = sum(Abnormal_part(:));
            result{jj}{numtext,iM}(2) = TestVideoFile_new{numtext}.gt_frame(iM);
        end
    end
end