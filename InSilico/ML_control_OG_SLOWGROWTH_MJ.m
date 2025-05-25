clear all
close all
clc


ss = 3;
tt = 4;

%Initial Values
r1=.9*ones(1,2050);
r2=-.9*ones(1,2051);
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
c=0:.01:2;
num=6;
n1=length(c);
c=repmat(c,[num 1]);
rng(1);
W=rand(1,n1)*1e-4;
beeta=1;
learning_rate=5e-4;
new_in=zeros(num,len);
new_in(1,:)=ref;
new_in(2,1)=dir_avg;


UL = 4;
LL = -4;
flag = 1;
g1= 7.5e-2;
a1 = 1e-1;
g2= 2.7e-1;
a2 = 4e-1;
jj=1;
g0=1;


%Reassigning Initial Conditions


%Initial Errors
e=ref(1)-dir_avg;

%Counter
i=1;


%Loop for ODE calculations where the control input is
%Calculated at only certain time points (i.e. discrete control
%with a continuous system)
for t=0:tf/((tf-ti)/dt):tf
    Weights(i,:)=W;
    k=1;
    for j=1:n1
        ED(i,j)=exp((-((new_in(:,i)/200-c(:,j))'*(new_in(:,i)/200-c(:,j))))/(2*beeta^2));
    end
    u(i)=W*ED(i,:)';%output of RBF

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
    time=[t,t+dt];
    ee=e;
    % logging data
    log_d(:,i)=[dir_avg,uu,ee];


    %Solving ODE for each sampling time
    for j = 1:avg_num
        dir_m(i,j) = directedness_model3_MJ(uu,dir_flag,ss,i,tt);
    end
    dir_avg = sum(dir_m(i,:))/avg_num;

    e=ref(i)-dir_avg;

    W=W+learning_rate*e*ED(i,:)*g0;

    new_in(2,1+i)=dir_avg;
    new_in(3,1+i)=new_in(2,i);
    new_in(4,1+i)=new_in(3,i);
    new_in(5,1+i)=new_in(4,i);
    new_in(6,1+i)=new_in(5,i);

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
title('Saturated control Output');
xlabel('Time (sec)')
ylabel('Current (A)')
grid on

figure(5)
plot(up,'-m','LineWidth', 2)
title('Control output');
xlabel('Time (sec)')
ylabel('Current (A)')
grid on