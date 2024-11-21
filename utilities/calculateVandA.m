%计算速度和加速度
%input: data----列向量
%       detaT----间隔时间
%output：v----速度，列向量
%        a---加速度，列向量
function [v,a] = calculateVandA(data,detaT)
        [row col] = size(data);
        %速度
        for i = 1:col
            data(:,i) = smooth(data(:,i)); 
        end 
        v = diff(data)/detaT;
        %加速度
        for i = 1:col
            v(:,i) = smooth(v(:,i)); 
        end 
        a = diff(v)/detaT;

%         %速度
%         v = diff(data)/detaT;
%         %加速度
%         a = diff(v)/detaT;
end