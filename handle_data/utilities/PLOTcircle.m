%画跳圈的那个圈
function PLOTcircle(x,z)
        obstacle_down = [x,0,z;x,0,z+0.87];
        obstacle_up = [x,0,z+1.445;x,0,z+1.9];
        plot3(obstacle_down(:,1),obstacle_down(:,2),obstacle_down(:,3),...
            obstacle_up(:,1),obstacle_up(:,2),obstacle_up(:,3),'linewidth', 10,'color','k')
end