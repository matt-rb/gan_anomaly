load('/home/mahdyar/Documents/MATLAB/gan_anomaly/code/variables/roc/ped2/frame/RoC_coapp_Ped2_overall'); roc_coap = Roc1;
load('/home/mahdyar/Documents/MATLAB/gan_anomaly/code/variables/roc/ped2/frame/RoC_mdt'); roc_mdt = Roc1;
load('/home/mahdyar/Documents/MATLAB/gan_anomaly/code/variables/roc/ped2/frame/RoC_mppca'); roc_mppca = Roc1;
load('/home/mahdyar/Documents/MATLAB/gan_anomaly/code/variables/roc/ped2/frame/RoC_social_force'); roc_social = Roc1;
load('/home/mahdyar/Documents/MATLAB/gan_anomaly/code/variables/roc/ped2/frame/RoC_social_force_MPPCA'); roc_social_mppca = Roc1;

close all
disp('Plot ROC');
plot(roc_coap(:,2),roc_coap(:,1),'-*','LineWidth',2,'markers',9)
hold on
plot(roc_mdt(:,2),roc_mdt(:,1),'-o','LineWidth',2,'markers',9)
plot(roc_social(:,2),roc_social(:,1),'-s','LineWidth',2,'markers',9)
plot(roc_social_mppca(:,2),roc_social_mppca(:,1),'-d','LineWidth',2,'markers',9)
plot(roc_mppca(:,2),roc_mppca(:,1),'-x','LineWidth',2,'markers',9)
plot([0 1] ,[1 0],':k')
grid on
xlabel('False Positive Rate (FPR)'); ylabel('True Positive Rate (TPR)')
%title(['ROC for classification / video : ' num2str(i)])
legend('Proposed Method', 'MDT', 'Social Force', 'Social Force+MPPCA', 'MPPCA', 'Location','southeast')
file_name='evaluation_set/roc/final_eval_ped2_frame/ped2_frame_level.png';
print(file_name,'-dpng');
auc = trapz(roc_coap(:,2),roc_coap(:,1))
[x,y] = ginput(1)
ERR = x
%close all
%w = waitforbuttonpress;