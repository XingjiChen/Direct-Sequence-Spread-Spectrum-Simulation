%���������ڽ���
%userCode:��Ҫ�������û���Ԫ
%PNseq:������Ƶ�������
%gain:��Ƶ����
%phase:�û���Ƶ����λ
function res = deSpreadqam(userCode,gain)
   
    temps = userCode;
    %������matlab��һ��Сbug,������������Ϊ����,�ҵ�Ҫ��������
    %��Ϊ����,����Ҫ���з�д��ȡת�þ���
    temps = reshape(temps,gain,length(temps)/gain);
    %�����ڶ���,��Ԫ�о�
    res = ones(1,length(temps(:))/gain);
    for i = 1:length(temps(:))/gain
        res(i) = sum(temps(:,i))/gain;
    end
end