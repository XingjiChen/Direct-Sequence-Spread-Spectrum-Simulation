%�Ƚ���������
%input1:����1
%input2:����2
%res:��ȷ��Ԫ����
%accuracy:��ȷ��
function [res,accuracy] = compare(input1,input2)
    temp = (input1 == input2);
    res = length(find(temp == 1));
    sizeInput = max(length(input1),length(input2));
    accuracy = res/double(sizeInput);
end