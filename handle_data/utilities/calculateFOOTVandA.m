%计算足端的速度和加速度
%输入：FOOT----四条腿的足端位置,n*12
%      detaT----间隔时间
%输出：FOOTV-----足端速度（n-1）*12
%      FOOTA------足端加速度(n-2)*12
function [FOOTV,FOOTA] = calculateFOOTVandA(FOOT,detaT)
         [left_handV,left_handA] = calculateVandA(FOOT(:,1:3),detaT);
         [right_handV,right_handA] = calculateVandA(FOOT(:,4:6),detaT);
         [left_footV,left_footA] = calculateVandA(FOOT(:,7:9),detaT);
         [right_footV,right_footA] = calculateVandA(FOOT(:,10:12),detaT);
         FOOTV = [left_handV right_handV left_footV right_footV];
         FOOTA = [left_handA right_handA left_footA right_footA];
end