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
%dt=1:1:801;
h = 0.1;
len=length(0:tf/((tf-ti)/dt):tf);
new_in=zeros(1,len);
new_in(1,:)=ref;


UL = 4;
LL = -4;
flag = 1;

jj=1;



%Reassigning Initial Conditions


%Initial Errors
e=ref(1)-dir_avg;

%Counter
i=2;


% SMC
flag = 1;
sign_flag=flag;
A_max = UL;
K_pos = 0.5;
ro_gain = 5e-5;
T_samp = 1;
u(1)=0;
u(2)=0;
u = zeros(1,len);







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


    %SMC control calculations
    e(i) = ref(i)-dir_avg;
    if e(i)>0
        K_pos = .01;
        ro_gain = 1e-3;
    else
        K_pos = .04;
        ro_gain = 5e-3;
    end


    S(i) = K_pos*(e(i)) + (((new_in(i)-new_in(i-1))/T_samp)-((r(i)-r(i-1))/T_samp));

    nu(i) = sign_flag*ro_gain*sign(S(i)*A_max*cos(u(i-1)));

    u(i) = u(i-1)+(nu(i-1) + nu(i))/2*T_samp;
    u_sat(i) = A_max*sin(u(i));

    uu = u_sat(i);

    u(i+1) = uu;

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