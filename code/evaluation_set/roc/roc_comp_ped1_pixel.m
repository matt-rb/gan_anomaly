load('/home/mahdyar/Documents/MATLAB/gan_anomaly/code/results/ped1/roc/3_roc_fuse2x1'); RoC_fusion = roc_pixel;
load('/home/mahdyar/Documents/MATLAB/gan_anomaly/code/variables/roc/ped1/pixel/RoC_coapp_Ped1_overall'); roc_coap = Roc1;
load('/home/mahdyar/Documents/MATLAB/gan_anomaly/code/variables/roc/ped1/pixel/RoC_detection_at150'); roc_detection150 = Roc1;
load('/home/mahdyar/Documents/MATLAB/gan_anomaly/code/variables/roc/ped1/pixel/RoC_mdt'); roc_mdt = Roc1;
%load('/home/mahdyar/Documents/MATLAB/gan_anomaly/code/variables/roc/ped1/pixel/RoC_mppca'); roc_mppca = Roc1;
load('/home/mahdyar/Documents/MATLAB/gan_anomaly/code/variables/roc/ped1/pixel/RoC_nicu_AMDN'); roc_amdn = Roc1;
load('/home/mahdyar/Documents/MATLAB/gan_anomaly/code/variables/roc/ped1/pixel/RoC_social_force'); roc_social = Roc1;
%load('/home/mahdyar/Documents/MATLAB/gan_anomaly/code/variables/roc/ped1/pixel/RoC_social_force_MPPCA'); roc_social_mppca = Roc1;
load('/home/mahdyar/Documents/MATLAB/gan_anomaly/code/variables/roc/ped1/pixel/RoC_sparce_reconstruction'); roc_sparce = Roc1;

close all
disp('Plot ROC');
hFig = figure(1);
set(hFig, 'Position', [0 0 600 500])
plot(RoC_fusion(:,2),RoC_fusion(:,1),'-o','LineWidth',2,'markers',9)
hold on
plot(roc_coap(:,2),roc_coap(:,1),'-*','LineWidth',2,'markers',9)
plot(roc_detection150(:,2),roc_detection150(:,1),'-+','LineWidth',2,'markers',9)
plot(roc_mdt(:,2),roc_mdt(:,1),'-x','LineWidth',2,'markers',9)
plot(roc_social(:,2),roc_social(:,1),'-s','LineWidth',2,'markers',9)
%plot(roc_social_mppca(:,2),roc_social_mppca(:,1),'-d','LineWidth',2,'markers',9)
plot(roc_amdn(:,2),roc_amdn(:,1),'-<','LineWidth',2,'markers',9)
plot(roc_sparce(:,2),roc_sparce(:,1),'-p','LineWidth',2,'markers',9)
%plot(roc_mppca(:,2),roc_mppca(:,1),'-x','LineWidth',2,'markers',9)
plot([0 1] ,[1 0],':k')
grid on
xlabel('False Positive Rate (FPR)'); ylabel('True Positive Rate (TPR)')
%title(['ROC for classification / video : ' num2str(i)])
%legend('Proposed Method','TCP','Detection at 150FPS', 'MDT', 'Social Force', 'Social Force+MPPCA', 'AMDN','Sparse Reconstruction', 'MPPCA', 'Location','northwest')
legend('Proposed Method','TCP','Detection at 150FPS', 'MDT', 'Social Force', 'AMDN','Sparse Reconstruction', 'Location','northwest')
file_name='/home/mahdyar/Documents/MATLAB/gan_anomaly/code/results/final_paper/ped1_pixel_level.png';
print(file_name,'-dpng');
auc = trapz(roc_coap(:,2),roc_coap(:,1))
[x,y] = ginput(1);
ERR = x
%close all
%w = waitforbuttonpress;



