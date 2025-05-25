clear all
clc

load("ML_PID_Combined.mat");


set(groot,'defaultAxesTickLabelInterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');
set(groot,'defaulttextInterpreter','latex');

figure(100)
subplot(2,2,1)
plot(time1_ML,d1_ML,'-b','linewidth',2)
hold on
plot(time_ML,image_mean_ML(1:end)','-r','linewidth',2)
hold off
title('System Output');
legend('Reference','ML(New)','Location','northeast')
xlabel('Time (min)')
ylabel('RI Value (\%)')
xlim([0 115])
ylim([-105 105])
yticklabels(strrep(yticklabels,'-','$-$'))
grid on

subplot(2,2,2)
plot(time_ML,u_app_ML(1:end).*(10^3),'-m','linewidth',2)
hold on
yline(-0.95,'--k','Min','LabelHorizontalAlignment','left','LabelVerticalAlignment','bottom')
yline(0.95,'--k','Max','LabelHorizontalAlignment','right','LabelVerticalAlignment','top')
ylim([-1.5 1.5])
hold off
title('Control Output (Saturated/Applied)')
xlabel('Time (min)')
ylabel('Current (mA)')
xlim([0 115])
yticklabels(strrep(yticklabels,'-','$-$'))
grid on

subplot(2,2,3)
plot(time_ML,(image_mean_ML(1:end)-d1_ML(1:end-1))./d1_ML(1:end-1),'-c','linewidth',2)
title('Relative Tracking Error');
xlabel('Time (min)')
ylabel('Relative Tracking Error');
xlim([0 115])
ylim([-2.5 1])
yticklabels(strrep(yticklabels,'-','$-$'))
grid on

subplot(2,2,4)
plot(time_ML,up_ML(1:end),'-m','linewidth',2)
title('Control Output (Unsaturated)')
xlabel('Time (min)')
ylabel('Current (A)')
xlim([0 115])
ylim([-0.15 0.15])
yticklabels(strrep(yticklabels,'-','$-$'))
grid on



figure(1001)
subplot(2,2,1)
plot(time1_PID,d1_PID,'-b','linewidth',2)
hold on
plot(time_PID,image_mean_PID(1:end)','-r','linewidth',2)
hold off
title('System Output');
legend('Reference','PID','Location','northeast')
xlabel('Time (min)')
ylabel('RI Value (\%)')
xlim([0 90])
ylim([-105 105])
yticklabels(strrep(yticklabels,'-','$-$'))
grid on

subplot(2,2,2)
plot(time_PID,u_sat(1:end).*(10^3),'-m','linewidth',2)
hold on
yline(-0.7,'--k','Min','LabelHorizontalAlignment','left','LabelVerticalAlignment','bottom')
yline(0.7,'--k','Max','LabelHorizontalAlignment','right','LabelVerticalAlignment','top')
ylim([-1.5 1.5])
hold off
title('Control Output (Saturated/Applied)')
xlabel('Time (min)')
ylabel('Current (mA)')
xlim([0 90])
yticklabels(strrep(yticklabels,'-','$-$'))
grid on

subplot(2,2,3)
plot(time_PID,(image_mean_PID(1:end)-d1_PID(1:end-1))./d1_PID(1:end-1),'-c','linewidth',2)
title('Relative Tracking Error');
xlabel('Time (min)')
ylabel('Relative Tracking Error');
xlim([0 90])
ylim([-2.5 1])
yticklabels(strrep(yticklabels,'-','$-$'))
grid on

subplot(2,2,4)
plot(time_PID,pid_out(1:end),'-m','linewidth',2)
title('Control Output (Unsaturated)')
xlabel('Time (min)')
ylabel('Current (A)')
xlim([0 90])
ylim([-0.8 0.3])
yticklabels(strrep(yticklabels,'-','$-$'))
grid on




RMSE_ML = rmse(image_mean_ML(1,:)/60,d1_ML(1:end-1)/60)
RMSE_PID = rmse(image_mean_PID(1,:)/60,d1_PID(1:end-1)/60)
RMSE_Improved = ((RMSE_PID-RMSE_ML)/RMSE_PID)*100

MSE_ML = immse(image_mean_ML(1,:)/60,d1_ML(1:end-1)/60)
MSE_PID = immse(image_mean_PID(1,:)/60,d1_PID(1:end-1)/60)
MSE_Improved = ((MSE_PID-MSE_ML)/MSE_PID)*100

MAPE_ML = mape(image_mean_ML(1,:)/60,d1_ML(1:end-1)/60)
MAPE_PID = mape(image_mean_PID(1,:)/60,d1_PID(1:end-1)/60)
MAPE_Improved = ((MAPE_PID-MAPE_ML)/MAPE_PID)*100


STEP_ML = stepinfo(image_mean_ML(1,14:end),65:5:115,-60,60)
STEP_PID = stepinfo(image_mean_PID(1,5:end),20:5:90,-60,60)

STEP_Improved = ((STEP_PID.RiseTime-STEP_ML.RiseTime)/STEP_PID.RiseTime)*100
STEP_Improved_min = (STEP_PID.RiseTime-STEP_ML.RiseTime)