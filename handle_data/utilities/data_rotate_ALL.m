%% 处理原始数据：将所有的数据都转一个方向，然后输出，使x方向向前
%   输入：raw_data---原始数据
%         n-----有效数据的行数，再往后取数据不全
%         angle---将X轴转为奔跑的正方向要转动的角度，根据画出来的结果试出来的
%   输出：raw_data_rotate----所有的数据旋转了angle后的状态
function raw_data_rotate = data_rotate_ALL(raw_data,n,angle)
        t = raw_data(1:n,1);
        data = raw_data(1:n,2:end);
        col = size(data,2);
        for i = 1:col/3
            data_temp((i-1)*n + 1 : i*n, :) = data(:, (i-1)*3 + 1 : i*3);
        end
        data_temp_trans = data_temp';
        data_temp_rotate = rz(angle)*data_temp_trans;
        data_temp_rotate_trans = data_temp_rotate';
        for i = 1:col/3
            data_rotate(:, (i-1)*3 + 1 : i*3) = data_temp_rotate_trans((i-1)*n + 1 : i*n, :);
        end
        raw_data_rotate = [t,data_rotate];
end