function res = demodulate(input,carrier)
%������ʵ�ֶԽ����źŵĽ��
%input:��������ź�
%carrier:�ز��ź�

%��λѭ�����
res_bitMultiple = bitMultiple(input,carrier);
%�������
res_arrayGroupSum = arrayGroupSum(res_bitMultiple,length(carrier))/800;
for i = 1:length(res_arrayGroupSum)
    if res_arrayGroupSum(i) > 0
        res(i) = 1;
    elseif res_arrayGroupSum(i) < 0
        res(i) = -1;
    end
end
end