%% 这个函数是用来自动画图和编辑标题以及坐标的，但是只有一种特定的格式
% input:  time---时间
%         data---数据
%         legname----腿名称
%         titlename---图题名称
function PLOT(time,data,titlename)
plot(time,data(1,:), time,data(2,:), time,data(3,:), 'linewidth',2)
legend('$x$','$y$','$z$','Interpreter','latex','Fontsize',12,'Location','northeast')
% legend("X","Y","Z",'Fontsize',12,'fontname','Times','Location','northeast')
legend('boxoff')
xlabel('Time [s]','Fontsize',12,'Fontname','Times New Roman')
ylabel('Foot position [m]','Fontsize',12,'Fontname','Times New Roman')
title(titlename,'Fontsize',12,'Fontname','Times New Roman')
end