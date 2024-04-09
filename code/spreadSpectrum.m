%扩频函数
%userCode:需要扩频的用户码元
%PNseq:用于扩频的随机码
%gain:扩频增益
%phase:用户扩频码相位
function res = spreadSpectrum(userCode,gain)
    %首先对码元进行周期延拓
    [~,userCode2] = selfCopy(userCode,gain);

    res = userCode2;
end