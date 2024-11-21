clear; clc; close all;
detaT = 1/120;
addpath('../utilities');
save_dir = "../SaveFigure/"; % 保存路径
%% 5 low height jump 2
motion_type = "(5 low height jump 2)";
actionNum = 5;
raw_data = readmatrix('../Dog motion data/1 low hurdle/raw_data.csv');
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
%% 6 mid height jump 1
% motion_type = "(6 mid height jump 1)";
% raw_data = readmatrix('../Dog motion data/2 medium hurdle/raw_data.csv');
% actionNum = 6;
% n_data = 57; %数据完整的行数，再往后取数据不全
% angle = -pi/25; %将X轴转为奔跑的正方向要转动的角度，根据画出来的结果试出来的
% T.start = 2.658;
% T.end = 3.2;
% T.body = [-2 2.883 3.183 -3];
% %左前腿
% T.LF = [-2 2.708 2.792 3.183 -3];
% %右前腿
% T.RF = [-1 -2 2.742 -3];
% %左后腿
% T.LH = [-1 -2 2.692 2.8 2.883 -3];
% %右后腿
% T.RH = [-2 2.758 2.858 -3];
% OBS='1';
% xlimit = [-2.4 2.6];
% zlimit = [0 1];
% figuretitle = 'Medium Hurdle';
%% 7 high height jump 1
% motion_type = "(7 high height jump 1)";
% raw_data = readmatrix('../Dog motion data/3 high hurdle/raw_data.csv');
% actionNum = 7;
% n_data = 57; %数据完整的行数，再往后取数据不全
% angle = -pi/16; %将X轴转为奔跑的正方向要转动的角度，根据画出来的结果试出来的
% T.start = 2.583;
% T.end = 3.042;
% T.body = [-2 2.725 -3 -1];
% % 左前腿
% T.LF = [-1 -2 2.642 -3 -1];
% % 右前腿
% T.RF = [-1 -2 2.625 -3];
% % 左后腿
% T.LH = [-2 2.633 2.725 -3 -1 -1];
% % 右后腿
% T.RH = [-2 2.625 2.717 -3];
% OBS='1';
% xlimit = [-2.4 2.6];
% zlimit = [0 1.6];
% figuretitle = 'High Hurdle';
%% 8 ring jump 1 警犬穿越圆洞 高0.115m
% motion_type = "(ring jump 1)";
% raw_data = readmatrix('../Dog motion data/4 circular hole (takeoff)/raw_data.csv');
% actionNum = 8;
% n_data = 55;
% angle = -0.1915;
% T.start = 2.6;
% T.end = 3.05;
% T.body = [-2 2.767 -3 -1];
% % 左前腿
% T.LF = [-1 -2 2.65 -3 -1];
% % 右前腿
% T.RF = [-1 -2 2.683 -3];
% % 左后腿
% T.LH = [-2 2.683 2.767 -3 -1 -1];
% % 右后腿
% T.RH = [-2 2.667 2.758 -3];
% OBS='circle';
% xlimit = [-2.4 2.6];
% zlimit = [-0.07 1.9];
% figuretitle = 'Circular Hole (Takeoff)';
%% 9 ring jump 2
% motion_type = "(ring jump 2)";
% raw_data = readmatrix('../Dog motion data/5 circular hole (landing)/raw_data.csv');
% actionNum = 9;
% n_data = 45;
% angle = -0.1915;
% T.start = 2.517;
% T.end = 2.883;
% T.body = [-1 -2 2.75 -3];
% %左前腿
% T.LF = [-2 2.75 2.842 -3 -1];
% %右前腿
% T.RF = [-2 2.758 2.858 -3];
% %左后腿
% T.LH = [-2 -3 -1 -1 -1 -1];
% %右后腿
% T.RH = [-2 2.825 -3 -1];
% OBS='circle';
% xlimit = [-2.4 2.6];
% zlimit = [0 1.9];
% figuretitle = 'Circular Hole (Landing)';
%% 数据分类
data = data_rotate_ALL(raw_data,n_data,angle);
t = data(:,1);
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


%% 用atan2计算主要看有没有穿过x的负半轴，用acos计算的主要看方向对不对
%% calculate all angles
x_axis = [1;0;0];
%% temple-spinefront-X_axis
[theta_h,vector_h] = calculate_pitch_with_X(temple,spinefront);
[omega_h,alpha_h] = calculateVandA(theta_h,detaT);
% figure
% plot(theta_h,'Linewidth',2)

%% spinefront-spinemid-X_axis
[theta_sf,vector_sf] = calculate_pitch_with_X(spinefront,spinemid);
[omega_sf,alpha_sf] = calculateVandA(theta_sf,detaT);
% figure
% plot(theta_sf,'Linewidth',2)

%% spineback-spinemid-X_axis
% 穿过了x轴的负半轴，所以需要处理一下
[theta_sh,vector_sh] = calculate_pitch_with_X(spineback,spinemid);
switch motion_type
    case "(5 low height jump 2)"
    n1 = 4;
    n2 = 23;
    case "(6 mid height jump 1)"
    n1 = 13;
    n2 = 41;
    case "(7 high height jump 1)"
    n1 = 6;
    n2 = 57;
    case "(ring jump 1)"
    n1 = 9;
    n2 = 42;
    case "(ring jump 2)"
    n1 = 43;
    n2 = 47;
end
theta_sh(n1:n2) = theta_sh(n1:n2)-2*pi;
[omega_sh,alpha_sh] = calculateVandA(theta_sh,detaT);
% figure
% plot(theta_sh,'o','Linewidth',2)

%% spinefront-spineback-X_axis

[theta_b,vector_b] = calculate_pitch_with_X(spinefront,spineback);
[omega_b,alpha_b] = calculateVandA(theta_b,detaT);
% figure
% plot(theta_b,'o','Linewidth',2)

%% tail_1-spineback-X_axis
% 穿过了x轴的负半轴，所以需要处理一下
[theta_t0,vector_t0] = calculate_pitch_with_X(tail_1,spineback);
switch motion_type
    case "(5 low height jump 2)"
    n1 = 1;
    n2 = 28;
    case "(6 mid height jump 1)"
    n1 = 2;
    n2 = 47;
    case "(7 high height jump 1)"
    n1 = 1;
    n2 = 51;
    case "(ring jump 1)"
    n1 = 1;
    n2 = 48;
    case "(ring jump 2)"
    n1 = 40;
    n2 = 51;
end
theta_t0(n1:n2) = theta_t0(n1:n2)-2*pi;
[omega_t0,alpha_t0] = calculateVandA(theta_t0,detaT);
% figure
% plot(theta_t0,'o','Linewidth',2)

%% tail_2-tail_1-spineback
[theta_t1,vector_t1] = calculate_angle_with_2vector(tail_1,spineback,tail_2,tail_1);
% 根据画出来的曲线结合视频处理的
if motion_type=="(6 mid height jump 1)"
    theta_t1(27:57) = -theta_t1(27:57);
elseif motion_type=="(ring jump 1)"
    theta_t1(1) = -theta_t1(1);
elseif motion_type=="(ring jump 2)"
    theta_t1(1:13) = -theta_t1(1:13);
end 
switch motion_type
    case "(5 low height jump 2)"
    n1 = 17;
    n2 = 32;
    case "(6 mid height jump 1)"
    n1 = 1;
    n2 = 11;
    case "(7 high height jump 1)"
    n1 = 23;
    n2 = 57;
    case "(ring jump 1)"
    n1 = 26;
    n2 = 62;
    case "(ring jump 2)"
    n1 = 49;
    n2 = 51;
end
theta_t1(n1:n2) = -theta_t1(n1:n2);
[omega_t1,alpha_t1] = calculateVandA(theta_t1,detaT);
% figure
% plot(theta_t1,'o','Linewidth',2)
theta_spine = [theta_h theta_sf theta_sh theta_b theta_t0 theta_t1];
omega_spine = [omega_h omega_sf omega_sh omega_b omega_t0 omega_t1];
alpha_spine = [alpha_h alpha_sf alpha_sh alpha_b alpha_t0 alpha_t1];
h = figure('name','Spine Angle');
% h = figure('name','Spine Angle','Position',[1 49 1700 950]);
% h.Position(3:4) = [1000,500];
PLOTBodyAngle(theta_spine,t,T,'Spine angle [rad]',figuretitle)
% saveas(h, save_dir+"Spine Angle "+motion_type+".svg")
% saveas(h, save_dir+"Spine Angle "+motion_type+".emf")



% h = figure('name','Spine Angular Velocity');
% PLOTBodyAngle(omega_spine,t,T,'Spine angular velocity [rad/s]','Spine Angular Velocity')
% saveas(h, save_dir+"Spine Angular Velocity "+motion_type+".svg")
% saveas(h, save_dir+"Spine Angular Velocity "+motion_type+".emf")
% h = figure('name','Spine Angular Acceleration');
% PLOTBodyAngle(alpha_spine,t,T,'Spine angular acceleration [rad/s^2]','Spine Angular Acceleration')
% saveas(h, save_dir+"Spine Angular Acceleration "+motion_type+".svg")
% saveas(h, save_dir+"Spine Angular Acceleration "+motion_type+".emf")
%% 腿
%% foot-spinefront/spinehind-X_axis(virtual leg)
[theta_vir_leg_LF,vector_vir_leg_LF] = calculate_pitch_with_X(foot_LF,spinefront);
[omega_vir_leg_LF,alpha_vir_leg_LF] = calculateVandA(theta_vir_leg_LF,detaT);
% figure
% plot(theta_vir_leg_LF,'o','Linewidth',2)

[theta_vir_leg_RF,vector_vir_leg_RF] = calculate_pitch_with_X(foot_RF,spinefront);
[omega_vir_leg_RF,alpha_vir_leg_RF] = calculateVandA(theta_vir_leg_RF,detaT);
% figure
% plot(theta_vir_leg_RF,'o','Linewidth',2)

[theta_vir_leg_LH,vector_vir_leg_LH] = calculate_pitch_with_X(foot_LH,spineback);
[omega_vir_leg_LH,alpha_vir_leg_LH] = calculateVandA(theta_vir_leg_LH,detaT);
% figure
% plot(theta_vir_leg_LH,'o','Linewidth',2)

[theta_vir_leg_RH,vector_vir_leg_RH] = calculate_pitch_with_X(foot_RH,spineback);
[omega_vir_leg_RH,alpha_vir_leg_RH] = calculateVandA(theta_vir_leg_RH,detaT);
% figure
% plot(theta_vir_leg_RH,'o','Linewidth',2)

%% 左后腿
[theta_0_LH,vector_0_LH] = calculate_pitch_with_X(hip_LH,spineback);
if motion_type=="(ring jump 2)"
    theta_0_LH(21:24) = theta_0_LH(21:24)+2*pi;
end
[omega_0_LH,alpha_0_LH] = calculateVandA(theta_0_LH,detaT);
% figure
% plot(theta_0_LH,'o','Linewidth',2)

[theta_1_LH,vector1_1_LH,vector2_1_LH] = calculate_angle_with_2vector(hip_LH,spineback,knee_LH,hip_LH);
switch motion_type
    case "(5 low height jump 2)"
    n1 = 1;
    n2 = 57;
    case "(6 mid height jump 1)"
    n1 = 1;
    n2 = 57;
    case "(7 high height jump 1)"
    n1 = 1;
    n2 = 57;
    case "(ring jump 1)"
    n1 = 1;
    n2 = 62;
    case "(ring jump 2)"
    n1 = 1;
    n2 = 51;
end
theta_1_LH(n1:n2) = -theta_1_LH(n1:n2);
[omega_1_LH,alpha_1_LH] = calculateVandA(theta_1_LH,detaT);
% figure
% plot(theta_1_LH,'o','Linewidth',2)

[theta_2_LH,vector1_2_LH,vector2_2_LH] = calculate_angle_with_2vector(knee_LH,hip_LH,ankle_LH,knee_LH);
[omega_2_LH,alpha_2_LH] = calculateVandA(theta_2_LH,detaT);
% figure
% plot(theta_2_LH,'o','Linewidth',2)

[theta_3_LH,vector1_3_LH,vector2_3_LH] = calculate_angle_with_2vector(ankle_LH,knee_LH,foot_LH,ankle_LH);
switch motion_type
    case "(5 low height jump 2)"
    n1 = 1;
    n2 = 57;
    case "(6 mid height jump 1)"
    n1 = 1;
    n2 = 57;
    case "(7 high height jump 1)"
    n1 = 1;
    n2 = 57;
    case "(ring jump 1)"
    n1 = 1;
    n2 = 62;
    case "(ring jump 2)"
    n1 = 1;
    n2 = 51;
end
theta_3_LH(n1:n2) = -theta_3_LH(n1:n2);
[omega_3_LH,alpha_3_LH] = calculateVandA(theta_3_LH,detaT);
% figure
% plot(theta_3_LH,'o','Linewidth',2)
theta_LH = [theta_0_LH theta_1_LH theta_2_LH theta_3_LH theta_vir_leg_LH];
omega_LH = [omega_0_LH,omega_1_LH,omega_2_LH,omega_3_LH omega_vir_leg_LH];
alpha_LH = [alpha_0_LH,alpha_1_LH,alpha_2_LH,alpha_3_LH alpha_vir_leg_LH];
h = figure('name','LH Joint Angle');
PLOTlegAngle(theta_LH,t,T,'Joint angle [rad]','LH Joint Angle','LH')
% saveas(h, save_dir+"LH Joint Angle "+motion_type+".svg")
% saveas(h, save_dir+"LH Joint Angle "+motion_type+".emf")



% h = figure('name','LH Joint Angular Velocity');
% PLOTlegAngle(omega_LH,t,T,'Joint angular velocity [rad/s]','LH Joint Angular Velocity','LH')
% saveas(h, save_dir+"LH Joint Angular Velocity "+motion_type+".svg")
% saveas(h, save_dir+"LH Joint Angular Velocity "+motion_type+".emf")
% h = figure('name','LH Joint Angular Acceleration');
% PLOTlegAngle(alpha_LH,t,T,'Joint angular acceleration [rad/s^2]','LH Joint Angular Acceleration','LH')
% saveas(h, save_dir+"LH Joint Angular Acceleration "+motion_type+".svg")
% saveas(h, save_dir+"LH Joint Angular Acceleration "+motion_type+".emf")
%% 右后腿
[theta_0_RH,vector_0_RH] = calculate_pitch_with_X(hip_RH,spineback);
if motion_type ~= "(7 high height jump 1)"
    if motion_type ~= "(ring jump 2)"
        switch motion_type
            case "(5 low height jump 2)"
            n1 = 36;
            n2 = 52;
            case "(6 mid height jump 1)"
            n1 = 52;
            n2 = 57;
            case "(ring jump 1)"
            n1 = 60;
            n2 = 62;
        end
        theta_0_RH(n1:n2) = theta_0_RH(n1:n2)+2*pi;
    end
end
[omega_0_RH,alpha_0_RH] = calculateVandA(theta_0_RH,detaT);
% figure
% plot(theta_0_RH,'o','Linewidth',2)

[theta_1_RH,vector1_1_RH,vector2_1_RH] = calculate_angle_with_2vector(hip_RH,spineback,knee_RH,hip_RH);
switch motion_type
    case "(5 low height jump 2)"
    n1 = 1;
    n2 = 57;
    case "(6 mid height jump 1)"
    n1 = 1;
    n2 = 57;
    case "(7 high height jump 1)"
    n1 = 1;
    n2 = 57;
    case "(ring jump 1)"
    n1 = 1;
    n2 = 62;
    case "(ring jump 2)"
    n1 = 1;
    n2 = 51;
end
theta_1_RH(n1:n2) = -theta_1_RH(n1:n2);
[omega_1_RH,alpha_1_RH] = calculateVandA(theta_1_RH,detaT);
% figure
% plot(theta_1_RH,'o','Linewidth',2)

[theta_2_RH,vector1_2_RH,vector2_2_RH] = calculate_angle_with_2vector(knee_RH,hip_RH,ankle_RH,knee_RH);
[omega_2_RH,alpha_2_RH] = calculateVandA(theta_2_RH,detaT);
% figure
% plot(theta_2_RH,'o','Linewidth',2)

[theta_3_RH,vector1_3_RH,vector2_3_RH] = calculate_angle_with_2vector(ankle_RH,knee_RH,foot_RH,ankle_RH);
switch motion_type
    case "(5 low height jump 2)"
    n1 = 1;
    n2 = 57;
    case "(6 mid height jump 1)"
    n1 = 1;
    n2 = 57;
    case "(7 high height jump 1)"
    n1 = 1;
    n2 = 57;
    case "(ring jump 1)"
    n1 = 1;
    n2 = 62;
    case "(ring jump 2)"
    n1 = 1;
    n2 = 51;
end
theta_3_RH(n1:n2) = -theta_3_RH(n1:n2);
[omega_3_RH,alpha_3_RH] = calculateVandA(theta_3_RH,detaT);
% figure
% plot(theta_3_RH,'o','Linewidth',2)
theta_RH = [theta_0_RH theta_1_RH theta_2_RH theta_3_RH theta_vir_leg_RH];
omega_RH = [omega_0_RH,omega_1_RH,omega_2_RH,omega_3_RH omega_vir_leg_RH];
alpha_RH = [alpha_0_RH,alpha_1_RH,alpha_2_RH,alpha_3_RH alpha_vir_leg_RH];
h = figure('name','RH Joint Angle');
PLOTlegAngle(theta_RH,t,T,'Joint angle [rad]','RH Joint Angle','RH')
% saveas(h, save_dir+"RH Joint Angle "+motion_type+".svg")
% saveas(h, save_dir+"RH Joint Angle "+motion_type+".emf")
% h = figure('name','RH Joint Angular Velocity');
% PLOTlegAngle(omega_RH,t,T,'Joint angular velocity [rad/s]','RH Joint Angular Velocity','RH')
% saveas(h, save_dir+"RH Joint Angular Velocity "+motion_type+".svg")
% saveas(h, save_dir+"RH Joint Angular Velocity "+motion_type+".emf")
% h = figure('name','RH Joint Angular Acceleration');
% PLOTlegAngle(alpha_RH,t,T,'Joint angular acceleration [rad/s^2]','RH Joint Angular Acceleration','RH')
% saveas(h, save_dir+"RH Joint Angular Acceleration "+motion_type+".svg")
% saveas(h, save_dir+"RH Joint Angular Acceleration "+motion_type+".emf")
%% 左前腿
[theta_0_LF,vector_0_LF] = calculate_pitch_with_X(hip_LF,spinefront);
[omega_0_LF,alpha_0_LF] = calculateVandA(theta_0_LF,detaT);
% figure
% plot(theta_0_LF,'o','Linewidth',2)

[theta_1_LF,vector1_1_LF,vector2_1_LF] = calculate_angle_with_2vector(hip_LF,spinefront,knee_LF,hip_LF);
[omega_1_LF,alpha_1_LF] = calculateVandA(theta_1_LF,detaT);
% figure
% plot(theta_1_LF,'o','Linewidth',2)

[theta_2_LF,vector1_2_LF,vector2_2_LF] = calculate_angle_with_2vector(knee_LF,hip_LF,ankle_LF,knee_LF);
switch motion_type
    case "(5 low height jump 2)"
    n1 = 1;
    n2 = 57;
    case "(6 mid height jump 1)"
    n1 = 1;
    n2 = 57;
    case "(7 high height jump 1)"
    n1 = 1;
    n2 = 57;
    case "(ring jump 1)"
    n1 = 1;
    n2 = 62;
    case "(ring jump 2)"
    n1 = 1;
    n2 = 51;
end
theta_2_LF(n1:n2) = -theta_2_LF(n1:n2);
[omega_2_LF,alpha_2_LF] = calculateVandA(theta_2_LF,detaT);
% figure
% plot(theta_2_LF,'o','Linewidth',2)

[theta_3_LF,vector1_3_LF,vector2_3_LF] = calculate_angle_with_2vector(ankle_LF,knee_LF,foot_LF,ankle_LF);
if motion_type=="(5 low height jump 2)"
    theta_3_LF(1) = -theta_3_LF(1);
end
switch motion_type
    case "(5 low height jump 2)"
    n1 = 37;
    n2 = 57;
    case "(6 mid height jump 1)"
    n1 = 5;
    n2 = 13;
    case "(7 high height jump 1)"
    n1 = 1;
    n2 = 7;
    case "(ring jump 1)"
    n1 = 1;
    n2 = 6;
    case "(ring jump 2)"
    n1 = 26;
    n2 = 39;
end
theta_3_LF(n1:n2) = -theta_3_LF(n1:n2);
[omega_3_LF,alpha_3_LF] = calculateVandA(theta_3_LF,detaT);
% figure
% plot(theta_3_LF,'o','Linewidth',2)
theta_LF = [theta_0_LF theta_1_LF theta_2_LF theta_3_LF theta_vir_leg_LF];
omega_LF = [omega_0_LF,omega_1_LF,omega_2_LF,omega_3_LF omega_vir_leg_LF];
alpha_LF = [alpha_0_LF,alpha_1_LF,alpha_2_LF,alpha_3_LF alpha_vir_leg_LF];
h = figure('name','LF joint angle');
PLOTlegAngle(theta_LF,t,T,'Joint angle [rad]','LF Joint Angle','LF')
% saveas(h, save_dir+"LF Joint Angle "+motion_type+".svg")
% saveas(h, save_dir+"LF Joint Angle "+motion_type+".emf")
% h = figure('name','LF Joint Angular Velocity');
% PLOTlegAngle(omega_LF,t,T,'Joint angular velocity [rad/s]','LF Joint Angular Velocity','LF')
% saveas(h, save_dir+"LF Joint Angular Velocity "+motion_type+".svg")
% saveas(h, save_dir+"LF Joint Angular Velocity "+motion_type+".emf")
% h = figure('name','LF Joint Angular Acceleration');
% PLOTlegAngle(alpha_LF,t,T,'Joint angular acceleration [rad/s^2]','LF Joint Angular Acceleration','LF')
% saveas(h, save_dir+"LF Joint Angular Acceleration "+motion_type+".svg")
% saveas(h, save_dir+"LF Joint Angular Acceleration "+motion_type+".emf")
%% 右前腿
[theta_0_RF,vector_0_RF] = calculate_pitch_with_X(hip_RF,spinefront);
[omega_0_RF,alpha_0_RF] = calculateVandA(theta_0_RF,detaT);
% figure
% plot(theta_0_RF,'o','Linewidth',2)

[theta_1_RF,vector1_1_RF,vector2_1_RF] = calculate_angle_with_2vector(hip_RF,spinefront,knee_RF,hip_RF);
[omega_1_RF,alpha_1_RF] = calculateVandA(theta_1_RF,detaT);
% figure
% plot(theta_1_RF,'o','Linewidth',2)

[theta_2_RF,vector1_2_RF,vector2_2_RF] = calculate_angle_with_2vector(knee_RF,hip_RF,ankle_RF,knee_RF);
switch motion_type
    case "(5 low height jump 2)"
    n1 = 1;
    n2 = 57;
    case "(6 mid height jump 1)"
    n1 = 1;
    n2 = 57;
    case "(7 high height jump 1)"
    n1 = 1;
    n2 = 57;
    case "(ring jump 1)"
    n1 = 1;
    n2 = 62;
    case "(ring jump 2)"
    n1 = 1;
    n2 = 51;
end
theta_2_RF(n1:n2) = -theta_2_RF(n1:n2);
[omega_2_RF,alpha_2_RF] = calculateVandA(theta_2_RF,detaT);
% figure
% plot(theta_2_RF,'o','Linewidth',2)

[theta_3_RF,vector1_3_RF,vector2_3_RF] = calculate_angle_with_2vector(ankle_RF,knee_RF,foot_RF,ankle_RF);
if motion_type =="(6 mid height jump 1)"
    n1 = 1;
    n2 = 6;
    theta_3_RF(n1:n2) = -theta_3_RF(n1:n2);
elseif motion_type =="(7 high height jump 1)"
    n1 = 1;
    n2 = 5;
    theta_3_RF(n1:n2) = -theta_3_RF(n1:n2);    
elseif motion_type =="(ring jump 1)"
    n1 = 1;
    n2 = 8;
    theta_3_RF(n1:n2) = -theta_3_RF(n1:n2); 
elseif motion_type =="(ring jump 2)"
    n1 = 29;
    n2 = 40;
    theta_3_RF(n1:n2) = -theta_3_RF(n1:n2);    
end
% figure
% plot(t,theta_3_RF,'Linewidth',2)
[omega_3_RF,alpha_3_RF] = calculateVandA(theta_3_RF,detaT);

theta_RF = [theta_0_RF theta_1_RF theta_2_RF theta_3_RF theta_vir_leg_RF];
omega_RF = [omega_0_RF,omega_1_RF,omega_2_RF,omega_3_RF omega_vir_leg_RF];
alpha_RF = [alpha_0_RF,alpha_1_RF,alpha_2_RF,alpha_3_RF alpha_vir_leg_RF];
h = figure('name','RF Joint Angle');
PLOTlegAngle(theta_RF,t,T,'Joint angle [rad]','RF Joint Angle','RF')
% saveas(h, save_dir+"RF Joint Angle "+motion_type+".svg")
% saveas(h, save_dir+"RF Joint Angle "+motion_type+".emf")
% h = figure('name','RF Joint Angular Velocity');
% PLOTlegAngle(omega_RF,t,T,'Joint angular velocity [rad/s]','RF Joint Angular Velocity','RF')
% saveas(h, save_dir+"RF Joint Angular Velocity "+motion_type+".svg")
% saveas(h, save_dir+"RF Joint Angular Velocity "+motion_type+".emf")
% h = figure('name','RF Joint Angular Acceleration');
% PLOTlegAngle(alpha_RF,t,T,'Joint angular acceleration [rad/s^2]','RF Joint Angular Acceleration','RF')
% saveas(h, save_dir+"RF Joint Angular Acceleration "+motion_type+".svg")
% saveas(h, save_dir+"RF Joint Angular Acceleration "+motion_type+".emf")



%% function
function PLOTline(vector0,vector)
    h = figure;
    n = size(vector,1);
    color = colormap(jet(n));  % n 是要用的颜色数量
    for i = 1:n
        plot([vector0(i,1) 0],[vector0(i,3) 0],'color',color(i,:),'Linewidth',2)
        hold on
        plot([vector(i,1)+vector0(i,1) vector0(i,1)],[vector(i,3)+vector0(i,3) vector0(i,3)],'color',color(i,:),'Linewidth',2)
        drawnow 
        frame = getframe(h);
%         im{i} = frame2im(frame);
    end
    xlabel('X')
    ylabel('Z')
end 

function [theta,vector] = calculate_pitch_with_X(point1,point2)
    vector = point1-point2;
    n_data = size(vector,1);
    for i = 1:n_data
        %这里有负号是因为在xy平面与xz平面内方向不同
        theta(i,1) = -atan2(vector(i,3),vector(i,1));
    end
    vector0 = repmat([0.35,0,0],n_data,1);
%     PLOTline(vector0,vector)
end

function [theta,vector1,vector2] = calculate_angle_with_2vector(point1,point2,point3,point4)
    vector1 = point1-point2;
    n_data = size(vector1,1);
    vector1(:,2) = zeros(n_data,1);
    vector2 = point3-point4;
    vector2(:,2) = zeros(n_data,1);
    for i = 1:n_data
        theta(i,1) = acos(dot(vector1(i,:),vector2(i,:))/(norm(vector1(i,:))*norm(vector2(i,:))));
    end
%     PLOTline(vector1,vector2)
end

%画腿的角度,包含背景5 low height jump 2
%输入：data——n*4，包含四个角度
%      T————左前腿的触地时间，离地时间
%      t————n*1 时间序列
%      ylabelname——字符串：y标签
%      titlename——字符串：标题
%      witchleg——字符串：哪一条狗腿LF,LH,RF,RH
%      witchaction---动作文件夹前的数字
function PLOTlegAngle(data,t,T,ylabelname,titlename,witchleg)
        n = size(data,1);
        plot(t(1:n),data(:,1),'-o', t(1:n),data(:,2),'-s',t(1:n),data(:,3),'-x',t(1:n),data(:,4),'-p',...
                t(1:n),data(:,5),'-^', 'linewidth',2,'MarkerSize' ,5);
%         grid on
        axis manual
        ylim_values = ylim;
        xlim_values = xlim;
        legend('$\theta_0$','$\theta_1$','$\theta_2$','$\theta_3$','$\theta_{\rm vir}$'...
                ,'Interpreter','latex','Fontsize',12,'Location','northwest','Orientation','horizontal','AutoUpdate','off')
        legend('boxoff');
        xlabel('Time [s]','Fontsize',12,'Fontname','Times New Roman')
        ylabel(ylabelname,'Fontsize',12,'Fontname','Times New Roman')
        title(titlename,'Fontsize',12,'Fontname','Times New Roman')
        switch witchleg
            case 'LF'
                PLOTLegBackground(T.LF,xlim_values,ylim_values)
            case 'RF'
                PLOTLegBackground(T.RF,xlim_values,ylim_values)
            case 'LH'
                PLOTLegBackground(T.LH,xlim_values,ylim_values)
            case 'RH'
                PLOTLegBackground(T.RH,xlim_values,ylim_values)
        end      
end

%画躯干的角度,包含背景，主要是画背景 5 low height jump 2
%输入：data——n*4，包含四个角度
%      T————左前腿的触地时间，离地时间
%      t————n*1 时间序列
%      ylabelname——字符串：y标签
%      titlename——字符串：标题
%      witchaction---动作文件夹前的数字
function PLOTBodyAngle(data,t,T,ylabelname,titlename)
        n = size(data,1);
        plot(t(1:n),data(:,1),'-o', t(1:n),data(:,2),'-s',t(1:n),data(:,3),'-x',t(1:n),data(:,4),'-p',...
                t(1:n),data(:,5),'-^',t(1:n),data(:,6),'k-|', 'linewidth',2,'MarkerSize' ,5);
%         grid on
        legend('$\theta_{\rm h}$','$\theta_{\rm sf}$','$\theta_{\rm sh}$','$\theta_{\rm b}$','$\theta_{\rm t0}$','$\theta_{\rm t1}$',...
                'Interpreter','latex','Fontsize',12,'Location','northwest','Orientation','horizontal','AutoUpdate','off')
%         legend('$\theta_{\rm h}$','$\theta_{\rm sf}$','$\theta_{\rm sh}$','$\theta_{\rm t0}$','$\theta_{\rm t1}$',...
%                 'Interpreter','latex','Fontsize',12,'AutoUpdate','off')
        legend('boxoff');
        xlabel('Time [s]','Fontsize',12,'Fontname','Times New Roman')
        ylabel(ylabelname,'Fontsize',12,'Fontname','Times New Roman')
        title(titlename,'Fontsize',12,'Fontname','Times New Roman')
        axis manual
        ylim_values = ylim;
        xlim_values = xlim;
        PLOTBodyBackground(T.body,xlim_values,ylim_values)
end

%画单腿的背景
%输入：T——包含触地结束（腾空开始）、腾空结束（触地开始）、触地开始（腾空开始）、腾空结束（触地开始）时刻数据，
%            并且一直按照这个顺序输入。没有的数据就用-1表示
%      X——要画的图的x方向的数值，一般是xlim_values
%      Y——要画的图的y方向的数值，一般是ylim_values
function PLOTLegBackground(T,X,Y)
        n = length(T);
        for i = 1:n
            if T(i)==-2
               T(i) = X(1);
               start = i;
            end
            if T(i)==-3
               T(i) = X(2);
               terminal = i; 
            end            
        end   

        for k = start:terminal-1
            x = [T(k) T(k+1) T(k+1) T(k)];
            y = [Y(1), Y(1), Y(2), Y(2)];
            if mod(k,2)==0
                patch(x,y,[246, 83, 20]/255,'FaceAlpha',.15,'LineStyle' ,'none');
                text((x(1)+x(2))/2,y(1)+(y(3)-y(1))/18,'ST','Fontsize',12,'fontname','Times','HorizontalAlignment','center')
                %takeoff stance phase
            else
                patch(x,y,[0, 161, 241]/255,'FaceAlpha',.15,'LineStyle' ,'none');
                text((x(1)+x(2))/2,y(1)+(y(3)-y(1))/18,'SW','Fontsize',12,'fontname','Times','HorizontalAlignment','center') 
                % flight swing phase
            end
        end
end

%画机身的背景 起跳、腾空、落地
%输入：T——包含起跳开始、触地结束（腾空开始）、腾空结束（触地开始）、触地开始（腾空开始）、腾空结束（触地开始）时刻数据，
%            并且一直按照这个顺序输入。没有的数据就用-1表示
%      X——要画的图的x方向的数值，一般是xlim_values
%      Y——要画的图的y方向的数值，一般是ylim_values
function PLOTBodyBackground(T,X,Y)
        n = length(T);
        for i = 1:n
            if T(i)==-2
               T(i) = X(1);
               start = i;
            end
            if T(i)==-3
               T(i) = X(2);
               terminal = i; 
            end            
        end   
        for k = start:terminal-1
            x = [T(k) T(k+1) T(k+1) T(k)];
            y = [Y(1), Y(1), Y(2), Y(2)];
            if k==1
                patch(x,y,[246, 83, 20]/255,'FaceAlpha',.15,'LineStyle' ,'none');
                text((x(1)+x(2))/2,y(1)+(y(3)-y(1))/18,'Takeoff Phase','Fontsize',12,'fontname','Times','HorizontalAlignment','center') %Takeoff Phase
            elseif k==2
                patch(x,y,[0, 161, 241]/255,'FaceAlpha',.15,'LineStyle' ,'none');
                text((x(1)+x(2))/2,y(1)+(y(3)-y(1))/18,'Flight Phase','Fontsize',12,'fontname','Times','HorizontalAlignment','center') %Flight Phase
            elseif k==3
                patch(x,y,[255, 187, 0]/255,'FaceAlpha',.15,'LineStyle' ,'none');
                text((x(1)+x(2))/2,y(1)+(y(3)-y(1))/18,'Landing Phase','Fontsize',12,'fontname','Times','HorizontalAlignment','center') %Landing Phase
            end  
        end   
end


