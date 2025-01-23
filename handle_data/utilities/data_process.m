%% 处理原始数据：将数据转一个方向，使x方向向前
%   输入：raw_data---原始数据
%         n-----有效数据的行数，再往后取数据不全
%         angle---将X轴转为奔跑的正方向要转动的角度，根据画出来的结果试出来的
%   输出：FOOT_wB-----足端在质心定向系下的位置
%         FOOT_wH-----足端在髋关节定向系下的位置
%         FOOT_bB-----足端在质心坐标系下的位置
%         FOOT_bH-----足端在髋关节坐标系下的位置
%         t---时间
%         body_pitch---运动过程中躯干的pitch角
%         CoM，CoM_dot---质心（中间脊柱）的位置和速度
function [FOOT_wB,FOOT_wH,FOOT_bB,FOOT_bH,t,body_pitch,CoM,CoM_dot] = data_process(raw_data,n,angle)
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
        % spine_mid_left = raw_data(:,8:10);  % 左中脊柱位置(XYZ)
        % spine_mid_right = raw_data(:,50:52); % 右中脊柱位置(XYZ)
        %质心(左右中脊柱连线中点)
        CoM = raw_data(1:n,98:100)';
        %肩关节
        left_shoulder = raw_data(1:n,14:16)';
        right_shoulder = raw_data(1:n,56:58)';
        %髋关节
        left_hip = raw_data(1:n,26:28)';
        right_hip = raw_data(1:n,68:70)';
        %将原来的歪的坐标系转一下，转到以x方向为前方
        left_hand = rz(angle)*left_hand;
        left_foot = rz(angle)*left_foot;
        right_hand= rz(angle)*right_hand;
        right_foot = rz(angle)*right_foot;
        FOOT_wB = [(left_hand-CoM)' (right_hand-CoM)' (left_foot-CoM)'  (right_foot-CoM)'];
        
        left_shoulder = rz(angle)*left_shoulder;
        right_shoulder = rz(angle)*right_shoulder;
        left_hip = rz(angle)*left_hip;
        right_hip = rz(angle)*right_hip;
        FOOT_wH = [(left_hand-left_shoulder)' (right_hand-right_shoulder)' (left_foot-left_hip)' (right_foot-right_hip)'];

        midspinefront = rz(angle)*midspinefront;
        midspineback = rz(angle)*midspineback;
        CoM = rz(angle)*CoM;
        %质心速度
        CoM_dot = (diff(CoM')/(1/120))';
        %求运动过程中的pitch角
        vector_spine = midspinefront - midspineback;
        for i = 1:n
            body_pitch(1,i) =-atan(vector_spine(3,i)/vector_spine(1,i));
        end
%         pitch_deg = rad2deg(body_pitch);
        for i = 1:n
            %另外两个角度都是0，旋转矩阵是I，3*3
            R_W_B = ry(body_pitch(i));
            left_hand_bB(:,i) = R_W_B'*( left_hand(:,i) - CoM(:,i) );
            right_hand_bB(:,i) = R_W_B'*( right_hand(:,i) - CoM(:,i) );
            left_foot_bB(:,i) = R_W_B'*( left_foot(:,i) - CoM(:,i) );
            right_foot_bB(:,i) = R_W_B'*( right_foot(:,i) - CoM(:,i) );
        end
        FOOT_bB = [left_hand_bB' right_hand_bB' left_foot_bB' right_foot_bB'];
        for i = 1:n
            R_W_B = ry(body_pitch(i));
            left_hand_bH(:,i) = R_W_B'*( left_hand(:,i) - left_shoulder(:,i));
            right_hand_bH(:,i) = R_W_B'*( right_hand(:,i) - right_shoulder(:,i));
            left_foot_bH(:,i) = R_W_B'*( left_foot(:,i) - left_hip(:,i) );
            right_foot_bH(:,i) = R_W_B'*( right_foot(:,i) - right_hip(:,i) );
        end
        FOOT_bH = [left_hand_bH' right_hand_bH' left_foot_bH' right_foot_bH'];
end

