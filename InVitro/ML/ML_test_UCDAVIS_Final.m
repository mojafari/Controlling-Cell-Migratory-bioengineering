clc
clear all
close all


direct_path = "/Users/kzhu1/Desktop/06152022/";

dir_content = dir(direct_path);
filenames = {dir_content.name};
current_files = filenames;


delay = 300;   % change based on sampling time of the microscope

waitMax = 20;
jjj = 1;
image_mean = [];

UL = 0.95e-3;
LL = -0.95e-3;


Nnc = 100;    % Number of points
%T = 1;

timeref = 1:Nnc+1;


xx = 1;

reff = 60;

r(timeref)=60*ones(1,Nnc+1);     % constant signal

plot(r(1:end),'b','linewidth',1.5)
ref = r(1:Nnc);  % Then, use this one for plotting

time = 1:Nnc;
in = ref;

len1 = length(in);
runs = 1;
epochs = 1;
epochs1 = 1;   % Number of times same signal pass through the RBF
learning_rate = 9e-5;%7e-1;%(last_tufts)%2e-2;%5e-2; %6e-3;%5e-4;   % step-size of Gradient Descent Algorithm
noise_var = 1e-1;         % disturbance power / noise in desired outcome

x = in;
num_in = 6;%3; % here we want to consider error and integral of error and derivative of error
new_x = zeros(num_in,len1);

new_x(1,:) = in;
c = repmat([-5:0.1:5],[num_in,1]); %repmat([0:2:50],[num_in,1]); %(last_tufts)  %c = [-0.78:0.01:0.78];%[0:0.01:3];%[0:0.01:2]; % Gaussian Kernel's centers
n1 = length(c);   % Number of neurons

a=0.4;
beeta = 1;        % Spread of Gaussian Kernels
MSE_epoch = 0;    % Mean square error (MSE) per epoch
MSE_train = 0;    % MSE after #runs of Monte Carlo simulations

epoch_W1    =   0; % To store final weights after an epoch
epoch_b     =   0; % To store final bias after an epoch

SCF = 1;%1e-1; %(last_tufts)

flag = 1;
%% Main Loop

for i1=1:len1
    W1  = rand(1,n1)*1e-5;
    for k=1:epochs


        for i1=1:len1

            for i2 = 1:n1
                ED(i1,i2) = exp((-((new_x(:,i1)/50-c(:,i2))'*(new_x(:,i1)/50-c(:,i2))))/(2*beeta^2));

            end



            % Output of the RBF
            u(i1) = W1*ED(i1,:)';
            aa(i1) = flag*SCF*u(i1);
            up(i1) = aa(i1);



            % begin reading the new image

            new_files = setdiff(filenames,current_files)
            while jjj <10
                ~isempty(new_files)
                if ~isempty(new_files)
                    system('python ImageAnalysis_cl_dirCh_updated.py')
                    image_mean1 = data_reading_rec;

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

            % end reading the new image

            image_mean
            x;
            u_app(i1) = Saturation(up(i1));

            y(i1) = image_mean(i1);

            if image_mean(i1) > ref
                in=-abs(in);
            end

            d(i1) =in(i1);

            % Instantaneous error of estimation
            e(i1)=d(i1)-y(i1);
            Current_Control("COM6",u_app(i1),"ON")

            subplot(2,2,1)
            plot(d(1:end),'b','linewidth',1.5)
            hold on
            plot(image_mean(1:end)','-or','linewidth',1.5)
            title('Output');
            xlabel('Time')
            ylabel('Recruitment Index Value')
            grid on


            subplot(2,2,2)
            plot(u_app(1:end),'-*g','linewidth',1.5)
            title('Applied Control Output');
            xlabel('Time')
            ylabel('Current (mA)')
            grid on

            subplot(2,2,3)
            plot(e(1:end),'-*c','linewidth',1.5)
            title('Tracking Error');
            xlabel('Time')
            grid on

            subplot(2,2,4)
            plot(up(1:end),'-*g','linewidth',1.5)
            title('Actual Control Output');
            xlabel('Time')
            ylabel('Current (mA)')
            grid on

            hold off
            MM(k) = getframe(gcf);


            % Gradient Descent-based adaptive learning (Training)
            if  (LL <= up(i1)) && (up(i1) <= UL)

                W1=W1+learning_rate*e(i1)*ED(i1,:);

            elseif UL < up(i1)

                W1=W1+learning_rate*e(i1)*ED(i1,:)-sign(e(i1))*a*learning_rate*((W1*W1'*ED(i1,:))/norm(W1))*e(i1);

            else

                W1=W1+learning_rate*e(i1)*ED(i1,:)+sign(e(i1))*a*learning_rate*((W1*W1'*ED(i1,:))/norm(W1))*e(i1);

            end

            new_x(2,i1+1) = y(i1);
            new_x(3,i1+1) = new_x(1,i1);
            new_x(4,i1+1) = new_x(2,i1);
            new_x(5,i1+1) = new_x(3,i1);
            new_x(6,i1+1) = new_x(4,i1);
            Weights(i1,:)=W1;
            pause(delay)
        end

    end

end


