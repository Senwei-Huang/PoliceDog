%% 画曲线函数
function PLOTwithPhase(T,time, data, titlename,ylabelname, phaseT, phaseN)
        plot(time,data(:,1),'-o', time,data(:,2),'-s', time,data(:,3),'-x', 'linewidth',2);
        hold on;
        PLOTJumpPhase(phaseT, phaseN);
%         legend('$x$','$y$','$z$','Interpreter','latex','Fontsize',15,'Location','northeast', 'Orientation','horizontal','AutoUpdate','off')
        legend('$x$','$y$','$z$','Interpreter','latex','Fontsize',15,'Location','northwest', 'Orientation','horizontal','AutoUpdate','off')
        % legend("X","Y","Z",'Fontsize',12,'fontname','Times','Location','northeast')
        legend('boxoff');
        xlabel('Time [s]','Fontsize',12,'Fontname','Times New Roman')
        ylabel(ylabelname,'Fontsize',12,'Fontname','Times New Roman')
        title(titlename,'Fontsize',12,'Fontname','Times New Roman')
        axis manual
        ylim_values = ylim;
        xlim_values = xlim;
        name = split(titlename);
        witchleg = name(1);
        switch witchleg
            case 'LF'
                PLOTLegBackground(T.LF,xlim_values,ylim_values)
            case 'RF'
                PLOTLegBackground(T.RF,xlim_values,ylim_values)
            case 'LH'
                PLOTLegBackground(T.LH,xlim_values,ylim_values)
            case 'RH'
                PLOTLegBackground(T.RH,xlim_values,ylim_values)
        end 
end