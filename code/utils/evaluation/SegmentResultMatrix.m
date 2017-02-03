function result = SegmentResultMatrix(seg_all,TestVideoFile_new,ImgGrandtruth,options)
dispstat('','init');
for numtext=1:size(seg_all,1)
    for iM=1 : length(find(~cellfun(@isempty,seg_all(numtext,:))))
        for jj=1:options.itrnum
            dispstat(['processing video : ' num2str(numtext)])
            Abnormal_part{jj}= seg_all{numtext,iM}>=1-(jj/options.itrnum);% inja ((jj-1)/options.itrnum) adad beyne [0-1]threshold mizare vasat
            overlap{jj}=Abnormal_part{jj}.*ImgGrandtruth{numtext,iM+options.ClipOfFrame};
            %             overlap{num1,iM}= sum(NewMatrix{num1,iM}(:));
            if(TestVideoFile_new{numtext}.gt_frame(iM)==0)
                % how many abnormal in case of normal frame
                result{jj}{numtext,iM}(1) = sum(Abnormal_part{jj}(:));
                result{jj}{numtext,iM}(2) = TestVideoFile_new{numtext}.gt_frame(iM);
            else
                % how many percent overlap in case of abnormal frame
                result{jj}{numtext,iM}(1) = sum(overlap{jj}(:))/((sum(ImgGrandtruth{numtext,iM}(:)))+eps);
                result{jj}{numtext,iM}(2) = TestVideoFile_new{numtext}.gt_frame(iM);
            end
        end
    end
end