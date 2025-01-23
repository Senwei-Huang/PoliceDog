clear; clc; close all;
addpath('../utilities');
save_dir = "./SaveFigure/body_motion/"; % 保存路径
if ~exist(save_dir, 'dir')
    mkdir(save_dir);
end

% 控制画哪些图
PLOT_traj = 1;
PLOT_Stick = 1;
motion_type = "(5 low height jump 2)";
% motion_type = "(6 mid height jump 1)";
% motion_type = "(7 high height jump 1)";
% motion_type = "(ring jump 1)"; % 警犬穿越圆洞 圆心高0.115m
% motion_type = "(ring jump 2)";

%% 数据读取 ##############################################################################
if (motion_type == "(5 low height jump 2)")
    actionNum = 5;
    raw_data = readmatrix('../../raw_data/1 low hurdle/raw_data.csv');
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
    xlimit = [-2 1.5];
    zlimit = [0 1.5]; % [0 1]
elseif (motion_type == "(6 mid height jump 1)")
    raw_data = readmatrix('../../raw_data/2 medium hurdle/raw_data.csv');
    actionNum = 6;
    n_data = 57;
    angle = -pi/25;
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
    xlimit = [-2.2 1.3];
    zlimit = [0 1.5]; % [0 1]
elseif (motion_type == "(7 high height jump 1)")
    raw_data = readmatrix('../../raw_data/3 high hurdle/raw_data.csv');
    actionNum = 7;
    n_data = 57;
    angle = -pi/16;
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
    xlimit = [-2.1 1.4];
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
    xlimit = [-2.3 1.2];
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
    xlimit = [-0.8 2.7];
    zlimit = [0 1.5]; % [0 1.9]
end

%% 数据分类 ##############################################################################
data = data_rotate_ALL(raw_data,n_data,angle);
t = data(1:n_data,1);
obs = data(1,89:91);
data = data+[zeros(n_data,1) repmat(-obs,n_data,(size(data,2)-1)/3)];

%% 画图 ##############################################################################
% 画质心和足端的曲线
if (PLOT_traj)
    h = figure(1);
    set(h,'pos',[350 250 850 380]);
    % 处理颜色以及帧数
    map = colormap(jet);
    tmap = linspace(t(1),t(end),length(map))';
    hold on
    for i = 1:n_data-1
        body1 = get_body_i(i,data);
        body2 = get_body_i(i+1,data);
%         h_line = plot3([body1.spinemid(1) body2.spinemid(1)],[body1.spinemid(2) body2.spinemid(2)],[body1.spinemid(3) body2.spinemid(3)],'-', ...
%             [body1.foot_LF(1) body2.foot_LF(1)],[body1.foot_LF(2) body2.foot_LF(2)],[body1.foot_LF(3) body2.foot_LF(3)],'--',...
%             [body1.foot_RF(1) body2.foot_RF(1)],[body1.foot_RF(2) body2.foot_RF(2)],[body1.foot_RF(3) body2.foot_RF(3)],'--',...
%             [body1.foot_LH(1) body2.foot_LH(1)],[body1.foot_LH(2) body2.foot_LH(2)],[body1.foot_LH(3) body2.foot_LH(3)],'--',...
%             [body1.foot_RH(1) body2.foot_RH(1)],[body1.foot_RH(2) body2.foot_RH(2)],[body1.foot_RH(3) body2.foot_RH(3)],'--',...
%             'linewidth',1.5);
        h_line = plot3([body1.spinemid(1) body2.spinemid(1)],[body1.spinemid(2) body2.spinemid(2)],[body1.spinemid(3) body2.spinemid(3)],'linewidth',1.5);
        color =  interp1(tmap,map,mean(t(i:(i+1))));
        set(h_line,'color',color);
    end
end

% 画运动过程中的肢体棍图
if (PLOT_Stick)
    h = figure(2);
    set(h,'pos',[350 250 850 380]);
    fontsize = 25;
    fontname = 'Times New Roman';
    
    map = colormap(jet);
    tmap = linspace(t(1),t(end),length(map))';
    hold on
    nframe = 5;
    tframe = linspace(t(1),t(end),nframe)';
    frame = round(linspace(1,length(t),nframe));
    j = 1;
    for i = frame
        body = get_body_i(i,data);
        color = interp1(tmap,map,tframe(j));
        PLOTStick(body,color)
        j = j+1;
    end

    if strcmp(OBS,'circle')
        PLOTcircle(body.obstacle(2,1), body.obstacle(2,3))
    else
        plot3(body.obstacle(:,1), body.obstacle(:,2), body.obstacle(:,3), 'linewidth', 10,'color', 'k') % 障碍物
    end
    view(0,0)
    axis equal
%     axis manual
    xlim(xlimit)
    zlim(zlimit)
    xlabel('X position [m]', 'Fontsize', fontsize, 'Fontname', fontname)
    ylabel('Y position [m]', 'Fontsize', fontsize, 'Fontname', fontname)
    zlabel('Z position [m]', 'Fontsize', fontsize, 'Fontname', fontname)
    set(gca, 'FontSize', fontsize)
    box on;
    % title('Body Motion', 'Fontsize', fontsize, 'Fontname', fontname)
    saveas(h, save_dir+'body motion '+motion_type+".svg")
    saveas(h, save_dir+'body motion '+motion_type+".emf")
end

%% 函数工具 ##############################################################################
% body——某一时刻的身体数据点
function PLOTStick(body,color)
        p1 = plot3([body.spinefront(1) body.spinemid(1)],[body.spinefront(2) body.spinemid(2)],[body.spinefront(3) body.spinemid(3)],...
            [body.spinemid(1) body.spineback(1)],[body.spinemid(2) body.spineback(2)],[body.spinemid(3) body.spineback(3)],...
            [body.spinefront(1) body.hip_LF(1)],[body.spinefront(2) body.hip_LF(2)],[body.spinefront(3) body.hip_LF(3)],...%左前腿
            [body.knee_LF(1) body.hip_LF(1)],[body.knee_LF(2) body.hip_LF(2)],[body.knee_LF(3) body.hip_LF(3)],...
            [body.knee_LF(1) body.ankle_LF(1)],[body.knee_LF(2) body.ankle_LF(2)],[body.knee_LF(3) body.ankle_LF(3)],...
            [body.foot_LF(1) body.ankle_LF(1)],[body.foot_LF(2) body.ankle_LF(2)],[body.foot_LF(3) body.ankle_LF(3)],...
            [body.spinefront(1) body.hip_RF(1)],[body.spinefront(2) body.hip_RF(2)],[body.spinefront(3) body.hip_RF(3)],...%右前腿
            [body.knee_RF(1) body.hip_RF(1)],[body.knee_RF(2) body.hip_RF(2)],[body.knee_RF(3) body.hip_RF(3)],...
            [body.knee_RF(1) body.ankle_RF(1)],[body.knee_RF(2) body.ankle_RF(2)],[body.knee_RF(3) body.ankle_RF(3)],...
            [body.foot_RF(1) body.ankle_RF(1)],[body.foot_RF(2) body.ankle_RF(2)],[body.foot_RF(3) body.ankle_RF(3)],...
            [body.spineback(1) body.hip_LH(1)],[body.spineback(2) body.hip_LH(2)],[body.spineback(3) body.hip_LH(3)],...%左后腿
            [body.knee_LH(1) body.hip_LH(1)],[body.knee_LH(2) body.hip_LH(2)],[body.knee_LH(3) body.hip_LH(3)],...
            [body.knee_LH(1) body.ankle_LH(1)],[body.knee_LH(2) body.ankle_LH(2)],[body.knee_LH(3) body.ankle_LH(3)],...
            [body.foot_LH(1) body.ankle_LH(1)],[body.foot_LH(2) body.ankle_LH(2)],[body.foot_LH(3) body.ankle_LH(3)],...
            [body.spineback(1) body.hip_RH(1)],[body.spineback(2) body.hip_RH(2)],[body.spineback(3) body.hip_RH(3)],...%左后腿
            [body.knee_RH(1) body.hip_RH(1)],[body.knee_RH(2) body.hip_RH(2)],[body.knee_RH(3) body.hip_RH(3)],...
            [body.knee_RH(1) body.ankle_RH(1)],[body.knee_RH(2) body.ankle_RH(2)],[body.knee_RH(3) body.ankle_RH(3)],...
            [body.foot_RH(1) body.ankle_RH(1)],[body.foot_RH(2) body.ankle_RH(2)],[body.foot_RH(3) body.ankle_RH(3)],...
            'Linewidth',2.5);
        set(p1,'color',color)
        p2 = plot3(body.foot_LF(1),body.foot_LF(2),body.foot_LF(3),'o',body.foot_RF(1),body.foot_RF(2),body.foot_RF(3),'o',...
               body.foot_LH(1),body.foot_LH(2),body.foot_LH(3),'o',body.foot_RH(1),body.foot_RH(2),body.foot_RH(3),'o');
       set(p2,'MarkerFaceColor',color,'MarkerSize',6,'MarkerEdgeColor',color)
end

%获取第i时刻的数据点
function body = get_body_i(i,data)
        body.t = data(i,1);
        % 太阳穴
        body.temple = data(i,92:94);
        % 前脊椎
        body.spinefront = data(i,95:97);
        % 中脊椎
        body.spinemid = data(i,98:100);
        % 后脊椎
        body.spineback = data(i,101:103);
        %尾巴
        body.tail_1 = data(i,104:106);
        body.tail_2 = data(i,107:109);
        % 左前腿
        body.hip_LF = data(i,14:16);
        body.knee_LF = data(i,17:19);
        body.ankle_LF = data(i,20:22);
        body.foot_LF = data(i,23:25);
        % 左后腿
        body.hip_LH = data(i,26:28);
        body.knee_LH = data(i,29:31);
        body.ankle_LH = data(i,32:34);
        body.foot_LH = data(i,35:37);
        % 右前腿
        body.hip_RF = data(i,56:58);
        body.knee_RF = data(i,59:61);
        body.ankle_RF = data(i,62:64);
        body.foot_RF = data(i,65:67);
        % 右后腿
        body.hip_RH = data(i,68:70);
        body.knee_RH = data(i,71:73);
        body.ankle_RH = data(i,74:76);
        body.foot_RH = data(i,77:79);
        %障碍物
        object1 = data(1,86:88); % 障碍物上沿中间点位置（XYZ）
        object2 = data(1,89:91); % 障碍物下沿中间点位置（XYZ）
        object1(:,1) = object2(:,1);
        object1(:,2) = object2(:,2);
        body.obstacle = [object1; object2];
end