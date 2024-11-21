%用于绘制腿部的位置，速度，加速度图
% 输入：time-------时间向量n*1
%       data-------腿长、速度、加速度数据n*4
%       titlename--标题，字符串
%       ylabelname--y标签，字符串
function PLOTwithLeg(T,time, data, titlename,ylabelname)
            n = size(data,1);
            plot(time(1:n),data(:,1),'-o', time(1:n),data(:,2),'-s', time(1:n),data(:,3),'-x',time(1:n),data(:,4),'-p', 'linewidth',2);
            legend('$LF$','$RF$','$LH$','$RH$','Interpreter','latex','Fontsize',12,'Location','northwest',...
                'Orientation','horizontal','AutoUpdate','off')
            legend('boxoff');
            xlabel('Time [s]','Fontsize',12,'Fontname','Times New Roman')
            ylabel(ylabelname,'Fontsize',12,'Fontname','Times New Roman')
            title(titlename,'Fontsize',12,'Fontname','Times New Roman')
            axis manual
            ylim_values = ylim;
            xlim_values = xlim;
            PLOTBodyBackground(T.body,xlim_values,ylim_values)
end