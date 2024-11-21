%用于绘制脊柱角度，角速度，角加速度图
% 输入：time-------时间向量n*1
%       data-------柱角度，角速度，角加速数据n*1
%       titlename--标题，字符串
%       ylabelname--y标签，字符串
function PLOTwithSpineAngle(time, data, titlename,ylabelname)
            n = size(data,1);
            plot(time(1:n),data(:,1), 'linewidth',2);
            legend('$Spine Angle$','Interpreter','latex','Fontsize',12,'Location','northeast')
            legend('boxoff');
            xlabel('Time [s]','Fontsize',12,'Fontname','Times New Roman')
            ylabel(ylabelname,'Fontsize',12,'Fontname','Times New Roman')
            title(titlename,'Fontsize',12,'Fontname','Times New Roman')
end