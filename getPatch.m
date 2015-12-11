function patch = getPatch(imgData, sm, patchNum)
    [r,c]=size(imgData);
    [ir,ic]=getPatchPos(r, c, sm, patchNum);
    patch = reshape( imgData( ir:(ir+sm-1), ic:(ic+sm-1) ),   [sm*sm,1] );
end