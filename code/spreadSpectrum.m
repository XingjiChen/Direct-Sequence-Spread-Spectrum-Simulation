%��Ƶ����
%userCode:��Ҫ��Ƶ���û���Ԫ
%PNseq:������Ƶ�������
%gain:��Ƶ����
%phase:�û���Ƶ����λ
function res = spreadSpectrum(userCode,gain)
    %���ȶ���Ԫ������������
    [~,userCode2] = selfCopy(userCode,gain);

    res = userCode2;
end