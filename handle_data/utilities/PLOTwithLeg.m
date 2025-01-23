%用于绘制腿部的位置，速度，加速度图
% 输入：time-------时间向量n*1
%       data-------腿长、速度、加速度数据n*4
%       titlename--标题，字符串
%       ylabelname--y标签，字符串
function PLOTwithLeg(T, time, data, titlename, ylabelname)
            fontsize = 16;
            fontname = 'Times New Roman'; % 'Times'
            linewidth = 1;
            markersize = 8;
            legendname = {'$\rm {LF}$','$\rm {RF}$','$\rm {LH}$','$\rm {RH}$'};
            n = size(data,1);
            hold on

            plot(time(1:n),data(:,1),'-o', 'linewidth', linewidth, 'MarkerSize', markersize, 'DisplayName', legendname{1});
            plot(time(1:n),data(:,2),'- .', 'linewidth', linewidth, 'MarkerSize', markersize, 'DisplayName', legendname{2});
            plot(time(1:n),data(:,3),'-p', 'linewidth', linewidth, 'MarkerSize', markersize, 'DisplayName', legendname{3});
            plot(time(1:n),data(:,4),'-s', 'linewidth', linewidth, 'MarkerSize', markersize, 'DisplayName', legendname{4});
            
%             plot(time(1:n),data(:,1),'-o', time(1:n),data(:,2),'-s', time(1:n),data(:,3),'-x',time(1:n),data(:,4),'-p', 'linewidth',2);
%             legend('$LF$','$RF$','$LH$','$RH$','Interpreter','latex','Fontsize',12,'Location','northwest',...
%                 'Orientation','horizontal','AutoUpdate','off')

            xlabel('Time [s]', 'Fontsize', fontsize, 'Fontname', fontname)
            ylabel(ylabelname, 'Fontsize', fontsize, 'Fontname', fontname)
%             title(titlename, 'Fontsize', fontsize, 'Fontname', fontname, 'FontWeight', 'bold')
            box on;
            axis manual
            ylim_values = ylim;
            xlim_values = xlim;
            set(gca, 'FontSize', fontsize);  % 设置当前坐标轴的字体大小

            PLOTBodyBackground(T.body, xlim_values, ylim_values)

            % 循环处理每列，输出最大值和最小值及其坐标
            for i = 1:size(data,2)  % 数据列的索引
                [maxValue, maxIndex] = max(data(:,i));
                [minValue, minIndex] = min(data(:,i));
                % 输出最大值和最小值及其坐标
                fprintf('%s 最大值: %f, 坐标: (%f, %f)\n', legendname{i}, maxValue, time(maxIndex), maxValue);
                fprintf('%s 最小值: %f, 坐标: (%f, %f)\n', legendname{i}, minValue, time(minIndex), minValue);
            end
end