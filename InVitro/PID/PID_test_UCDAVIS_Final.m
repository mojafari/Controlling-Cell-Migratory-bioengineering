clc
clear all
close all

direct_path = "/Users/kzhu1/Desktop/06162022/";

dir_content = dir(direct_path);
filenames = {dir_content.name};
current_files = filenames;


delay = 300;   % change based on sampling time of the microscope

waitMax = 20;
jjj = 1;
image_mean = [];




Nnc = 100;    % Number of points
%T = 1;

timeref = 1:Nnc+1;


xx = 1;


reff=60;

r(timeref)=60*ones(1,Nnc+1);     % constant signal

plot(r(1:end),'b','linewidth',1.5)
ref = r(1:Nnc);  % Then, use this one for plotting

time = 1:Nnc;
in = ref;

len1 = length(in);


x_d = in; % desired trajectory
d(1) = x_d(1);
x(1)=0;
dot_x = zeros(1,len1); % if input trajectory is constant

e(1) = 0; % initial error
eP_ = e(1);
eD_ = e(1);
eD__ = e(1);
kp = .00006;
ki = .000006;
kd = .000002;

u(1) = 0; % initial control input
nu(1) = 0; % initial artificial control input

A_max = 1; % maximum Voltage to be applied

T_samp = 300; % sampling time for the denominator
dt = T_samp;

aaa = u(1);
u_app(1) = aaa;
pid_out = [];

%% Main Loop

for i1=1:len1


    % begin reading the new image

    new_files = setdiff(filenames,current_files)
    while jjj <10
        ~isempty(new_files)
        if ~isempty(new_files)
            system('python ImageAnalysis_cl_dirCh_updated.py')

            image_mean1 = data_reading_rec; %double check
            image_mean = [image_mean image_mean1] % double check
            current_files = filenames;
            break;
        else
            for count=1:waitMax
                dir_content = dir(direct_path);
                filenames = {dir_content.name};
                new_files = setdiff(filenames,current_files);
                if ~isempty(new_files)
                    jjj=jjj-1;
                    break; %Exit this loop (return to the main loop)
                end
            end
        end
    end

    x;
    %%
    x(1,i1) = image_mean(1,i1);


    e(i1)= x(i1)-x_d(i1);
    eP = e(i1);
    eI = e(i1);
    eD = e(i1);
    u = u-(kp*(eP - eP_) + ki*dt*eI + kd*(eD - 2*eD_ + eD__)/dt);
    pid_out=[pid_out u];
    u_sat(i1) = Saturation(u);
    eD__ = eD_;
    eD_ = eD;
    eP_ = eP;

    aaa = u_sat(i1); % for closed-loop

    u_app(i1) = aaa;

    Current_Control("COM6",aaa,"ON")
    if image_mean(i1)>reff
        x_d=-abs(x_d);
    end


    d(i1) = x_d(i1);

    subplot(2,2,1)
    plot(d(1:end),'b','linewidth',1.5)
    hold on
    plot(image_mean(1:end)','-or','linewidth',1.5)
    title('Output');
    xlabel('Time')
    ylabel('Recruitment Index Value')
    grid on


    subplot(2,2,2)
    plot(u_sat(1:end),'-*g','linewidth',1.5)
    title('Applied Control Output');
    xlabel('Time')
    ylabel('Current (A)')
    grid on


    subplot(2,2,3)
    plot(e(1:end),'-*c','linewidth',1.5)
    title('Tracking Error');
    xlabel('Time')
    grid on


    subplot(2,2,4)
    plot(pid_out(1:end),'-*g','linewidth',1.5)
    title('Actual Control Output');
    xlabel('Time')
    ylabel('Current (A)')
    grid on

    hold off
    MM(i1) = getframe(gcf);


    pause(delay)

end


