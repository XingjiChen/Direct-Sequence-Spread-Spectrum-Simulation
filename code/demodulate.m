function res = demodulate(input,carrier)
%本函数实现对接收信号的解调
%input:被解调的信号
%carrier:载波信号

%按位循环相乘
res_bitMultiple = bitMultiple(input,carrier);
%分组相加
res_arrayGroupSum = arrayGroupSum(res_bitMultiple,length(carrier))/800;
for i = 1:length(res_arrayGroupSum)
    if res_arrayGroupSum(i) > 0
        res(i) = 1;
    elseif res_arrayGroupSum(i) < 0
        res(i) = -1;
    end
end
end