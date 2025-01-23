% 画虚拟腿长/速度/加速度曲线 虚拟腿与x轴的摆动角度/速度/加速度 且保存了相关数据
clear,clc;close all;
addpath('../utilities');
save_dir = "./SaveFigure/virtual_leg/"; % 保存路径
if ~exist(save_dir, 'dir')
    mkdir(save_dir);
end

% 控制画哪些图
PLOT_Leg_l = 0; % 画虚拟腿长
PLOT_Leg_j = 1; % 画虚拟腿关节角度
motion_type = "(5 low height jump 2)";
% motion_type = "(6 mid height jump 1)";
motion_type = "(7 high height jump 1)";
% motion_type = "(ring jump 1)"; % 警犬穿越圆洞 圆心高0.115m
% motion_type = "(ring jump 2)";

detaT = 1/120;

%% 数据导入：腿和髋部顺序是左前（2：4）右前（5：7）左后（8：10）右后（11：13）
if (motion_type == "(5 low height jump 2)")
    actionNum = 5;
    raw_data = readmatrix('../../raw_data/1 low hurdle/raw_data.csv');
    n_data = 57; %数据完整的行数，再往后取数据不全
    angle = 31*pi/60; %将X轴转为奔跑的正方向要转动的角度，根据画出来的结果试出来的
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
    xlimit = [-2.4 2.6];
    zlimit = [0 1];
    figuretitle = 'Low Hurdle';
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
    xlimit = [-2.4 2.6];
    zlimit = [0 1];
    figuretitle = 'Medium Hurdle';
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
    xlimit = [-2.4 2.6];
    zlimit = [0 1.6];
    figuretitle = 'High Hurdle';
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
    xlimit = [-2.4 2.6];
    zlimit = [-0.07 1.9];
    figuretitle = 'Circular Hole (Takeoff)';
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
    xlimit = [-2.4 2.6];
    zlimit = [0 1.9];
    figuretitle = 'Circular Hole (Landing)';
end

%% 处理数据 时间间隔为1/120s ########################################################
% 旋转
[FOOT,t,HIP,~] = data_rotate(raw_data,n_data,angle);
%% 计算虚拟腿长、速度、加速度
% 左前腿
[legLengthLF,legVelocityLF,legAccelerationLF] = calculateVirtualLeg(FOOT(:,1:3),HIP(:,1:3),detaT);
% 右前腿
[legLengthRF,legVelocityRF,legAccelerationRF] = calculateVirtualLeg(FOOT(:,4:6),HIP(:,4:6),detaT);
% 左后腿
[legLengthLH,legVelocityLH,legAccelerationLH] = calculateVirtualLeg(FOOT(:,7:9),HIP(:,7:9),detaT);
% 右后腿
[legLengthRH,legVelocityRH,legAccelerationRH] = calculateVirtualLeg(FOOT(:,10:12),HIP(:,10:12),detaT);

%% 计算虚拟腿角度，角速度，角加速度，腿与x轴的夹角
% 左前腿
[legAngleLF,legAngularVelocityLF,legAngularAccelerationLF] = calculateVirtualLegAngle(FOOT(:,1:3),HIP(:,1:3),detaT);
% 右前腿
[legAngleRF,legAngularVelocityRF,legAngularAccelerationRF] = calculateVirtualLegAngle(FOOT(:,4:6),HIP(:,4:6),detaT);
% 左后腿
[legAngleLH,legAngularVelocityLH,legAngularAccelerationLH] = calculateVirtualLegAngle(FOOT(:,7:9),HIP(:,7:9),detaT);
% 右后腿
[legAngleRH,legAngularVelocityRH,legAngularAccelerationRH] = calculateVirtualLegAngle(FOOT(:,10:12),HIP(:,10:12),detaT);

%% 画图 ##############################################################################
if (PLOT_Leg_l)
    %% 腿部长度
    h = figure('name','virtual leg Length');
    legLength = [legLengthLF legLengthRF legLengthLH legLengthRH];
    PLOTwithLeg(T, t, legLength, figuretitle,'Virtual leg length [m]');
    saveas(h, save_dir+"virtual leg Length "+motion_type+".svg")
    saveas(h, save_dir+"virtual leg Length "+motion_type+".emf")
    legLength = [t legLength];
    % writematrix(legLength,save_dir+"virtual leg Length "+motion_type+".csv");

    %% 腿部速度
    % h = figure('name','virtual leg Velocity');
    % legVelocity = [legVelocityLF legVelocityRF legVelocityLH legVelocityRH];
    % PLOTwithLeg(T,t, legVelocity, 'Virtual Leg Velocity','Virtual leg velocity [m/s]');
    % saveas(h, save_dir+"virtual leg Velocity "+motion_type+".svg")
    % saveas(h, save_dir+"virtual leg Velocity "+motion_type+".emf")
    % legVelocity = [t(1:end-1) legVelocity];
    % writematrix(legVelocity,save_dir+"virtual leg Velocity "+motion_type+".csv");

    %% 腿部加速度
    % h = figure('name','leg Acceleration');
    % legAcceleration = [legAccelerationLF legAccelerationRF legAccelerationLH legAccelerationRH];
    % PLOTwithLeg(T,t, legAcceleration, 'Virtual Leg Acceleration','Virtual leg acceleration [m/s^2]');
    % saveas(h, save_dir+"leg Acceleration "+motion_type+".svg")
    % saveas(h, save_dir+"leg Acceleration "+motion_type+".emf")
    % legAcceleration = [t(1:end-2) legAcceleration];
    % writematrix(legAcceleration,save_dir+"leg Acceleration"+motion_type+".csv");
end

%% 左前腿棍图 看起来和视频对不上，因为视频的时长比较长
% h = figure('name','virtual leg LF stick view');
% for i = 1:n
% line([FOOT(i,1) HIP(i,1)],[FOOT(i,2) HIP(i,2)],[FOOT(i,3) HIP(i,3)],'lineWidth',1.5)
% hold on
% end
% view(0,0)
% xlabel('x [m]','Fontsize',12,'Fontname','Times New Roman')
% zlabel('z [m]','Fontsize',12,'Fontname','Times New Roman')
% title('virtual leg LF stick view','Fontsize',12,'Fontname','Times New Roman')
% saveas(h, save_dir+"virtual leg LF stick view "+motion_type+".svg")
% saveas(h, save_dir+"virtual leg LF stick view "+motion_type+".emf")

if(PLOT_Leg_j)
    %% 腿部角度
    h = figure('name','virtual leg Pitch Angle');
    legAngle = [legAngleLF legAngleRF legAngleLH legAngleRH];
    PLOTwithLeg(T,t, legAngle, figuretitle,'Virtual leg angle [rad]');
    saveas(h, save_dir+"virtual leg angle "+motion_type+".svg")
    saveas(h, save_dir+"virtual leg angle "+motion_type+".emf")
    legAngle = [t legAngle];
    % writematrix(legAngle,save_dir+"virtual leg angle "+motion_type+".csv");

    %% 角速度
    % h = figure('name','virtual leg Pitch Angular Velocity');
    % legAngularVelocity = [legAngularVelocityLF legAngularVelocityRF legAngularVelocityLH legAngularVelocityRH];
    % PLOTwithLeg(T,t, legAngularVelocity, 'Virtual Leg Angular Velocity','Virtual leg pitch angular velocity [rad/s]');
    % saveas(h, save_dir+"virtual leg angular velocity "+motion_type+".svg")
    % saveas(h, save_dir+"virtual leg angular velocity "+motion_type+".emf")
    % legAngularVelocity = [t(1:end-1) legAngularVelocity];
    % writematrix(legAngularVelocity,save_dir+"virtual leg angular velocity"+motion_type+".csv");

    %% 角加速度
    % h = figure('name','virtual leg Pitch Angular Acceleration');
    % legAngularAcceleration = [legAngularAccelerationLF legAngularAccelerationRF legAngularAccelerationLH legAngularAccelerationRH];
    % PLOTwithLeg(T,t, legAngularAcceleration, 'Virtual Leg Angular Acceleration','Virtual leg pitch angular acceleration [rad/s^2]');
    % saveas(h, save_dir+"virtual leg angular acceleration "+motion_type+".svg")
    % saveas(h, save_dir+"virtual leg angular acceleration "+motion_type+".emf")
    % legAngularAcceleration = [t(1:end-2) legAngularAcceleration];
    % writematrix(legAngularAcceleration,save_dir+"virtual leg angular acceleration "+motion_type+".csv");
end
