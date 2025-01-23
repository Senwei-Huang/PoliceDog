clear,clc;close all;
addpath(genpath('./utilities'));
save_dir = "./SaveFigure/com_foot/"; % 保存路径
if ~exist(save_dir, 'dir')
    mkdir(save_dir);
end

% 控制画哪些图
PLOT_comfoot1 = 0; % 质心和足端轨迹 XZ
PLOT_comfoot2 = 1; % 质心和足端轨迹 XZ
PLOT_foot1 = 0; % 足端轨迹 t-X和t-Z
PLOT_foot2 = 0; % 足端轨迹wH t-X和t-Z

motion_type = "(5 low height jump 2)";
% motion_type = "(6 mid height jump 1)";
% motion_type = "(7 high height jump 1)";
% motion_type = "(ring jump 1)"; % 警犬穿越圆洞 圆心高0.115m
% motion_type = "(ring jump 2)";

% 地面水平位置Z=-0.2346m

%% 数据导入：腿和髋部顺序是左前（2：4）右前（5：7）左后（8：10）右后（11：13）
if (motion_type == "(fast run and slow walk)")
    n_data = 85;
    raw_data = readmatrix('./3 fast run and slow walk 2/raw_data.csv'); % 小跑
    raw_data = raw_data(1:n_data,:);

elseif (motion_type == "(prone-stance)")
    n_data = 2361;
    raw_data = readmatrix('./4 prone-stance/raw_data.csv'); % 蹲起
    raw_data = raw_data(1:n_data,:);

elseif (motion_type == "(1 low height jump 1)")
    raw_data = readmatrix('./1 low jump 1/raw_data.csv');
    actionNum = 5;
    n_data = 57; % 数据完整的行数，再往后取数据不全
    angle = 31*pi/60; % 将X轴转为奔跑的正方向要转动的角度，根据画出来的结果试出来的
    T.start = 2.375;
    T.end = 2.758;
    T.body = [-2 2.483 -3 -1];
    %左前腿
    T.LF = [-1 -2 2.4 -3 -1];
    %右前腿
    T.RF = [-2 -3 -1 -1];
    %左后腿
    T.LH = [-2 2.408 2.483 -3 -1 -1];
    %右后腿
    T.RH = [-2 2.4 2.467 -3];
    OBS='1';
    xlimit = [-2 1.5]; % [-2.4 2.6]
    zlimit = [0 1];
    
    % 起跳
    Tto_RF = 1.98; %RF腿离地的时刻
    Tto_LF = 2.02; %LF腿离地的时刻
    Ttd_RH = 1.99; %RH腿触地的时刻
    Ttd_LH = 2.015; %LH腿触地的时刻
    Tto_RH = 2.05; %RH腿离地的时刻
    Tto_LH = 2.1; %LH腿离地的时刻
    % 落地
    Ttd_RF = 2.333;
    Ttd_LF = 2.358;
    phaseT = [Tto_RF,Tto_LF, Ttd_RH,Ttd_LH, Tto_RH,Tto_LH, Ttd_RF,Ttd_LF]; % 各腿各相位的时刻
    phaseN = ["t_{to}^{RF}", "t_{to}^{LF}", "t_{td}^{RH}", "t_{td}^{LH}", ...
        "t_{to}^{RH}", "t_{to}^{LH}", "t_{td}^{RF}", "t_{td}^{LF}"]; % 各腿名称与相位

elseif (motion_type == "(5 low height jump 2)")
    raw_data = readmatrix('../../raw_data/1 low hurdle/raw_data.csv');
    actionNum = 5;
    n_data = 45; % 数据完整的行数，再往后取数据不全
    angle = 31*pi/60; % 将X轴转为奔跑的正方向要转动的角度，根据画出来的结果试出来的
    T.start = 2.375;
    T.end = 2.758;
    T.body = [-2 2.483 -3 -1];
    %左前腿
    T.LF = [-1 -2 2.4 -3 -1];
    %右前腿
    T.RF = [-2 -3 -1 -1];
    %左后腿
    T.LH = [-2 2.408 2.483 -3 -1 -1];
    %右后腿
    T.RH = [-2 2.4 2.467 -3];
    OBS='1';
    xlimit = [-2 1.5]; % [-2.4 2.6]
    zlimit = [0 1.5]; % [0 1]
    % 起跳
    Tto_RF = T.start; %RF腿离地的时刻
    Tto_LF = 2.4; %LF腿离地的时刻
    Ttd_RH = 2.4; %RH腿触地的时刻
    Ttd_LH = 2.408; %LH腿触地的时刻
    Tto_RH = 2.467; %RH腿离地的时刻
    Tto_LH = 2.483; %LH腿离地的时刻
    % 落地
    Ttd_RF = T.end;
    Ttd_LF = T.end;

elseif (motion_type == "(6 mid height jump 1)")
    raw_data = readmatrix('../../raw_data/2 medium hurdle/raw_data.csv');
    actionNum = 6;
    n_data = 57; %数据完整的行数，再往后取数据不全
    angle = -pi/25; %将X轴转为奔跑的正方向要转动的角度，根据画出来的结果试出来的
    T.start = 2.658;
    T.end = 3.2;
    T.body = [-2 2.883 3.183 -3];
    %左前腿
    T.LF = [-2 2.708 2.792 3.183 -3];
    %右前腿
    T.RF = [-1 -2 2.742 -3];
    %左后腿
    T.LH = [-1 -2 2.692 2.8 2.883 -3];
    %右后腿
    T.RH = [-2 2.758 2.858 -3];
    OBS='1';
    xlimit = [-2.2 1.3]; % [-2.4 2.6]
    zlimit = [0 1.5]; % [0 1]

elseif (motion_type == "(7 high height jump 1)")
    raw_data = readmatrix('../../raw_data/3 high hurdle/raw_data.csv');
    actionNum = 7;
    n_data = 57; %数据完整的行数，再往后取数据不全
    angle = -pi/16; %将X轴转为奔跑的正方向要转动的角度，根据画出来的结果试出来的
    T.start = 2.583;
    T.end = 3.042;
    T.body = [-2 2.725 -3 -1];
    % 左前腿
    T.LF = [-1 -2 2.642 -3 -1];
    % 右前腿
    T.RF = [-1 -2 2.625 -3];
    % 左后腿
    T.LH = [-2 2.633 2.725 -3 -1 -1];
    % 右后腿
    T.RH = [-2 2.625 2.717 -3];
    OBS='1';
    xlimit = [-2.1 1.4]; % [-2.4 2.6]
    zlimit = [0 1.5]; % [0 1.6]

elseif (motion_type == "(ring jump 1)")
    raw_data = readmatrix('../../raw_data/4 circular hole (takeoff)/raw_data.csv');
    actionNum = 8;
    n_data = 55;
    angle = -0.1915;
    T.start = 2.6;
    T.end = 3.05;
    T.body = [-2 2.767 -3 -1];
    % 左前腿
    T.LF = [-1 -2 2.65 -3 -1];
    % 右前腿
    T.RF = [-1 -2 2.683 -3];
    % 左后腿
    T.LH = [-2 2.683 2.767 -3 -1 -1];
    % 右后腿
    T.RH = [-2 2.667 2.758 -3];
    OBS='circle';
    xlimit = [-2.3 1.2]; % [-2.4 2.6]
    zlimit = [0 1.5]; % [-0.07 1.9]

elseif (motion_type == "(ring jump 2)")
    raw_data = readmatrix('../../raw_data/5 circular hole (landing)/raw_data.csv');
    actionNum = 9;
    n_data = 45;
    angle = -0.1915;
    T.start = 2.517;
    T.end = 2.883;
    T.body = [-1 -2 2.75 -3];
    %左前腿
    T.LF = [-2 2.75 2.842 -3 -1];
    %右前腿
    T.RF = [-2 2.758 2.858 -3];
    %左后腿
    T.LH = [-2 -3 -1 -1 -1 -1];
    %右后腿
    T.RH = [-2 2.825 -3 -1];
    OBS='circle';
    xlimit = [-0.8 2.7]; % [-2.4 2.6]
    zlimit = [0 1.5]; % [0 1.9]
end

%% 提取数据 ##############################################################################
data = data_rotate_ALL(raw_data,n_data,angle);
t = data(:,1);
obs = data(1,89:91);
data = data+[zeros(n_data,1) repmat(-obs,n_data,(size(data,2)-1)/3)];
% 太阳穴
temple = data(:,92:94);
% 前脊椎
spinefront = data(:,95:97);
% 中脊椎
spinemid = data(:,98:100);
% 后脊椎
spineback = data(:,101:103);
%尾巴
tail_1 = data(:,104:106);
tail_2 = data(:,107:109);
% 左前腿
hip_LF = data(:,14:16);
knee_LF = data(:,17:19);
ankle_LF = data(:,20:22);
foot_LF = data(:,23:25);
% 左后腿
hip_LH = data(:,26:28);
knee_LH = data(:,29:31);
ankle_LH = data(:,32:34);
foot_LH = data(:,35:37);
% 右前腿
hip_RF = data(:,56:58);
knee_RF = data(:,59:61);
ankle_RF = data(:,62:64);
foot_RF = data(:,65:67);
% 右后腿
hip_RH = data(:,68:70);
knee_RH = data(:,71:73);
ankle_RH = data(:,74:76);
foot_RH = data(:,77:79);

mid_spine = data(:,98:100); % 左右中脊椎连线中点（XYZ）
left_hand = data(:,23:25); % 左手位置(XYZ)
left_foot = data(:,35:37); % 左脚位置(XYZ)
right_hand = data(:,65:67); % 右手位置(XYZ)
right_foot = data(:,77:79); % 右脚位置(XYZ)
object1 = data(1,86:88); % 障碍物上沿中间点位置（XYZ）
object2 = data(1,89:91); % 障碍物下沿中间点位置（XYZ）
object1(:,2) = object2(:,2);
object1(:,1) = object2(:,1);
obstacle = [object1; object2];

% %计算每条腿到障碍物上方时的抬腿高度
% %idx索引是我自己确定的，记录在平板放生数据里
% idx = 30;
% height_LF =  hip_LF(idx,3)-foot_LF(idx,3)
% idx = 32;
% height_RF =  hip_RF(idx,3)-foot_RF(idx,3)
% idx = 54;
% height_LH =  hip_LH(idx,3)-foot_LH(idx,3)
% idx = 55;
% height_RH =  hip_RH(idx,3)-foot_RH(idx,3)

[~,~,~,~,time,pitch_deg,~,~]=data_process(raw_data,n_data,angle);

%% 画图 ##############################################################################
if (PLOT_comfoot1)
    h = figure(1);
    set(h,'pos',[350 250 850 380]);
    plot3(mid_spine(:,1),mid_spine(:,2),mid_spine(:,3), ...
        left_hand(:,1),left_hand(:,2),left_hand(:,3),'--',...
        left_foot(:,1),left_foot(:,2),left_foot(:,3),'-.',...
        right_hand(:,1),right_hand(:,2),right_hand(:,3),':',...
        right_foot(:,1),right_foot(:,2),right_foot(:,3),':',...
        'linewidth',2);
    hold on
    if strcmp(OBS,'circle')
        PLOTcircle(obstacle(2,1),obstacle(2,3))
    else
        plot3(obstacle(:,1), obstacle(:,2), obstacle(:,3), 'linewidth', 10,'color','k') % 障碍物
    end
    text(-0.45, 0, 0.25,'obstacle','Fontsize',18,'fontname','Times') % 障碍物文本
    axis equal
    legend('CoM','LF','LH','RF','RH','Fontsize',12,'fontname','Times','Location','east');
    legend('boxoff');
    view(0,0);
    xlim(xlimit)
    zlim(zlimit)
    xlabel('X position [m]','Fontsize',12,'Fontname','Times New Roman')
    ylabel('Y position [m]','Fontsize',12,'Fontname','Times New Roman')
    zlabel('Z position [m]','Fontsize',12,'Fontname','Times New Roman')
    set(get(gca,'XLabel'),'FontSize',12);
    set(get(gca,'YLabel'),'FontSize',12);
    set(get(gca,'ZLabel'),'FontSize',12);
%     title('CoM and Foot Position','Fontsize',12,'Fontname','Times New Roman')
%     saveas(h, save_dir+'CoM with foot position '+motion_type+".svg")
%     saveas(h, save_dir+'CoM with foot position '+motion_type+".emf")
end

%% 质心和足端轨迹 XZ
if (PLOT_comfoot2)
    h=figure(2);
    set(h,'pos',[350 250 850 380]); 
    markersize = 5;
    linewidth = 1;
    fontsize = 25;
    fontname ='Times New Roman';
%     colorname = {[0.8500 0.3250 0.0980], [0.9290 0.6940 0.1250], [0.4940 0.1840 0.5560], [0.4660 0.6740 0.1880], [0 0.4470 0.7410]};
    legendname = {'LF', 'RF', 'LH', 'RH', 'CoM', 'Pitch'};
    hold on
%     yyaxis left
    p1 = plot3(left_hand(:,1), left_hand(:,2), left_hand(:,3), '-', 'Marker', 'o','MarkerSize', markersize,'linewidth', linewidth, 'DisplayName', legendname{1});
    p2 = plot3(right_hand(:,1), right_hand(:,2), right_hand(:,3), '-', 'Marker', '.','MarkerSize', markersize,'linewidth', linewidth, 'DisplayName', legendname{2});
    p3 = plot3(left_foot(:,1), left_foot(:,2), left_foot(:,3), '-', 'Marker', 'p','MarkerSize', markersize,'linewidth', linewidth, 'DisplayName', legendname{3});
    p4 = plot3(right_foot(:,1), right_foot(:,2), right_foot(:,3), '-', 'Marker', '^','MarkerSize', markersize,'linewidth', linewidth, 'DisplayName', legendname{4});
    p5 = plot3(mid_spine(:,1), mid_spine(:,2), mid_spine(:,3), "-", 'Marker', '|', 'MarkerSize', markersize,'linewidth', linewidth, 'DisplayName', legendname{5});
    if strcmp(OBS,'circle')
        PLOTcircle(obstacle(2,1), obstacle(2,3))
    else
        plot3(obstacle(:,1), obstacle(:,2), obstacle(:,3), 'linewidth', 10,'color','k') % 障碍物
    end
    view(0,0);
%     yyaxis right
%     p6 = plot(mid_spine(:,1), pitch_deg, "-", 'linewidth', linewidth, 'color', "b", 'DisplayName', legendname{6}); % [0.6350 0.0780 0.1840]
%     ylabel('Body pitch angle [rad]', 'Fontsize', fontsize, 'Fontname', fontname) 
%     text(-0.7, 0, 0.25, 'obstacle', 'Fontsize', fontsize, 'fontname', fontname) % 障碍物文本

%     legend([p1,p2,p3,p4,p5], 'Fontsize', fontsize, 'fontname', fontname, 'Location', 'northeast');
%     legend('boxoff');
    box on;
%     title('CoM and Foot Position', 'Fontsize', fontsize, 'Fontname', fontname)
    xlabel('X position [m]', 'Fontsize', fontsize, 'Fontname', fontname)
    ylabel('Y position [m]', 'Fontsize', fontsize, 'Fontname', fontname)
    zlabel('Z position [m]', 'Fontsize', fontsize, 'Fontname', fontname)
%     axis manual
%     axis equal
    xlim(xlimit)
    zlim(zlimit)
    set(gca, 'FontSize', fontsize);
    saveas(h, save_dir+"CoM with foot position and pitch"+motion_type+".svg")
    saveas(h, save_dir+'CoM with foot position and pitch'+motion_type+".emf")
end

%% 足端轨迹 t-X和t-Z
if (PLOT_foot1)
    h=figure(3);
    set(h,'pos',[350 250 850 380]);
    yyaxis right
    plot(time(:,1),pitch_deg,'linewidth',2,'color',[0.6350 0.0780 0.1840])
    ylabel('Pitch angle [rad]','Fontsize',12,'Fontname','Times New Roman')
    yyaxis left
    hold on
    plot(time(:,1),left_hand(:,1),'-','linewidth',2,'color',[0.8500 0.3250 0.0980]);
    plot(time(:,1),left_foot(:,1),'-','linewidth',2,'color',[0.9290 0.6940 0.1250]);
    plot(time(:,1),right_hand(:,1),'-','linewidth',2,'color',[0.4940 0.1840 0.5560]);
    plot(time(:,1),right_foot(:,1),'-','linewidth',2,'color',[0.4660 0.6740 0.1880]);

    plot(time(:,1),left_hand(:,3),':','Marker','o','MarkerSize',3,'linewidth',2,'color',[0.8500 0.3250 0.0980]);
    plot(time(:,1),left_foot(:,3),':','Marker','p','MarkerSize',3,'linewidth',2,'color',[0.9290 0.6940 0.1250]);
    plot(time(:,1),right_hand(:,3),':','Marker','s','MarkerSize',3,'linewidth',2,'color',[0.4940 0.1840 0.5560]);
    plot(time(:,1),right_foot(:,3),':','Marker','>','MarkerSize',3,'linewidth',2,'color',[0.4660 0.6740 0.1880]);
    % PLOTJumpPhase(phaseT, phaseN)
    ylabel('Z position [m]','Fontsize',12,'Fontname','Times New Roman')
    legend('$x^{\rm LF}$','$x^{\rm LH}$','$x^{\rm RF}$','$x^{\rm RH}$', ...
        '$z^{\rm LF}$','$z^{\rm LH}$','$z^{\rm RF}$','$z^{\rm RH}$', ...
        'Interpreter','latex','Fontsize',12,'Location','northeast')
    % legend('LF','LH','RF','RH','pitch','Fontsize',12,'fontname','Times','Location','northeast');
    legend('boxoff');
    ax = gca; % 获取当前坐标轴
    ax.Box = 'on'; % 开启坐标轴边框
    xlabel('Time [s]','Fontsize',12,'Fontname','Times New Roman')
    saveas(h, save_dir+"foot position and pitch "+motion_type+".svg")
    saveas(h, save_dir+'foot position and pitch '+motion_type+".emf")
end

%% 足端轨迹-wH 相对于髋关节（表示在世界坐标系）
[FOOT,time,HIP,CoM] = data_rotate(raw_data,n_data,angle);
FOOT = [time,FOOT];
HIP = [time,HIP];
if (PLOT_foot2)
    h=figure('name','Foot trajectory in wH');
    set(h,'pos',[350 250 850 380]);
    box on; % 图外框
    hold on;
    plot(FOOT(:,1),FOOT(:,2)-HIP(:,2),'-','color',[0.8500 0.3250 0.0980],'linewidth',2) % 左前腿 X
    plot(FOOT(:,1),FOOT(:,8)-HIP(:,8),'-','color',[0.9290 0.6940 0.1250],'linewidth',2) % 左后腿 X
    plot(FOOT(:,1),FOOT(:,5)-HIP(:,5),'-','color',[0.4940 0.1840 0.5560],'linewidth',2) % 右前腿 X
    plot(FOOT(:,1),FOOT(:,11)-HIP(:,11),'-','color',[0.4660 0.6740 0.1880],'linewidth',2) % 右后腿 X

    plot(FOOT(:,1),FOOT(:,4)-HIP(:,4),':','Marker','o','MarkerSize',3,'color',[0.8500 0.3250 0.0980],'linewidth',2) % 左前腿 Z
    plot(FOOT(:,1),FOOT(:,10)-HIP(:,10),':','Marker','p','MarkerSize',3,'color',[0.9290 0.6940 0.1250],'linewidth',2) % 左后腿 Z
    plot(FOOT(:,1),FOOT(:,7)-HIP(:,7),':','Marker','s','MarkerSize',3,'color',[0.4940 0.1840 0.5560],'linewidth',2) % 右前腿 Z
    plot(FOOT(:,1),FOOT(:,13)-HIP(:,13),':','Marker','>','MarkerSize',3,'color',[0.4660 0.6740 0.1880],'linewidth',2) % 右后腿 Z
    % PLOTJumpPhase(phaseT, phaseN);
    legend('$x^{\rm LF}$','$x^{\rm LH}$','$x^{\rm RF}$','$x^{\rm RH}$', ...
        '$z^{\rm LF}$','$z^{\rm LH}$','$z^{\rm RF}$','$z^{\rm RH}$', ...
        'Interpreter','latex','Fontsize',12,'Location','northeast')
    legend('boxoff');
    xlim([1.96 2.5])
    % zlim([-0.5 0.4])
    xlabel('Time [s]','Fontsize',12)
    ylabel('Foot position [m]','Fontsize',12)
    % title('Foot trajectory in wH','Fontsize',12)
    % saveas(h,save_dir+"Foot trajectory in wH "+motion_type+".emf");
    % saveas(h,save_dir+"Foot trajectory in wH "+motion_type+".svg");
end