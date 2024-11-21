%% 画各腿触地/离地时刻的竖线
function PLOTJumpPhase(phaseT, phaseN)
colorname = ['k', 'm', "#4DBEEE", "#D95319", "#77AC30", "#7E2F8E", "#0072BD", "#A2142F"];
for i=1:size(phaseT, 2)
    xl = xline(phaseT(i), '-k', phaseN(i), 'LineWidth', 1, 'Fontname','Times New Roman');
    xl.Color = colorname(i);
    if i<=2
        xl.LabelVerticalAlignment = 'bottom';
    elseif i<=4
        xl.LabelVerticalAlignment = 'middle';
    else
        xl.LabelVerticalAlignment = 'top';
    end
    xl.LabelHorizontalAlignment = 'left';
    xl.LabelOrientation = 'horizontal'; %aligned horizontal
end
end