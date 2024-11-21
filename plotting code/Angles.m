%这个文件是计算脊柱
%虚拟腿与x轴的摆动角度/速度/加速度
%且保存了相关数据
clear,clc;close all;
addpath(genpath('../utilities'));
save_dir = "./SaveFigure/Angle/"; % 保存路径
detaT = 1/120;
%% 数据导入：腿和髋部顺序是左前（2：4）右前（5：7）左后（8：10）右后（11：13）
%% 1 low jump 1 
% motion_type = "(1 low jump 1)";
% raw_data = readmatrix('../Dog motion data/1 low hurdle/angles.csv');
% n = 57; %数据完整的行数，再往后取数据不全
% angle = 31*pi/60; %将X轴转为奔跑的正方向要转动的角度，根据画出来的结果试出来的
%% 5 low height jump 2
% motion_type = "(5 low height jump 2)";
% raw_data = readmatrix('../Dog motion data/1 low hurdle/angles.csv');
% n = 57; %数据完整的行数，再往后取数据不全
% angle = 31*pi/60; %将X轴转为奔跑的正方向要转动的角度，根据画出来的结果试出来的
%% 6 mid height jump 1
% motion_type = "(6 mid height jump 1)";
% raw_data = readmatrix('../Dog motion data/2 medium hurdle/angles.csv');
% n = 57; %数据完整的行数，再往后取数据不全
% angle = -pi/25; %将X轴转为奔跑的正方向要转动的角度，根据画出来的结果试出来的
%% 7 high height jump 1
% motion_type = "(7 high height jump 1)";
% raw_data = readmatrix('../Dog motion data/3 high hurdle/angles.csv');
% n = 57; %数据完整的行数，再往后取数据不全
% angle = -pi/16; %将X轴转为奔跑的正方向要转动的角度，根据画出来的结果试出来的
%% 8 ring jump 1
% motion_type = "(8 ring jump 1)";
% raw_data = readmatrix('../Dog motion data/4 circular hole (takeoff)/angles.csv');
% n = 57; %数据完整的行数，再往后取数据不全
% angle = -pi/20; %将X轴转为奔跑的正方向要转动的角度，根据画出来的结果试出来的
%% 9 ring jump 2
motion_type = "(9 ring jump 2)";
raw_data = readmatrix('../Dog motion data/5 circular hole (landing)/angles.csv');
n = 57; %数据完整的行数，再往后取数据不全
angle = -pi/20; %将X轴转为奔跑的正方向要转动的角度，根据画出来的结果试出来的
%% 处理数据 时间间隔为1/120s
t = raw_data(:,1);
SpineAngle = raw_data(:,39);
[SpineAngleV,SpineAngleA] = caculateVandA(SpineAngle,detaT);
%% 画图
%% 脊柱角度
h = figure('name','spine Angle');
PLOTwithSpineAngle(t, SpineAngle, 'spine Angle','spine Angle[rad]');
saveas(h, save_dir+"spine Angle"+motion_type+".svg")
saveas(h, save_dir+"spine Angle"+motion_type+".emf")
%% 脊柱角速度
h = figure('name','spine AngularVelocity');
PLOTwithSpineAngle(t, SpineAngleV, 'spine AngularVelocity','spine AngularVelocity[rad/s]');
saveas(h, save_dir+"spine AngularVelocity"+motion_type+".svg")
saveas(h, save_dir+"spine AngularVelocity"+motion_type+".emf")
%% 脊柱加速度
h = figure('name','spine Angular Acceleration');
PLOTwithSpineAngle(t, SpineAngleA, 'spine Angular Acceleration','spine Angular Acceleration[rad/s^2]');
saveas(h, save_dir+"spine Angular Acceleration"+motion_type+".svg")
saveas(h, save_dir+"spine Angular Acceleration"+motion_type+".emf")

%% 腿关节角度
%% 髋关节角角度（脊-髋-膝关节）
h = figure('name','hip Angle');
hipAngle = [raw_data(:,2) raw_data(:,11) raw_data(:,20) raw_data(:,29)];
PLOTwithLeg(t, hipAngle, 'hip Angle','hip Angle[rad]');
saveas(h, save_dir+"hip Angle"+motion_type+".svg")
saveas(h, save_dir+"hip Angle"+motion_type+".emf")
%% 髋关节角速度
h = figure('name','hip Angular Velocity');
hipAngularVelocity = [raw_data(:,3) raw_data(:,12) raw_data(:,21) raw_data(:,30)];
PLOTwithLeg(t, hipAngularVelocity, 'hip Angular Velocity','hip Angular Velocity[rad/s]');
saveas(h, save_dir+"hip Angular Velocity"+motion_type+".svg")
saveas(h, save_dir+"hip Angular Velocity"+motion_type+".emf")
%% 髋关节角加速度
h = figure('name','hip Angular Acceleration');
kneeAngularAcceleration = [raw_data(:,4) raw_data(:,13) raw_data(:,22) raw_data(:,31)];
PLOTwithLeg(t, kneeAngularAcceleration, 'hip Angular Acceleration','hip Angular Acceleration[rad/s^2]');
saveas(h, save_dir+"hip Angular Acceleration"+motion_type+".svg")
saveas(h, save_dir+"hip Angular Acceleration"+motion_type+".emf")

%% 膝关节角
h = figure('name','knee Angle');
kneeAngle = [raw_data(:,5) raw_data(:,14) raw_data(:,23) raw_data(:,32)];
PLOTwithLeg(t, kneeAngle, 'knee Angle','knee Angle[rad]');
saveas(h, save_dir+"knee Angle"+motion_type+".svg")
saveas(h, save_dir+"knee Angle"+motion_type+".emf")
%% 膝关节角速度
h = figure('name','knee Angular Velocity');
kneeAngularVelocity = [raw_data(:,6) raw_data(:,15) raw_data(:,24) raw_data(:,33)];
PLOTwithLeg(t, kneeAngularVelocity, 'knee Angular Velocity','knee Angular Velocity[rad/s]');
saveas(h, save_dir+"knee Angular Velocity"+motion_type+".svg")
saveas(h, save_dir+"knee Angular Velocity"+motion_type+".emf")
%% 膝关节角加速度
h = figure('name','knee Angular Acceleration');
kneeAngularAcceleration = [raw_data(:,7) raw_data(:,16) raw_data(:,25) raw_data(:,34)];
PLOTwithLeg(t, kneeAngularAcceleration, 'knee Angular Acceleration','knee Angular Acceleration[rad/s^2]');
saveas(h, save_dir+"knee Angular Acceleration"+motion_type+".svg")
saveas(h, save_dir+"knee Angular Acceleration"+motion_type+".emf")

%% 踝关节角
h = figure('name','ankle Angle');
ankleAngle = [raw_data(:,8) raw_data(:,17) raw_data(:,26) raw_data(:,35)];
PLOTwithLeg(t, ankleAngle, 'ankle Angle','ankle Angle[rad]');
saveas(h, save_dir+"ankle Angle"+motion_type+".svg")
saveas(h, save_dir+"ankle Angle"+motion_type+".emf")
%% 踝关节角速度
h = figure('name','ankle Angular Velocity');
ankleAngularVelocity = [raw_data(:,9) raw_data(:,18) raw_data(:,27) raw_data(:,36)];
PLOTwithLeg(t, ankleAngularVelocity, 'ankle Angular Velocity','ankle Angular Velocity[rad/s]');
saveas(h, save_dir+"ankle Angular Velocity"+motion_type+".svg")
saveas(h, save_dir+"ankle Angular Velocity"+motion_type+".emf")
%% 踝关节角加速度
h = figure('name','ankle Angular Acceleration');
ankleAngularAcceleration = [raw_data(:,10) raw_data(:,19) raw_data(:,28) raw_data(:,37)];
PLOTwithLeg(t, ankleAngularAcceleration, 'ankle Angular Acceleration','ankle Angular Acceleration[rad/s^2]');
saveas(h, save_dir+"ankle Angular Acceleration"+motion_type+".svg")
saveas(h, save_dir+"ankle Angular Acceleration"+motion_type+".emf")