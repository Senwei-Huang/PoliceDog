% 画单腿的背景
% 输入：T —— 包含触地结束（腾空开始）、腾空结束（触地开始）、触地开始（腾空开始）、腾空结束（触地开始）时刻数据，
%           并且一直按照这个顺序输入。没有的数据就用-1表示
%      X —— 要画的图的x方向的数值，一般是xlim_values
%      Y —— 要画的图的y方向的数值，一般是ylim_values
function PLOTLegBackground(T,X,Y)
        fontsize = 16;
        n = length(T);
        for i = 1:n
            if T(i)==-2
               T(i) = X(1);
               start = i;
            end
            if T(i)==-3
               T(i) = X(2);
               terminal = i; 
            end            
        end   

        for k = start:terminal-1
            x = [T(k) T(k+1) T(k+1) T(k)];
            y = [Y(1), Y(1), Y(2), Y(2)];
            if mod(k,2)==0
                patch(x,y,[246, 83, 20]/255,'FaceAlpha',.15,'LineStyle' ,'none');
                text((x(1)+x(2))/2,y(1)+(y(3)-y(1))/18,'ST','Fontsize',fontsize,'fontname','Times','HorizontalAlignment','center')
                %takeoff stance phase
            else
                patch(x,y,[0, 161, 241]/255,'FaceAlpha',.15,'LineStyle' ,'none');
                text((x(1)+x(2))/2,y(1)+(y(3)-y(1))/18,'SW','Fontsize',fontsize,'fontname','Times','HorizontalAlignment','center') 
                % flight swing phase
            end
        end
end