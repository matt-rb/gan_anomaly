clc;
clear all;
close all;
actions = {'Basketball', 'BasketballDunk', 'Biking', 'CliffDiving', 'CricketBowling', 'Diving', 'Fencing',...
    'FloorGymnastics', 'GolfSwing', 'HorseRiding', 'IceDancing', 'LongJump', 'PoleVault', 'RopeClimbing', 'SalsaSpin', ...
    'SkateBoarding', 'Skiing', 'Skijet', 'SoccerJuggling', 'Surfing', 'TennisSwing', 'TrampolineJumping', 'VolleyballSpiking', 'WalkingWithDog'};
images_path = '/mnt/sun-alpha/datasets/UCF101/images';
save_path = '/mnt/sun-alpha/ss-workspace/UCF101_data/cvof';
images_path = '/data/shared/solar-machines/datasets/UCF101/images';
save_path = '/data/shared/solar-machines/outputs/cvof';
codebase_path = '../external/cvof';
%%--- call config_demo to set ALLPATH ---
addpath(genpath(codebase_path));
addpath(codebase_path);
num_actions = length(actions);
for i = 1:1:3; %1:num_actions
    action = cell2mat(actions(i));
    image_folder = sprintf('%s/%s',images_path, action);
    % fprintf('%s\n', image_folder);
    video_list = dir(image_folder);
    num_videos = size(video_list,1);
    for j=3:num_videos
        video_name = video_list(j).name;
        imagefolder = [image_folder '/' video_name];
        savepath = [save_path '/' action '/' video_name];
        
        if ~exist(savepath, 'dir')
            mkdir(savepath);
        end
        fprintf('imagefolder = %s\n', imagefolder);
        fprintf('savepath = %s\n', savepath);
        computeCVOF(imagefolder, savepath);
    end
end




