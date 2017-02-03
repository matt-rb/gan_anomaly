%------------------------------------------------------------------------
% Author: Gurkirt Singh
% The following script checks for an flow image which has very small optical
% flow fields and replaces that with near by flow image.
%------------------------------------------------------------------------
function processMotionLessFrames()
clc
clear
basedir = '/mnt/sun-gamma/ss-workspace/JHMDB21_data/';
cvofdir = [basedir,'cvof/'];
newCvofdir = [basedir,'cvof-modified/'];
actionlist = dir(cvofdir);
for actionNum = 3:length(actionlist)
    actiondir = [cvofdir,actionlist(actionNum).name,'/'];
    newactiondir = [newCvofdir,actionlist(actionNum).name,'/'];
    videolist = dir(actiondir);
    for vidNum = 3:length(videolist)
        
        imgdir = [actiondir,videolist(vidNum).name,'/'];
        newimgdir = [newactiondir,videolist(vidNum).name,'/'];
        fprintf('processing action %d  video %d\n',actionNum-2,vidNum-2);
        
        if ~exist(newimgdir,'dir')
            mkdir(newimgdir)
        end
        processOneVideo(imgdir,newimgdir)
        
    end
end

end

function processOneVideo(imgdir,newimgdir)

imagelist = dir([imgdir,'*.png']);
numFrames = length(imagelist);
vars = zeros(numFrames,1);
for imgNum = 1: length(imagelist)
    image = imread([imgdir,imagelist(imgNum).name]);
    vars(imgNum) = var(double(image(:)));
end

notkeepimg = vars<=5;
chnageimageinds = zeros(numFrames,1);
for imgNum = 1: length(imagelist)
    if notkeepimg(imgNum)
        meanvar = (sum(vars(max(1,imgNum-2):min(imgNum+2,numFrames)))-vars(imgNum))/4;
        if meanvar-vars(imgNum)>=5
            chnageimageinds(imgNum) = 1;
        end
    end
end

copyImgFrm = zeros(numFrames,1);
for imgNum = 1: length(imagelist)
    if chnageimageinds(imgNum)
        choosefrome = max(1,imgNum-2):min(imgNum+2,numFrames);
        choosefrome(choosefrome==imgNum) = [];
        choosefrome(chnageimageinds(choosefrome)==1) = [];
        
        if ~isempty(choosefrome)
            [~, ind] = min(abs(choosefrome-imgNum));
            copyImgFrm(imgNum) = choosefrome(ind);
        end
    end
end

for imgNum = 1: length(imagelist)
    if copyImgFrm(imgNum)>0
        sourcefile = [imgdir,imagelist(copyImgFrm(imgNum)).name];
        destfile = [newimgdir,imagelist(imgNum).name];
        copyfile(sourcefile,destfile)
    else
        sourcefile = [imgdir,imagelist(imgNum).name];
        destfile = [newimgdir,imagelist(imgNum).name];
        copyfile(sourcefile,destfile);
    end
end
end
