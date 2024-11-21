
clear; clc; close all;
detaT = 1/120;
addpath(genpath('../utilities'));
save_dir = "./SaveFigure/body motion/"; % 保存路径
nframe = 5;

%% 机器人参数
robot.L = 0.3868;
robot.W = 0.093;
robot.l1 = 0.0955;
robot.l2 = 0.213;
robot.l3 = 0.213;
robot.I = eye(3);   %不能修改，作为矩阵中的常数
robot.p0 = [0,0,0]';%不能修改，作为矩阵中的常数
robot.P = [robot.l3,0,0,1]';
%% 5 low height jump 2
motion_type = "(5 low height jump 2)";
actionNum = 5;
raw_data = readmatrix('../Dog motion data/1 low hurdle/raw_data.csv');
n_data = 47; %数据完整的行数，再往后取数据不全
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
%JSON文件参数
json.LoopMode = "lowjump";
json.FrameDuration = 0.00833;
json.EnableCycleOffsetPosition = true;
json.EnableCycleOffsetRotation = true;
json.MotionWeight = 1.0;
%% 6 mid height jump 1
% motion_type = "(6 mid height jump 1)";
% raw_data = readmatrix('./6 mid height jump 1/raw_data.csv');
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
% %JSON文件参数
% json.LoopMode = "midjump";
% json.FrameDuration = 0.00833;
% json.EnableCycleOffsetPosition = true;
% json.EnableCycleOffsetRotation = true;
% json.MotionWeight = 1.0;
%% 7 high height jump 1
% motion_type = "(7 high height jump 1)";
% raw_data = readmatrix('./7 high height jump 1/raw_data.csv');
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
% %JSON文件参数
% json.LoopMode = "heightjump";
% json.FrameDuration = 0.00833;
% json.EnableCycleOffsetPosition = true;
% json.EnableCycleOffsetRotation = true;
% json.MotionWeight = 1.0;
%% 8 ring jump 1 警犬穿越圆洞 高0.115m
% motion_type = "(ring jump 1)";
% raw_data = readmatrix('./8 ring jump 1\raw_data.csv');
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
% %JSON文件参数
% json.LoopMode = "ringjump1";
% json.FrameDuration = 0.00833;
% json.EnableCycleOffsetPosition = true;
% json.EnableCycleOffsetRotation = true;
% json.MotionWeight = 1.0;
%% 9 ring jump 2
% motion_type = "(ring jump 2)";
% raw_data = readmatrix('./9 ring jump 2\raw_data.csv');
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
% %JSON文件参数
% json.LoopMode = "ringjump2";
% json.FrameDuration = 0.00833;
% json.EnableCycleOffsetPosition = true;
% json.EnableCycleOffsetRotation = true;
% json.MotionWeight = 1.0;
%% 数据分类
data = data_rotate_ALL(raw_data,n_data,angle);
t = data(1:n_data,1);
obs = data(1,89:91);
data = data+[zeros(n_data,1) repmat(-obs,n_data,(size(data,2)-1)/3)];
%缩放
data = 0.67*data;
%把右侧的髋关节y方向的坐标修改成与机器人一致的宽度，就是右侧的坐标等于左侧的坐标减去0.093
data(:,15) = data(:,99) + 0.093/2;
data(:,27) = data(:,99) + 0.093/2;
data(:,57) = data(:,99) - 0.093/2;
data(:,69) = data(:,99) - 0.093/2;
%把右侧的足端y方向的坐标修改成与机器人一致的宽度，就是右侧的坐标等于左侧的坐标减去0.284
data(:,24) = data(:,99) + 0.284/2;
data(:,36) = data(:,99) + 0.284/2;
data(:,66) = data(:,99) - 0.284/2;
data(:,78) = data(:,99) - 0.284/2;

% 质心
source.spinemid = data(:,98:100);
% 右前腿
source.hip_RF = data(:,56:58);
source.foot_RF = data(:,65:67);
% 左前腿
source.hip_LF = data(:,14:16);
source.foot_LF = data(:,23:25);
% 右后腿
source.hip_RH = data(:,68:70);
source.foot_RH = data(:,77:79);
% 左后腿
source.hip_LH = data(:,26:28);
source.foot_LH = data(:,35:37);

sourcedata = [source.spinemid, source.hip_RF, source.foot_RF, source.hip_LF, source.foot_LF, ...
              source.hip_RH, source.foot_RH, source.hip_LH, source.foot_LH ];
% writematrix(sourcedata,'E:\GO2\GO2\controllers\dog_supervisor\'+json.LoopMode+'_pointdata.txt')

%% 15个优化变量一起优化
%通过优化的方式计算最优的机身欧拉角以及关节角度
q = [];
% i= 4;
% options = optimoptions('ga','Display','none');
% problem.options = options;
% problem.solver = 'ga';
% problem.fitnessfcn = @(q)fun(q,source,i);
% problem.nvars = 15;
% problem.x0 = zeros(15,1);
% problem.lb = [0,0,0,-0.8378,-3.4907,-2.7227,-0.8378,-3.4907,-2.7227,-0.8378,-4.5379,-2.7227,-0.8378,-4.5379,-2.7227]';
% problem.ub = [pi,pi,2*pi,0.8378,pi/2,0.8378,0.8378,pi/2,0.8378,0.8378,pi/6,0.8378,0.8378,pi/6,0.8378]';
% [x,fval,exitflag] = ga(problem);

% for i = 1:size(source.spinemid,1)
%     options = optimoptions('fmincon','Display','iter','Algorithm','sqp');
%     problem.options = options;
%     problem.solver = 'fmincon';
%     problem.objective = @(q)fun(q,source,i);
%     problem.x0 = zeros(15,1);
%     problem.lb = [0,0,0,-0.8378,-3.4907,-2.7227,-0.8378,-3.4907,-2.7227,-0.8378,-4.5379,-2.7227,-0.8378,-4.5379,-2.7227]';
%     problem.ub = [pi,pi,2*pi,0.8378,pi/2,0.8378,0.8378,pi/2,0.8378,0.8378,pi/6,0.8378,0.8378,pi/6,0.8378]';
%     x = fmincon(problem);
%     q = [q x];
% end
%% 三个变量单独优化
% 优化计算欧拉角
rpy = [];
for i = 1:size(source.spinemid,1)
% for i = 4
    options = optimoptions('fmincon','Display','iter','Algorithm','sqp');
    problem.options = options;
    problem.solver = 'fmincon';
    problem.objective = @(q)Eulerfun(q,source,i,robot);
    problem.x0 = zeros(6,1);
    problem.lb = [-inf,-inf,-inf,-pi/4,-pi/2,-pi]';
    problem.ub = [ inf, inf, inf, pi/4, pi/2, pi]';
    [x,fval] = fmincon(problem);
    rpy = [rpy x];
end
%分别优化四条腿的角度
qCOL = [];
p_foot_pos = [];
lb = [-0.8378,-pi/2,-2.7227,-0.8378,-pi/2,-2.7227,-0.8378,-pi/6,-2.7227,-0.8378,-pi/6,-2.7227]';
ub = [0.8378,3.4907,-0.8378,0.8378,3.4907,-0.8378,0.8378,4.5379,-0.8378,0.8378,4.5379,-0.8378]';

for j = 0:3
    q = [];
    p = [];
    for i = 1:size(source.spinemid,1)
        options = optimoptions('fmincon','Display','iter');
        problem.options = options;
        problem.solver = 'fmincon';
%         problem.objective = @(x)legfun(rpy,x,i,source,robot,j);
        problem.objective = @(x)legfun(rpy(:,i),x,i,source,robot,j);
        problem.x0 = [0.3;0.1;-1];
        problem.lb = lb(3*j+1:3*j+3);
        problem.ub = ub(3*j+1:3*j+3);
        [x,fval] = fmincon(problem);
        q = [q x];
        pos = footPOS(rpy(:,i),x,robot,j);
        p = [p pos];
    end
    qCOL = [qCOL;q];
    p_foot_pos = [p_foot_pos;p];
end


%% 校验
% f = fun(x,source,i)
% rz(x(3))*ry(x(2))*rx(x(1))
% rpy = [x(3),x(2),x(1)];
% quaternion(rpy,'euler','ZYX','frame')

%% 输出优化结果
%bodyquaternion = [w,x,y,z]'
bodyquaternion = angle2quat(rpy(6,:),rpy(5,:),rpy(4,:),'ZYX');
axang = quat2axang(bodyquaternion);
targetdata = [rpy(1:3,:)' axang qCOL'];
writematrix(targetdata,'E:\GO2\GO2\controllers\dog_supervisor\'+json.LoopMode+'_targetpose.txt');


% %计算质心线速度，角速度，关节角速度，足端速度
% v_rpy = diff(rpy');
% v_qCOL = diff(qCOL');
% v_p_foot_pos = diff(p_foot_pos');
% %把四元数的结果中的w放到最后面去
% Q = bodyquaternion(:,1);
% bodyquaternion(:,1:3) = bodyquaternion(:,2:4);
% bodyquaternion(:,4) = Q;
% motiondata = [rpy(1:3,2:end)' bodyquaternion(2:end,:) qCOL(:,2:end)' p_foot_pos(:,2:end)' v_rpy v_qCOL v_p_foot_pos];
% writematrix(motiondata,'D:\研究生\运动数据采集\运动数据测量结果\Reports\motiondata\'+json.LoopMode+'.txt');
% json.Frames = motiondata;
% t = jsonencode(json);
% file= fopen('D:\研究生\运动数据采集\运动数据测量结果\Reports\motiondata\'+json.LoopMode+'.json', 'w+');
% fprintf(file, '%s',t);
% fclose(file);
%% 目标函数
%定义q : rpy （1：3）, 右前腿关节角度（4：6），左前腿关节角度（7：9），右后腿关节角度（10：12），左后腿关节角度（13：15），共十五维列向量
%i表示帧数，优化第几帧的结果
function f = fun(q,source,i)
        robot.L = 0.3868;
        robot.W = 0.093;
        robot.l1 = 0.0955;
        robot.l2 = 0.213;
        robot.l3 = 0.213;
        robot.I = eye(3);
        robot.p0 = [0 0 0]';
        robot.P = [robot.l3,0,0,1]';
        comPOS = source.spinemid;
        
        q_bar = [0,0,0,-0.1,0.8,-1.5,0.1,0.8,-1.5,-0.1,1,-1.5,0.1,1,-1.5]';
        W = 0.00*eye(15);
        %目标位置
        % 右前腿
        target.foot_RF = transrpy(q(4:6),0,robot,q(1:3),comPOS)*robot.P;
        target.foot_RF = target.foot_RF(1:3);
        target.hip_RF = rz(q(3))*ry(q(2))*rx(q(1))*[robot.L/2,-robot.W/2,0]'+ comPOS;
        % 左前腿
        target.foot_LF = transrpy(q(7:9),1,robot,q(1:3),comPOS)*robot.P;
        target.foot_LF = target.foot_LF(1:3);
        target.hip_LF = rz(q(3))*ry(q(2))*rx(q(1))*[robot.L/2,robot.W/2,0]' + comPOS;
        % 右后腿
        target.foot_RH = transrpy(q(10:12),2,robot,q(1:3),comPOS)*robot.P;
        target.foot_RH = target.foot_RH(1:3);
        target.hip_RH = rz(q(3))*ry(q(2))*rx(q(1))*[-robot.L/2,-robot.W/2,0]' + comPOS;
        % 左后腿
        target.foot_LH = transrpy(q(13:15),3,robot,q(1:3),comPOS)*robot.P;
        target.foot_LH = target.foot_LH(1:3);
        target.hip_LH = rz(q(3))*ry(q(2))*rx(q(1))*[-robot.L/2,robot.W/2,0]' + comPOS;
        
        sourcePOS = [source.hip_RF(i,:),source.foot_RF(i,:),source.hip_LF(i,:),source.foot_LF(i,:),...
                     source.hip_RH(i,:),source.foot_RH(i,:),source.hip_LH(i,:),source.foot_LH(i,:)]';
        targetPOS = [target.hip_RF;target.foot_RF;target.hip_LF;target.foot_LF;...
                     target.hip_RH;target.foot_RH;target.hip_LH;target.foot_LH];
%         disp(sourcePOS')
%         disp(targetPOS')
        f = (sourcePOS-targetPOS)'*(sourcePOS-targetPOS) + (q_bar-q')'* W *(q_bar-q');
end


%定义q : rpy （1：3）, 右前腿关节角度（4：6），左前腿关节角度（7：9），右后腿关节角度（10：12），左后腿关节角度（13：15），共十五维列向量
%i表示帧数，优化第几帧的结果

% 欧拉角优化目标函数
function f = Eulerfun(q,source,i,robot)
%         W = diag(100*[0.1,0.1,0.1,5,5,5,5,5,5,5,5,5,5,5,5]);
        W = eye(15);
        comPOS = q(1:3);
        %目标位置
        % 右前腿
        target.hip_RF = rz(q(6))*ry(q(5))*rx(q(4))*[robot.L/2,-robot.W/2,0]'+ comPOS;
        % 左前腿
        target.hip_LF = rz(q(6))*ry(q(5))*rx(q(4))*[robot.L/2,robot.W/2,0]' + comPOS;
        % 右后腿
        target.hip_RH = rz(q(6))*ry(q(5))*rx(q(4))*[-robot.L/2,-robot.W/2,0]' + comPOS;
        % 左后腿
        target.hip_LH = rz(q(6))*ry(q(5))*rx(q(4))*[-robot.L/2,robot.W/2,0]' + comPOS;
        
        sourcePOS = [source.spinemid(i,:),source.hip_RF(i,:),source.hip_LF(i,:),...
                     source.hip_RH(i,:),source.hip_LH(i,:)]';
        targetPOS = [comPOS;target.hip_RF;target.hip_LF;...
                     target.hip_RH;target.hip_LH;];  
                 
        f = (sourcePOS-targetPOS)'*W*(sourcePOS-targetPOS);
end

%腿部关节角优化函数
%legnum: FR0,FL1,RH2,LH3
%body:6*1,前三个是质心位置，后三个是质心欧拉角
%q:3*1列向量
function f = legfun(body,q,i,source,robot,legnum)
        comPOS = body(1:3);
        %这个q_bar还没改
        W = 0*eye(3);
        Q = 500*eye(3);
        %目标位置
        switch legnum
            case 0
                % 右前腿
                target.foot_RF = transrpy(q,0,robot,body(4:6),comPOS)*robot.P;
%                 disp(body');
%                 disp(q');
                targetPOS = target.foot_RF(1:3);
                sourcePOS = source.foot_RF(i,:)';
                q_bar = [-0.1,0.8,-1.5]';
            case 1
                % 左前腿
                target.foot_LF = transrpy(q,1,robot,body(4:6),comPOS)*robot.P;
                targetPOS = target.foot_LF(1:3);
                sourcePOS = source.foot_LF(i,:)';
                q_bar = [0.1,0.8,-1.5]';
            case 2
                % 右后腿
                target.foot_RH = transrpy(q,2,robot,body(4:6),comPOS)*robot.P;
                targetPOS = target.foot_RH(1:3);
                sourcePOS = source.foot_RH(i,:)';
                q_bar = [-0.1,1,-1.5]';
            case 3
                % 左后腿
                target.foot_LH = transrpy(q,3,robot,body(4:6),comPOS)*robot.P;
                targetPOS = target.foot_LH(1:3);
                sourcePOS = source.foot_LH(i,:)';
                q_bar = [0.1,1,-1.5]';
        end
%         targetPOS
%         sourcePOS
        f = (sourcePOS-targetPOS)'*Q*(sourcePOS-targetPOS) + (q_bar-q)'* W *(q_bar-q);
end

% 计算足端的位置
function POS = footPOS(body,q,robot,legnum)
        comPOS = body(1:3);
        %目标位置
        switch legnum
            case 0
                % 右前腿
                target.foot_RF = transrpy(q,0,robot,body(4:6),comPOS)*robot.P;
                targetPOS = target.foot_RF(1:3);
            case 1
                % 左前腿
                target.foot_LF = transrpy(q,1,robot,body(4:6),comPOS)*robot.P;
                targetPOS = target.foot_LF(1:3);
            case 2
                % 右后腿
                target.foot_RH = transrpy(q,2,robot,body(4:6),comPOS)*robot.P;
                targetPOS = target.foot_RH(1:3);
            case 3
                % 左后腿
                target.foot_LH = transrpy(q,3,robot,body(4:6),comPOS)*robot.P;
                targetPOS = target.foot_LH(1:3);
        end
        POS = targetPOS;
end







