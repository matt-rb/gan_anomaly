load('/home/mahdyar/Documents/MATLAB/gan_anomaly/code/results/ped2/roc/1_roc_of');
%RoC_of = roc_pixel;
RoC_of = roc_frm;
load('/home/mahdyar/Documents/MATLAB/gan_anomaly/code/results/ped2/roc/2_roc_app');
%RoC_app = roc_pixel;
RoC_app = roc_frm;
load('/home/mahdyar/Documents/MATLAB/gan_anomaly/code/results/ped2/roc/3_roc_fuse2x1');
%RoC_fusion = roc_pixel;
RoC_fusion = roc_frm;

%% overall
disp('Plot ROC');
plot(RoC_of(:,2),RoC_of(:,1),'-o','LineWidth',2)
hold on
plot(RoC_app(:,2),RoC_app(:,1),'-o','LineWidth',2)
hold on
plot(RoC_fusion(:,2),RoC_fusion(:,1),'-o','LineWidth',2)
%plot(RoC_wof_clusters{i}(:,2),RoC_wof_clusters{i}(:,1),'-*')
%plot(RoC_wham{i}(:,2),RoC_wham{i}(:,1),'-*')
%plot(RoC_x{i}(:,2),RoC_x{i}(:,1),'-*')
plot([0 1] ,[1 0],'red')
grid on
xlabel('FPR'); ylabel('TPR')
%title('ROC frame-level Ped 1')
legend('Optical-flow Channel','Appearance Channel','Fusion','Location','southeast')
file_name='/home/mahdyar/Documents/MATLAB/gan_anomaly/code/results/final_paper/ped2_gan_channels_frame.png';
print(file_name,'-dpng');
[x,y] = ginput(1)
ERR = x


