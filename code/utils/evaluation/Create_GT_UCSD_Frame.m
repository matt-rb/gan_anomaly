function [ImgGrandtruth,TestVideoFile_new] = Create_GT_UCSD_Frame(gt_folder,TestVideoFile)
%filedir = fullfile(options.input,'opticalflow1',options.nameofdataset,'abnormal_anotate');% adress GT
dispstat('','init');
filedir = fullfile(gt_folder);% adress GT
dirlist = dir(fullfile(filedir,'*gt'));%%%'test***'
num_files = length(dirlist);
for numtext=1:num_files
    dispstat(['indexing video '  num2str(numtext) '/' num2str(num_files)]);
    filenames = cell(num_files, 1);
    filenames{numtext} = dirlist(numtext).name;
    filename= filenames{numtext};
    dirlist_img = dir(fullfile(filedir,filename,'*.bmp'));
    num_files_img = length(dirlist_img);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for iM=1:num_files_img
        %%%%%%%%%%%%%%%%%%%%%
        filenames_img = cell(num_files_img, 1);
        filenames_img {iM} = dirlist_img (iM).name;
        filename_img= filenames_img {iM};
        img = imread(fullfile(filedir,filename,filename_img));
        img(img~=0)=1;
        
        %------------------------------------------------
        ImgGrandtruth{numtext,iM}=double(img);
    end
end

%--------------------
for numtext=1:num_files
    TestVideoFile_new{1,numtext}.gt_frame(1,1:num_files_img)=0; 
    [m,n]=size(TestVideoFile{1,numtext}.gt_frame(:,:));
    for iM=1:n
        dispstat(['processing video ' num2str(numtext) '/' num2str(num_files)...
            'frame '  num2str(iM) '/' num2str(n) ]);
        A=TestVideoFile{1,numtext}.gt_frame(1,iM);
        TestVideoFile_new{1,numtext}.gt_frame(1,A)=1;
    end
end


