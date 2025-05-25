clc
clear all
close all

set(groot,'defaultAxesTickLabelInterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');
set(groot,'defaulttextInterpreter','latex');



ss = 3;
tt = 4;
sim_num = 24;
    

load("M0_rawdata_Cleaned.mat");


cells = M.data;
[rr cc] = size(cells);

for i=1:1:rr
    dir(i)=((cells(i,4)-cells(1,4))/sqrt((cells(i,4)-cells(1,4))^2+(cells(i,5)-cells(1,5))^2));
end

new_dir = reshape(dir,[24,513]);
new_dir(isnan(new_dir))=0;



for i = 1:sim_num
    for j = 1:101
        dir_math1(i,j) = directedness_model3_MJ(0,1,ss,i,tt);
    end
    dir_avg(1,i) = sum(dir_math1(i,:))/101;
end

dir_M0_1 = new_dir(:,1:101);
av_01(1,:)=sum(new_dir(:,1:101)')/101;
c_mean(1)=sum(sum(new_dir(:,1:101)')/101);
c_std(1)=std(sum((new_dir(:,1:101)')));


for i = 1:sim_num
    for j = 1:167
        dir_math3(i,j) = directedness_model3_MJ(1,1,ss,i,tt);
    end
    dir_avg(3,i) = sum(dir_math3(i,:))/167;
end

dir_M0_3 = new_dir(:,102:101+167);
av_01(3,:)=sum(new_dir(:,102:101+167)')/167;
c_mean(3)=sum(sum(new_dir(:,102:101+167)')/167);
c_std(3)=std(sum((new_dir(:,102:101+167)')));



for i = 1:sim_num
    for j = 1:68
        dir_math5(i,j) = directedness_model3_MJ(4,1,ss,i,tt);
    end
    dir_avg(5,i) = sum(dir_math5(i,:))/68;
end

dir_M0_5 = new_dir(:,269:268+68);
av_01(5,:)=sum(new_dir(:,269:268+68)')/68;
c_mean(5)=sum(sum(new_dir(:,269:268+68)')/68);
c_std(5)=std(sum((new_dir(:,269:268+68)')));



for i = 1:sim_num
    for j = 1:87
        dir_math2(i,j) = directedness_model3_MJ(0.5,1,ss,i,tt);
    end
    dir_avg(2,i) = sum(dir_math2(i,:))/87;
end

dir_M0_2 = new_dir(:,337:336+87);
av_01(2,:)=sum(new_dir(:,337:336+87)')/87;
c_mean(2)=sum(sum(new_dir(:,337:336+87)')/87);
c_std(2)=std(sum((new_dir(:,337:336+87)')));


for i = 1:sim_num
    for j = 1:90
        dir_math4(i,j) = directedness_model3_MJ(2,1,ss,i,tt);
    end
    dir_avg(4,i) = sum(dir_math4(i,:))/90;
end

dir_M0_4 = new_dir(:,424:423+90);
av_01(4,:)=sum(new_dir(:,424:423+90)')/90;
c_mean(4)=sum(sum(new_dir(:,424:423+90)')/90);
c_std(4)=std(sum((new_dir(:,424:423+90)')));


bb = 1; 

errbar1 = [std(av_01(1,bb:end))*ones(1,length(1:24)) ; std(av_01(1,bb:end))*ones(1,length(1:24))];
errbar2 = [std(av_01(2,bb:end))*ones(1,length(1:24)) ; std(av_01(2,bb:end))*ones(1,length(1:24))];
errbar3 = [std(av_01(3,bb:end))*ones(1,length(1:24)) ; std(av_01(3,bb:end))*ones(1,length(1:24))];
errbar4 = [std(av_01(4,bb:end))*ones(1,length(1:24)) ; std(av_01(4,bb:end))*ones(1,length(1:24))];
errbar5 = [std(av_01(5,bb:end))*ones(1,length(1:24)) ; std(av_01(5,bb:end))*ones(1,length(1:24))];
 
EF_list = [0, 0.5, 1, 2, 4];

EFM_Mean = [mean(dir_avg(1,bb:end)),mean(dir_avg(2,bb:end)),mean(dir_avg(3,bb:end)),mean(dir_avg(4,bb:end)),mean(dir_avg(5,bb:end))];
EFM_Median = [median(dir_avg(1,bb:end)),median(dir_avg(2,bb:end)),median(dir_avg(3,bb:end)),median(dir_avg(4,bb:end)),median(dir_avg(5,bb:end))];
EFM_err = [std(dir_avg(1,bb:end)),std(dir_avg(2,bb:end)),std(dir_avg(3,bb:end)),std(dir_avg(4,bb:end)),std(dir_avg(5,bb:end))];
EFD_Mean = [mean(av_01(1,bb:end)),mean(av_01(2,bb:end)),mean(av_01(3,bb:end)),mean(av_01(4,bb:end)),mean(av_01(5,bb:end))];
EFD_Median = [median(av_01(1,bb:end)),median(av_01(2,bb:end)),median(av_01(3,bb:end)),median(av_01(4,bb:end)),median(av_01(5,bb:end))];
EFD_err = [std(av_01(1,bb:end)),std(av_01(2,bb:end)),std(av_01(3,bb:end)),std(av_01(4,bb:end)),std(av_01(5,bb:end))];



figure
subplot(2,2,1)
shadedErrorBar(1:24, dir_avg(1,bb:end), errbar1, 'lineprops', '-b');
hold on
plot(dir_avg(1,bb:end),':b','linewidth',2)
plot(av_01(1,bb:end),'--b','linewidth',2)

shadedErrorBar(1:24, dir_avg(2,bb:end), errbar2, 'lineprops', '-r');
plot(dir_avg(2,bb:end),':r','linewidth',2)
plot(av_01(2,bb:end),'--r','linewidth',2)

shadedErrorBar(1:24, dir_avg(3,bb:end), errbar3, 'lineprops', '-g');
plot(dir_avg(3,bb:end),':g','linewidth',2)
plot(av_01(3,bb:end),'--g','linewidth',2)

shadedErrorBar(1:24, dir_avg(4,bb:end), errbar4, 'lineprops', '-c');
plot(dir_avg(4,bb:end),':c','linewidth',2)
plot(av_01(4,bb:end),'--c','linewidth',2)

shadedErrorBar(1:24, dir_avg(5,bb:end), errbar5, 'lineprops', '-m');
plot(dir_avg(5,bb:end),':m','linewidth',2)
plot(av_01(5,bb:end),'--m','linewidth',2)
xlabel('Frame Number')
ylabel('Directedness Value')
ylim([-0.2 1.2])
yticklabels(strrep(yticklabels,'-','$-$'))



subplot(2,2,2)
shadedErrorBar(1:24, dir_avg(1,bb:end), errbar1, 'lineprops', '-b');
hold on
plot(dir_avg(1,bb:end),':b','linewidth',2)
plot(av_01(1,bb:end),'--b','linewidth',2)

shadedErrorBar(1:24, dir_avg(2,bb:end), errbar2, 'lineprops', '-r');
plot(dir_avg(2,bb:end),':r','linewidth',2)
plot(av_01(2,bb:end),'--r','linewidth',2)

shadedErrorBar(1:24, dir_avg(3,bb:end), errbar3, 'lineprops', '-g');
plot(dir_avg(3,bb:end),':g','linewidth',2)
plot(av_01(3,bb:end),'--g','linewidth',2)

shadedErrorBar(1:24, dir_avg(4,bb:end), errbar4, 'lineprops', '-c');
plot(dir_avg(4,bb:end),':c','linewidth',2)
plot(av_01(4,bb:end),'--c','linewidth',2)

shadedErrorBar(1:24, dir_avg(5,bb:end), errbar5, 'lineprops', '-m');
plot(dir_avg(5,bb:end),':m','linewidth',2)
plot(av_01(5,bb:end),'--m','linewidth',2)
xlabel('Frame Number')
ylabel('Directedness Value')
xlim([5 25])
ylim([-0.2 1.2])
yticklabels(strrep(yticklabels,'-','$-$'))
lgd = legend('','$EF_{Model} = 0$','$EF_{Data} = 0$','','$EF_{Model} = 0.5$','$EF_{Data} = 0.5$','','$EF_{Model} = 1$','$EF_{Data} = 1$','','$EF_{Model} = 2$','$EF_{Data} = 2$','','$EF_{Model} = 4$','$EF_{Data} = 4$','Location','northwest','Orientation','horizontal')
lgd.NumColumns = 5;

subplot(2,2,3)
errorbar(EF_list,EFM_Mean,EFM_err,'linewidth',2)
hold on
errorbar(EF_list,EFD_Mean,EFD_err,'linewidth',2)
xlabel('Electric Field (V/cm)')
ylabel('Directedness Value (Mean)')
xlim([-0.2 4.2])
ylim([-0.2 1.2])
yticklabels(strrep(yticklabels,'-','$-$'))
legend("Model","Data")

subplot(2,2,4)
errorbar(EF_list,EFM_Median,EFM_err,'linewidth',2)
hold on
errorbar(EF_list,EFD_Median,EFD_err,'linewidth',2)
xlabel('Electric Field (V/cm)')
ylabel('Directedness Value (Median)')
xlim([-0.2 4.2])
ylim([-0.2 1.2])
yticklabels(strrep(yticklabels,'-','$-$'))
legend("Model","Data")