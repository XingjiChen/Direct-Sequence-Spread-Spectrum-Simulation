%本函数用于解扩
%userCode:需要解扩的用户码元
%PNseq:用于扩频的随机码
%gain:扩频增益
%phase:用户扩频码相位
function res = deSpreadqam(userCode,gain)
   
    temps = userCode;
    %这里是matlab的一个小bug,重排序以列作为索引,我的要求是以行
    %作为索引,所以要行列反写再取转置矩阵
    temps = reshape(temps,gain,length(temps)/gain);
    %解扩第二步,码元判决
    res = ones(1,length(temps(:))/gain);
    for i = 1:length(temps(:))/gain
        res(i) = sum(temps(:,i))/gain;
    end
end