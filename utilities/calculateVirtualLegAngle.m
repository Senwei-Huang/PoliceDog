%% 计算虚拟腿角度，角速度，角加速度，腿与x轴的夹角
%输入：   FOOT---要计算的腿坐标n*3
%         HIP---------------对应髋关节坐标系n*3
%         detaT-------------时间间隔1*1
%  输出： legAngle--------腿长n*3
%         legAngularVelocity------腿伸缩速度（n-1）*3
%         legAngularAcceleration--加速度(n-2)*3
function [legAngle,legAngularVelocity,legAngularAcceleration] = calculateVirtualLegAngle(FOOT,HIP,detaT)
        xAxis = [1 0 0]';
        %虚拟腿角度
        for i=1:max(size(FOOT))
            legAngle(i,:) = acos(dot(FOOT(i,:)-HIP(i,:),xAxis)/(norm(FOOT(i,:)-HIP(i,:))*norm(xAxis)));
        end
        %腿伸缩速度
        legAngularVelocity = diff(smooth(legAngle))/detaT;
        %腿加速度
        legAngularAcceleration = diff(smooth(legAngularVelocity))/detaT;
end