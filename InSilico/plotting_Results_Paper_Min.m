clc
clear all
close all

%%
load("New_Normal.mat");


set(groot,'defaultAxesTickLabelInterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');
set(groot,'defaulttextInterpreter','latex');


y_lim_error = [-2.1 0.3];
y_lim_ref = [-1.2 1.2];
y_lim_CTRL = [-7.5 7.5];

y_lim_CTRL11 = [3.999 4.03];
y_lim_CTRL12 = [3.999 4.004];
x_lim_closeup = [13 37];

figure(100)
subplot(2,3,1)
plot(ref_new_Normal(1,1:60:end),'-b','linewidth',2)
hold on
plot(log_d_new_Normal(1,1:60:end),'-r','linewidth',2)
hold off
title('System Output');
legend('Reference','ML(New)','Location','northeast')
xlabel('Time (min)')
ylabel('Directedness Value')
xlim([0 69])
ylim(y_lim_ref)
yticklabels(strrep(yticklabels,'-','$-$'))
grid on

subplot(2,3,2)
plot(up_new_Normal(1,1:60:end),'-m','linewidth',2)
hold on
yline(-4,'--k','Min','LabelHorizontalAlignment','left','LabelVerticalAlignment','bottom')
yline(4,'--k','Max','LabelHorizontalAlignment','right','LabelVerticalAlignment','top')
hold off
title('Control Output')
xlabel('Time (min)')
ylabel('Electric Field (V/cm)')
xlim([0 69])
ylim(y_lim_CTRL)
yticklabels(strrep(yticklabels,'-','$-$'))
grid on

subplot(2,3,3)
plot((log_d_new_Normal(1,1:60:end)-ref_new_Normal(1,1:60:end))./ref_new_Normal(1,1:60:end),'-c','linewidth',2)
title('Relative Tracking Error');
xlabel('Time (min)')
ylabel('Relative Tracking Error');
xlim([0 69])
ylim(y_lim_error)
yticklabels(strrep(yticklabels,'-','$-$'))
grid on

subplot(2,3,4)
plot(ref_new_Normal(1,1:60:end),'-b','linewidth',2)
hold on
plot(log_d_OG_Normal(1,1:60:end),'-r','linewidth',2)
hold off
title('System Output');
legend('Reference','ML(Old)','Location','northeast')
xlabel('Time (min)')
ylabel('Directedness Value')
xlim([0 69])
ylim(y_lim_ref)
yticklabels(strrep(yticklabels,'-','$-$'))
grid on

subplot(2,3,5)
plot(up_OG_Normal(1,1:60:end),'-m','linewidth',2)
hold on
yline(-4,'--k','Min','LabelHorizontalAlignment','left','LabelVerticalAlignment','bottom')
yline(4,'--k','Max','LabelHorizontalAlignment','right','LabelVerticalAlignment','top')
hold off
title('Control Output')
xlabel('Time (min)')
ylabel('Electric Field (V/cm)')
xlim([0 69])
ylim(y_lim_CTRL)
yticklabels(strrep(yticklabels,'-','$-$'))
grid on

subplot(2,3,6)
plot((log_d_OG_Normal(1,1:60:end)-ref_new_Normal(1,1:60:end))./ref_new_Normal(1,1:60:end),'-c','linewidth',2)
title('Relative Tracking Error');
xlabel('Time (min)')
ylabel('Relative Tracking Error');
xlim([0 69])
ylim(y_lim_error)
yticklabels(strrep(yticklabels,'-','$-$'))
grid on

RMSE_new_Normal = rmse(log_d_new_Normal(1,:),ref_new_Normal)
RMSE_OG_Normal = rmse(log_d_OG_Normal(1,:),ref_new_Normal)
RMSE_Improve_Normal = ((RMSE_OG_Normal-RMSE_new_Normal)/RMSE_OG_Normal)*100

MSE_new_Normal = immse(log_d_new_Normal(1,:),ref_new_Normal)
MSE_OG_Normal = immse(log_d_OG_Normal(1,:),ref_new_Normal)
MSE_Improve_Normal = ((MSE_OG_Normal-MSE_new_Normal)/MSE_OG_Normal)*100

MAPE_new_Normal = mape(log_d_new_Normal(1,:),ref_new_Normal)
MAPE_OG_Normal = mape(log_d_OG_Normal(1,:),ref_new_Normal)
MAPE_Improve_Normal = ((MAPE_OG_Normal-MAPE_new_Normal)/MAPE_OG_Normal)*100


STEP_new_Normal = stepinfo(log_d_new_Normal(1,2051:end),1:2051,-0.65,0.65)
STEP_OG_Normal = stepinfo(log_d_OG_Normal(1,2051:end),1:2051,-0.65,0.65)

STEP_Improve_Normal = ((STEP_OG_Normal.RiseTime-STEP_new_Normal.RiseTime)/STEP_OG_Normal.RiseTime)*100
STEP_Improve_Normal_Sec = (STEP_OG_Normal.RiseTime-STEP_new_Normal.RiseTime)/60
STEP_OG_Normal.RiseTime/60
STEP_new_Normal.RiseTime/60


%%
load("Normal_PIDSMC.mat");

figure(9100)
subplot(2,3,1)
plot(ref_SMC_Normal(1,1:60:end),'-b','linewidth',2)
hold on
plot(log_d_SMC_Normal(1,1:60:end),'-r','linewidth',2)
hold off
title('System Output');
legend('Reference','SMC','Location','northeast')
xlabel('Time (min)')
ylabel('Directedness Value')
xlim([0 69])
ylim(y_lim_ref)
yticklabels(strrep(yticklabels,'-','$-$'))
grid on

subplot(2,3,2)
plot(up_SMC_Normal(1,1:60:end),'-m','linewidth',2)
hold on
yline(-4,'--k','Min','LabelHorizontalAlignment','left','LabelVerticalAlignment','bottom')
yline(4,'--k','Max','LabelHorizontalAlignment','right','LabelVerticalAlignment','top')
hold off
title('Control Output')
xlabel('Time (min)')
ylabel('Electric Field (V/cm)')
xlim([0 69])
ylim(y_lim_CTRL)
yticklabels(strrep(yticklabels,'-','$-$'))
grid on

subplot(2,3,3)
plot((log_d_SMC_Normal(1,1:60:end)-ref_SMC_Normal(1,1:60:end))./ref_SMC_Normal(1,1:60:end),'-c','linewidth',2)
title('Relative Tracking Error');
xlabel('Time (min)')
ylabel('Relative Tracking Error');
xlim([0 69])
ylim(y_lim_error)
yticklabels(strrep(yticklabels,'-','$-$'))
grid on

subplot(2,3,4)
plot(ref_PID_Normal(1,1:60:end),'-b','linewidth',2)
hold on
plot(log_d_PID_Normal(1,1:60:end),'-r','linewidth',2)
hold off
title('System Output');
legend('Reference','PID','Location','northeast')
xlabel('Time (min)')
ylabel('Directedness Value')
xlim([0 69])
ylim(y_lim_ref)
yticklabels(strrep(yticklabels,'-','$-$'))
grid on

subplot(2,3,5)
plot(up_PID_Normal(1,1:60:end),'-m','linewidth',2)
hold on
yline(-4,'--k','Min','LabelHorizontalAlignment','left','LabelVerticalAlignment','bottom')
yline(4,'--k','Max','LabelHorizontalAlignment','right','LabelVerticalAlignment','top')
hold off
title('Control Output')
xlabel('Time (min)')
ylabel('Electric Field (V/cm)')
xlim([0 69])
ylim(y_lim_CTRL)
yticklabels(strrep(yticklabels,'-','$-$'))
grid on

subplot(2,3,6)
plot((log_d_PID_Normal(1,1:60:end)-ref_PID_Normal(1,1:60:end))./ref_PID_Normal(1,1:60:end),'-c','linewidth',2)
title('Relative Tracking Error');
xlabel('Time (min)')
ylabel('Relative Tracking Error');
xlim([0 69])
ylim(y_lim_error)
yticklabels(strrep(yticklabels,'-','$-$'))
grid on

RMSE_SMC_Normal = rmse(log_d_SMC_Normal(1,:),ref_SMC_Normal)
RMSE_PID_Normal = rmse(log_d_PID_Normal(1,:),ref_PID_Normal)
RMSE_Improve_Normal_SMC = ((RMSE_SMC_Normal-RMSE_new_Normal)/RMSE_SMC_Normal)*100
RMSE_Improve_Normal_PID = ((RMSE_PID_Normal-RMSE_new_Normal)/RMSE_PID_Normal)*100

MSE_SMC_Normal = immse(log_d_SMC_Normal(1,:),ref_SMC_Normal)
MSE_PID_Normal = immse(log_d_PID_Normal(1,:),ref_PID_Normal)
MSE_Improve_Normal_SMC = ((MSE_SMC_Normal-MSE_new_Normal)/MSE_SMC_Normal)*100
MSE_Improve_Normal_PID = ((MSE_PID_Normal-MSE_new_Normal)/MSE_PID_Normal)*100

MAPE_SMC_Normal = mape(log_d_SMC_Normal(1,:),ref_SMC_Normal)
MAPE_PID_Normal = mape(log_d_PID_Normal(1,:),ref_PID_Normal)
MAPE_Improve_Normal_SMC = ((MAPE_SMC_Normal-MAPE_new_Normal)/MAPE_SMC_Normal)*100
MAPE_Improve_Normal_PID = ((MAPE_PID_Normal-MAPE_new_Normal)/MAPE_PID_Normal)*100


STEP_new_Normal = stepinfo(log_d_new_Normal(1,2051:end),1:2051,-0.65,0.65)
STEP_SMC_Normal = stepinfo(log_d_SMC_Normal(1,2051:end),1:2051,-0.65,0.65)
STEP_PID_Normal = stepinfo(log_d_PID_Normal(1,2051:end),1:2051,-0.65,0.65)

STEP_Improve_Normal_SMC = ((STEP_SMC_Normal.RiseTime-STEP_new_Normal.RiseTime)/STEP_SMC_Normal.RiseTime)*100
STEP_Improve_Normal_SMC_Sec = (STEP_SMC_Normal.RiseTime-STEP_new_Normal.RiseTime)
STEP_Improve_Normal_PID = ((STEP_PID_Normal.RiseTime-STEP_new_Normal.RiseTime)/STEP_PID_Normal.RiseTime)*100
STEP_Improve_Normal_PID_Sec = (STEP_PID_Normal.RiseTime-STEP_new_Normal.RiseTime)

%%

load("New_SL.mat");
figure(1011)
plot(up_new_SL(1,1:60:end),'-m','linewidth',2)
hold on
yline([-4 4],'--k',{'Min','Max'})
hold off
title('Control Output | Zoomed-In')
xlabel('Time (min)')
ylabel('Electric Field (V/cm)')
xlim(x_lim_closeup)
ylim(y_lim_CTRL11)
yticklabels(strrep(yticklabels,'-','$-$'))
grid on

figure(101)
subplot(2,3,1)
plot(ref_new_SL(1,1:60:end),'-b','linewidth',2)
hold on
plot(log_d_new_SL(1,1:60:end),'-r','linewidth',2)
hold off
title('System Output');
legend('Reference','ML(NEW)','Location','northeast')
xlabel('Time (min)')
ylabel('Directedness Value')
xlim([0 69])
ylim(y_lim_ref)
yticklabels(strrep(yticklabels,'-','$-$'))
grid on

subplot(2,3,2)
plot(up_new_SL(1,1:60:end),'-m','linewidth',2)
hold on
yline(-4,'--k','Min','LabelHorizontalAlignment','left','LabelVerticalAlignment','bottom')
yline(4,'--k','Max','LabelHorizontalAlignment','right','LabelVerticalAlignment','top')
hold off
title('Control Output')
xlabel('Time (min)')
ylabel('Electric Field (V/cm)')
xlim([0 69])
ylim(y_lim_CTRL)
yticklabels(strrep(yticklabels,'-','$-$'))
grid on

subplot(2,3,3)
plot((log_d_new_SL(1,1:60:end)-ref_new_SL(1,1:60:end))./ref_new_SL(1,1:60:end),'-c','linewidth',2)
title('Relative Tracking Error');
xlabel('Time (min)')
ylabel('Relative Tracking Error');
xlim([0 69])
ylim(y_lim_error)
yticklabels(strrep(yticklabels,'-','$-$'))
grid on

subplot(2,3,4)
plot(ref_new_SL(1,1:60:end),'-b','linewidth',2)
hold on
plot(log_d_OG_SL(1,1:60:end),'-r','linewidth',2)
hold off
title('System Output');
legend('Reference','ML(Old)','Location','northeast')
xlabel('Time (min)')
ylabel('Directedness Value')
xlim([0 69])
ylim(y_lim_ref)
yticklabels(strrep(yticklabels,'-','$-$'))
grid on

subplot(2,3,5)
plot(up_OG_SL(1,1:60:end),'-m','linewidth',2)
hold on
yline(-4,'--k','Min','LabelHorizontalAlignment','left','LabelVerticalAlignment','bottom')
yline(4,'--k','Max','LabelHorizontalAlignment','right','LabelVerticalAlignment','top')
hold off
title('Control Output')
xlabel('Time (min)')
ylabel('Electric Field (V/cm)')
xlim([0 69])
ylim(y_lim_CTRL)
yticklabels(strrep(yticklabels,'-','$-$'))
grid on

subplot(2,3,6)
plot((log_d_OG_SL(1,1:60:end)-ref_new_SL(1,1:60:end))./ref_new_SL(1,1:60:end),'-c','linewidth',2)
title('Relative Tracking Error');
xlabel('Time (min)')
ylabel('Relative Tracking Error');
xlim([0 69])
ylim(y_lim_error)
yticklabels(strrep(yticklabels,'-','$-$'))
grid on



RMSE_new_SL = rmse(log_d_new_SL(1,:),ref_new_SL)
RMSE_OG_SL = rmse(log_d_OG_SL(1,:),ref_new_SL)
RMSE_Improve_SL = ((RMSE_OG_SL-RMSE_new_SL)/RMSE_OG_SL)*100

MSE_new_SL = immse(log_d_new_SL(1,:),ref_new_SL)
MSE_OG_SL = immse(log_d_OG_SL(1,:),ref_new_SL)
MSE_Improve_SL = ((MSE_OG_SL-MSE_new_SL)/MSE_OG_SL)*100


MAPE_new_SL = mape(log_d_new_SL(1,:),ref_new_SL)
MAPE_OG_SL = mape(log_d_OG_SL(1,:),ref_new_SL)
MAPE_Improve_SL = ((MAPE_OG_SL-MAPE_new_SL)/MAPE_OG_SL)*100


STEP_new_SL = stepinfo(log_d_new_SL(1,2051:end),1:2051,-0.9,0.9)
STEP_OG_SL = stepinfo(log_d_OG_SL(1,2051:end),1:2051,-0.9,0.9)

STEP_Improve_SL = ((STEP_OG_SL.RiseTime-STEP_new_SL.RiseTime)/STEP_OG_SL.RiseTime)*100
STEP_Improve_SL_Sec = (STEP_OG_SL.RiseTime-STEP_new_SL.RiseTime)/60
STEP_OG_SL.RiseTime/60
STEP_new_SL.RiseTime/60

%%

load("SL_PIDSMC.mat");

figure(9101)
subplot(2,3,1)
plot(ref_SMC_SL(1,1:60:end),'-b','linewidth',2)
hold on
plot(log_d_SMC_SL(1,1:60:end),'-r','linewidth',2)
hold off
title('System Output');
legend('Reference','SMC','Location','northeast')
xlabel('Time (min)')
ylabel('Directedness Value')
xlim([0 69])
ylim(y_lim_ref)
yticklabels(strrep(yticklabels,'-','$-$'))
grid on

subplot(2,3,2)
plot(up_SMC_SL(1,1:60:end),'-m','linewidth',2)
hold on
yline(-4,'--k','Min','LabelHorizontalAlignment','left','LabelVerticalAlignment','bottom')
yline(4,'--k','Max','LabelHorizontalAlignment','right','LabelVerticalAlignment','top')
hold off
title('Control Output')
xlabel('Time (min)')
ylabel('Electric Field (V/cm)')
xlim([0 69])
ylim(y_lim_CTRL)
yticklabels(strrep(yticklabels,'-','$-$'))
grid on

subplot(2,3,3)
plot((log_d_SMC_SL(1,1:60:end)-ref_SMC_SL(1,1:60:end))./ref_SMC_SL(1,1:60:end),'-c','linewidth',2)
title('Relative Tracking Error');
xlabel('Time (min)')
ylabel('Relative Tracking Error');
xlim([0 69])
ylim(y_lim_error)
yticklabels(strrep(yticklabels,'-','$-$'))
grid on

subplot(2,3,4)
plot(ref_PID_SL(1,1:60:end),'-b','linewidth',2)
hold on
plot(log_d_PID_SL(1,1:60:end),'-r','linewidth',2)
hold off
title('System Output');
legend('Reference','PID','Location','northeast')
xlabel('Time (min)')
ylabel('Directedness Value')
xlim([0 69])
ylim(y_lim_ref)
yticklabels(strrep(yticklabels,'-','$-$'))
grid on

subplot(2,3,5)
plot(up_PID_SL(1,1:60:end),'-m','linewidth',2)
hold on
yline(-4,'--k','Min','LabelHorizontalAlignment','left','LabelVerticalAlignment','bottom')
yline(4,'--k','Max','LabelHorizontalAlignment','right','LabelVerticalAlignment','top')
hold off
title('Control Output')
xlabel('Time (min)')
ylabel('Electric Field (V/cm)')
xlim([0 69])
ylim(y_lim_CTRL)
yticklabels(strrep(yticklabels,'-','$-$'))
grid on

subplot(2,3,6)
plot((log_d_PID_SL(1,1:60:end)-ref_PID_SL(1,1:60:end))./ref_PID_SL(1,1:60:end),'-c','linewidth',2)
title('Relative Tracking Error');
xlabel('Time (min)')
ylabel('Relative Tracking Error');
xlim([0 69])
ylim(y_lim_error)
yticklabels(strrep(yticklabels,'-','$-$'))
grid on



RMSE_SMC_SL = rmse(log_d_SMC_SL(1,:),ref_SMC_SL)
RMSE_PID_SL = rmse(log_d_PID_SL(1,:),ref_PID_SL)
RMSE_Improve_SL_SMC = ((RMSE_SMC_SL-RMSE_new_SL)/RMSE_SMC_SL)*100
RMSE_Improve_SL_PID = ((RMSE_PID_SL-RMSE_new_SL)/RMSE_PID_SL)*100

MSE_SMC_SL = immse(log_d_SMC_SL(1,:),ref_SMC_SL)
MSE_PID_SL = immse(log_d_PID_SL(1,:),ref_PID_SL)
MSE_Improve_SL_SMC = ((MSE_SMC_SL-MSE_new_SL)/MSE_SMC_SL)*100
MSE_Improve_SL_PID = ((MSE_PID_SL-MSE_new_SL)/MSE_PID_SL)*100

MAPE_SMC_SL = mape(log_d_SMC_SL(1,:),ref_SMC_SL)
MAPE_PID_SL = mape(log_d_PID_SL(1,:),ref_PID_SL)
MAPE_Improve_SL_SMC = ((MAPE_SMC_SL-MAPE_new_SL)/MAPE_SMC_SL)*100
MAPE_Improve_SL_PID = ((MAPE_PID_SL-MAPE_new_SL)/MAPE_PID_SL)*100

STEP_SMC_SL = stepinfo(log_d_SMC_SL(1,2051:end),1:2051,-0.9,0.9)
STEP_PID_SL = stepinfo(log_d_PID_SL(1,2051:end),1:2051,-0.9,0.9)

STEP_Improve_SL_SMC = ((STEP_SMC_SL.RiseTime-STEP_new_SL.RiseTime)/STEP_SMC_SL.RiseTime)*100
STEP_Improve_SL_SMC_Sec = (STEP_SMC_SL.RiseTime-STEP_new_SL.RiseTime)
STEP_Improve_SL_PID = ((STEP_PID_SL.RiseTime-STEP_new_SL.RiseTime)/STEP_PID_SL.RiseTime)*100
STEP_Improve_SL_PID_Sec = (STEP_PID_SL.RiseTime-STEP_new_SL.RiseTime)


%%

load("New_CH.mat");
figure(1021)
plot(up_new_CH(1,1:60:end),'-m','linewidth',2)
hold on
yline([-4 4],'--k',{'Min','Max'})
hold off
title('Control Output | Zoomed-In')
xlabel('Time (min)')
ylabel('Electric Field (V/cm)')
xlim(x_lim_closeup)
ylim(y_lim_CTRL12)
yticklabels(strrep(yticklabels,'-','$-$'))
grid on

figure(102)
subplot(2,3,1)
plot(ref_new_CH(1,1:60:end),'-b','linewidth',2)
hold on
plot(log_d_new_CH(1,1:60:end),'-r','linewidth',2)
hold off
title('System Output');
legend('Reference','ML(New)','Location','northeast')
xlabel('Time (min)')
ylabel('Directedness Value')
xlim([0 69])
ylim(y_lim_ref)
yticklabels(strrep(yticklabels,'-','$-$'))
grid on

subplot(2,3,2)
plot(up_new_CH(1,1:60:end),'-m','linewidth',2)
hold on
yline(-4,'--k','Min','LabelHorizontalAlignment','left','LabelVerticalAlignment','bottom')
yline(4,'--k','Max','LabelHorizontalAlignment','right','LabelVerticalAlignment','top')
hold off
title('Control Output')
xlabel('Time (min)')
ylabel('Electric Field (V/cm)')
xlim([0 69])
ylim(y_lim_CTRL)
yticklabels(strrep(yticklabels,'-','$-$'))
grid on

subplot(2,3,3)
plot((log_d_new_CH(1,1:60:end)-ref_new_CH(1,1:60:end))./ref_new_CH(1,1:60:end),'-c','linewidth',2)
title('Relative Tracking Error');
xlabel('Time (min)')
ylabel('Relative Tracking Error');
xlim([0 69])
ylim(y_lim_error)
yticklabels(strrep(yticklabels,'-','$-$'))
grid on

subplot(2,3,4)
plot(ref_new_CH(1,1:60:end),'-b','linewidth',2)
hold on
plot(log_d_OG_CH(1,1:60:end),'-r','linewidth',2)
hold off
title('System Output');
legend('Reference','ML(Old)','Location','northeast')
xlabel('Time (min)')
ylabel('Directedness Value')
xlim([0 69])
ylim(y_lim_ref)
yticklabels(strrep(yticklabels,'-','$-$'))
grid on

subplot(2,3,5)
plot(up_OG_CH(1,1:60:end),'-m','linewidth',2)
hold on
yline(-4,'--k','Min','LabelHorizontalAlignment','left','LabelVerticalAlignment','bottom')
yline(4,'--k','Max','LabelHorizontalAlignment','right','LabelVerticalAlignment','top')
hold off
title('Control Output')
xlabel('Time (min)')
ylabel('Electric Field (V/cm)')
xlim([0 69])
ylim(y_lim_CTRL)
yticklabels(strrep(yticklabels,'-','$-$'))
grid on

subplot(2,3,6)
plot((log_d_OG_CH(1,1:60:end)-ref_new_CH(1,1:60:end))./ref_new_CH(1,1:60:end),'-c','linewidth',2)
title('Relative Tracking Error');
xlabel('Time (min)')
ylabel('Relative Tracking Error');
xlim([0 69])
ylim(y_lim_error)
yticklabels(strrep(yticklabels,'-','$-$'))
grid on





RMSE_new_CH = rmse(log_d_new_CH(1,:),ref_new_CH)
RMSE_OG_CH = rmse(log_d_OG_CH(1,:),ref_new_CH)
RMSE_Improve_CH = ((RMSE_OG_CH-RMSE_new_CH)/RMSE_OG_CH)*100


MSE_new_CH = immse(log_d_new_CH(1,:),ref_new_CH)
MSE_OG_CH = immse(log_d_OG_CH(1,:),ref_new_CH)
MSE_Improve_CH = ((MSE_OG_CH-MSE_new_CH)/MSE_OG_CH)*100


MAPE_new_CH = mape(log_d_new_CH(1,:),ref_new_CH)
MAPE_OG_CH = mape(log_d_OG_CH(1,:),ref_new_CH)
MAPE_Improve_CH = ((MAPE_OG_CH-MAPE_new_CH)/MAPE_OG_CH)*100


STEP_new_CH = stepinfo(log_d_new_CH(1,2051:end),1:2051,-0.9,0.9)
STEP_OG_CH = stepinfo(log_d_OG_CH(1,2051:end),1:2051,-0.9,0.9)

STEP_Improve_CH = ((STEP_OG_CH.RiseTime-STEP_new_CH.RiseTime)/STEP_OG_CH.RiseTime)*100
STEP_Improve_CH_Sec = (STEP_OG_CH.RiseTime-STEP_new_CH.RiseTime)/60

STEP_OG_CH.RiseTime/60
STEP_new_CH.RiseTime/60

%%

load("CH_PIDSMC.mat");

figure(9102)
subplot(2,3,1)
plot(ref_SMC_CH(1,1:60:end),'-b','linewidth',2)
hold on
plot(log_d_SMC_CH(1,1:60:end),'-r','linewidth',2)
hold off
title('System Output');
legend('Reference','SMC','Location','northeast')
xlabel('Time (min)')
ylabel('Directedness Value')
xlim([0 69])
ylim(y_lim_ref)
yticklabels(strrep(yticklabels,'-','$-$'))
grid on

subplot(2,3,2)
plot(up_SMC_CH(1,1:60:end),'-m','linewidth',2)
hold on
yline(-4,'--k','Min','LabelHorizontalAlignment','left','LabelVerticalAlignment','bottom')
yline(4,'--k','Max','LabelHorizontalAlignment','right','LabelVerticalAlignment','top')
hold off
title('Control Output')
xlabel('Time (min)')
ylabel('Electric Field (V/cm)')
xlim([0 69])
ylim(y_lim_CTRL)
yticklabels(strrep(yticklabels,'-','$-$'))
grid on

subplot(2,3,3)
plot((log_d_SMC_CH(1,1:60:end)-ref_SMC_CH(1,1:60:end))./ref_SMC_CH(1,1:60:end),'-c','linewidth',2)
title('Relative Tracking Error');
xlabel('Time (min)')
ylabel('Relative Tracking Error');
xlim([0 69])
ylim(y_lim_error)
yticklabels(strrep(yticklabels,'-','$-$'))
grid on

subplot(2,3,4)
plot(ref_PID_CH(1,1:60:end),'-b','linewidth',2)
hold on
plot(log_d_PID_CH(1,1:60:end),'-r','linewidth',2)
hold off
title('System Output');
legend('Reference','PID','Location','northeast')
xlabel('Time (min)')
ylabel('Directedness Value')
xlim([0 69])
ylim(y_lim_ref)
yticklabels(strrep(yticklabels,'-','$-$'))
grid on

subplot(2,3,5)
plot(up_PID_CH(1,1:60:end),'-m','linewidth',2)
hold on
yline(-4,'--k','Min','LabelHorizontalAlignment','left','LabelVerticalAlignment','bottom')
yline(4,'--k','Max','LabelHorizontalAlignment','right','LabelVerticalAlignment','top')
hold off
title('Control Output')
xlabel('Time (min)')
ylabel('Electric Field (V/cm)')
xlim([0 69])
ylim(y_lim_CTRL)
yticklabels(strrep(yticklabels,'-','$-$'))
grid on

subplot(2,3,6)
plot((log_d_PID_CH(1,1:60:end)-ref_PID_CH(1,1:60:end))./ref_PID_CH(1,1:60:end),'-c','linewidth',2)
title('Relative Tracking Error');
xlabel('Time (min)')
ylabel('Relative Tracking Error');
xlim([0 69])
ylim(y_lim_error)
yticklabels(strrep(yticklabels,'-','$-$'))
grid on





RMSE_SMC_CH = rmse(log_d_SMC_CH(1,:),ref_SMC_CH)
RMSE_PID_CH = rmse(log_d_PID_CH(1,:),ref_PID_CH)
RMSE_Improve_CH_SMC = ((RMSE_SMC_CH-RMSE_new_CH)/RMSE_SMC_CH)*100
RMSE_Improve_CH_PID = ((RMSE_PID_CH-RMSE_new_CH)/RMSE_PID_CH)*100

MSE_SMC_CH = immse(log_d_SMC_CH(1,:),ref_SMC_CH)
MSE_PID_CH = immse(log_d_PID_CH(1,:),ref_PID_CH)
MSE_Improve_CH_SMC = ((MSE_SMC_CH-MSE_new_CH)/MSE_SMC_CH)*100
MSE_Improve_CH_PID = ((MSE_PID_CH-MSE_new_CH)/MSE_PID_CH)*100

MAPE_SMC_CH = mape(log_d_SMC_CH(1,:),ref_SMC_CH)
MAPE_PID_CH = mape(log_d_PID_CH(1,:),ref_PID_CH)
MAPE_Improve_CH_SMC = ((MAPE_SMC_CH-MAPE_new_CH)/MAPE_SMC_CH)*100
MAPE_Improve_CH_PID = ((MAPE_PID_CH-MAPE_new_CH)/MAPE_PID_CH)*100

STEP_SMC_CH = stepinfo(log_d_SMC_CH(1,2051:end),1:2051,-0.9,0.9)
STEP_PID_CH = stepinfo(log_d_PID_CH(1,2051:end),1:2051,-0.9,0.9)

STEP_Improve_CH_SMC = ((STEP_SMC_CH.RiseTime-STEP_new_CH.RiseTime)/STEP_SMC_CH.RiseTime)*100
STEP_Improve_CH_SMC_Sec = (STEP_SMC_CH.RiseTime-STEP_new_CH.RiseTime)
STEP_Improve_CH_PID = ((STEP_PID_CH.RiseTime-STEP_new_CH.RiseTime)/STEP_PID_CH.RiseTime)*100
STEP_Improve_CH_PID_Sec = (STEP_PID_CH.RiseTime-STEP_new_CH.RiseTime)