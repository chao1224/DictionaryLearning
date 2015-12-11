function [ir, ic] = getPatchPos(r, c, sm, patchNum)
    nr=r-sm;nc=c-sm;
    ir=floor(patchNum/nc)+1;
    ic=mod(patchNum,nc)+1;
end