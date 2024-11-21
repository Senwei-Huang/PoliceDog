%% 处理原始数据：将数据转一个方向，使x方向向前
%   输入：raw_data---原始数据
%         n-----有效数据的行数，再往后取数据不全
%         angle---将X轴转为奔跑的正方向要转动的角度，根据画出来的结果试出来的
%   输出：左右前后腿的足端位置（世界系）
%         FOOT顺序是左前右前、左后右后 n*12
%         HIP顺序是左前右前、左后右后 n*12
%         t---时间
%         pitch_deg---运动过程中躯干的pitch角
%         CoM，CoM_dot---质心（中间脊柱）的位置和速度
function [FOOT,t,HIP,CoM] = data_rotate(raw_data,n,angle)
        t = raw_data(1:n,1);
        %足端
        left_hand = raw_data(1:n,23:25)';
        right_hand = raw_data(1:n,65:67)';
        left_foot = raw_data(1:n,35:37)';
        right_foot = raw_data(1:n,77:79)';
        %左右脊柱前连线中点
        midspinefront = raw_data(1:n,95:97)';
        %左右脊柱后连线中点
        midspineback = raw_data(1:n,101:103)';
        %质心(左右中脊柱连线中点)
        CoM = raw_data(1:n,98:100)';
        %左右前髋关节
        left_shoulder = raw_data(1:n,14:16)';
        right_shoulder = raw_data(1:n,56:58)';
        %左右后髋关节
        left_hip = raw_data(1:n,26:28)';
        right_hip = raw_data(1:n,68:70)';
        
%         HIP = [left_shoulder;right_shoulder;left_hip;right_hip]';
%         FOOT = [left_hand;right_hand;left_foot;right_foot]';
%         plot3(FOOT(:,1),FOOT(:,2),FOOT(:,3),...
%         FOOT(:,4),FOOT(:,5),FOOT(:,6),...
%         FOOT(:,7),FOOT(:,8),FOOT(:,9),...
%         FOOT(:,10),FOOT(:,11),FOOT(:,12),...
%         HIP(:,1),HIP(:,2),HIP(:,3),'lineWidth',2)
%     hold on
        %将原来的歪的坐标系转一下，转到以x方向为前方
        left_hand = rz(angle)*left_hand;
        left_foot = rz(angle)*left_foot;
        right_hand= rz(angle)*right_hand;
        right_foot = rz(angle)*right_foot;
        FOOT = [left_hand;right_hand;left_foot;right_foot]';
        
        midspinefront = rz(angle)*midspinefront;
        midspineback = rz(angle)*midspineback;
        CoM = rz(angle)*CoM;
        CoM = CoM';
        
        left_shoulder = rz(angle)*left_shoulder;
        right_shoulder = rz(angle)*right_shoulder;
        left_hip = rz(angle)*left_hip;
        right_hip = rz(angle)*right_hip;
        HIP = [left_shoulder;right_shoulder;left_hip;right_hip]';

end