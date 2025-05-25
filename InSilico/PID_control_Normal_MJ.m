clear all
close all
clc


ss = 3;
tt = 4;

%Initial Values
r1=.65*ones(1,2050);
r2=-.65*ones(1,2051);
r=[r1,r2];
ref=r;
dir_avg = 0;
avg_num = 100;
dir_flag = 1;


%Values for time
dt = 0.1;
ti = 0;
tf = 410;

%Control Parameters
h = 0.1;
len=length(0:tf/((tf-ti)/dt):tf);


UL = 4;
LL = -4;
flag = 1;

jj=1;



%Reassigning Initial Conditions


%Initial Errors
e=ref(1)-dir_avg;

%Counter
i=2;


% PID
K_P = 0.2;
K_I = 0.08;
K_D = 0.03;
u = zeros(1,len);
u_temp = u;
e(1) = 0;
KP = zeros(1,len);
KD = zeros(1,len);
KI = zeros(1,len);







%Loop for ODE calculations where the control input is
%Calculated at only certain time points (i.e. discrete control
%with a continuous system)
for i=2:len


    k=1;

    if k==1
        up(i)=u(i);
    end

    if  (LL <= u(i)) && (u(i) <= UL)
        u(i) = u(i);
    elseif UL < u(i)
        u(i) = UL;
    else
        u(i) = LL;
    end
    u(i) = flag*u(i);
    uu = u(i);

    %Just wanted to see the time input to the ODE
    ee=ref(i)-dir_avg;
    % logging data
    log_d(:,i)=[dir_avg,uu,ee];


    %Solving ODE for each sampling time
    for j = 1:avg_num
        dir_m(i,j) = directedness_model3_MJ(uu,dir_flag,ss,i,tt);

    end
    dir_avg = sum(dir_m(i,:))/avg_num;


    %PID control calculations
    e(i) = ref(i)-dir_avg;
    KP(i) = K_P*e(i);
    KD(i) = K_D*((e(i) - e(i-1))/h);
    u_temp(i) = KP(i) + KD(i) + KI(i);
    u(i+1) = u_temp(i);
    KI(i+1) = h*K_I*e(i) + KI(i);

    jj=jj+1;
    i=i+1;


end

%

%Plots
figure(1)
plot(ref,'-b','linewidth',2)
hold on
plot(log_d(1,:),'-r','linewidth',2)
hold off
title('Output');
legend('Reference','System Output','Location','northeast')
xlabel('Time (sec)')
ylabel('Directedness Value')
grid on

figure(90)
plot((log_d(1,:)-ref)./ref,'-c','linewidth',2)
title('Relative Tracking Error');
xlabel('Time (sec)')
grid on

figure(2)
plot(log_d(2,:),'-k','linewidth',2)
hold on
plot(up,'-m','linewidth',2)
hold off
title('Control outputs before and after saturation');
legend('Saturated control output','Unsaturated control ouput','Location','northwest')
xlabel('Time (sec)')
ylabel('Current (A)')
grid on
hold off


figure(3)
plot(log_d(3,:),'-c','LineWidth', 2)
title('Tracking error');
xlabel('Time (sec)')
grid on

figure(4)
plot(log_d(2,:),'-k','LineWidth', 2)
title('Saturated control output');
xlabel('Time (sec)')
ylabel('Current (A)')
grid on

figure(5)
plot(up,'-m','LineWidth', 2)
title('Control output');
xlabel('Time (sec)')
ylabel('Current (A)')
grid on
