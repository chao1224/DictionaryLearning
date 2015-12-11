function mask = getPatchMask(r, c, sm, patchNum)
    [ir,ic]=getPatchPos(r, c, sm, patchNum);
    mask=zeros(r,c);
    mask(ir:(ir+sm-1),ic:(ic+sm-1))=255;
end