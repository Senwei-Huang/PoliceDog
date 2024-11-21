%% 计算虚拟腿长，速度，加速度
%输入：   FOOT---要计算的腿坐标n*3
%         HIP---------------对应髋关节坐标系n*3
%         detaT-------------时间间隔1*1
%  输出： legLength--------腿长n*3
%         legVelocity------腿伸缩速度（n-1）*3
%         legAcceleration--加速度(n-2)*3
function [legLength,legVelocity,legAcceleration] = calculateVirtualLeg(FOOT,HIP,detaT)
        %虚拟腿长
        for i=1:max(size(FOOT))
            legLength(i,:) = norm(FOOT(i,:)-HIP(i,:));
        end
        %腿伸缩速度
        legVelocity = diff(smooth(legLength))/detaT;
        %腿加速度
        legAcceleration = diff(smooth(legVelocity))/detaT;
end