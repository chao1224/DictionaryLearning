function inpaintedImgData = imgInpaint(imgData, maskData, dict, sm, lambdaGood, lambdaLasso)
    m = sm * sm; % size of a patch
    k = length(dict); % # of atoms in the dictionary
    [r, c] = size(imgData); % # of rows and columns of the image
    patchNum = getPatchNum(r, c, sm); % # of all possible patches
    
    round = 0;
    inpaintedImgData = imgData;
    maskNeedInpaint = maskData;
    while 1 % repeat until all the 
        round = round + 1
        imgDataNew = lambdaGood * (inpaintedImgData .* (1 - maskNeedInpaint)); % new image inpainted for the current interation 
        countDataNew = lambdaGood * (1 - maskNeedInpaint);
        % nNewPatch = 0; % count if there is new inpainted patch
        
        iPatch = 0;
        while 1 % travel thru all the patches, and randomly skip some of them :)
            iPatch = iPatch + 1 + floor(rand() * sm);
            if iPatch > patchNum 
                break
            end
            if mod(iPatch,10000) == 0
                iPatch
            end
            patchMaskNeedInpaint = getPatch(maskNeedInpaint, sm, iPatch); % an mX1 (0,1)-mask indicates where in the patch to inpaint
            nHole = sum(patchMaskNeedInpaint); % # of pixels that need to be recover
            if (nHole == 0 || nHole > sm) 
                % The patch is totally good,
                % or too many area missing, wait for next iteration.
                % nothing need to be done here.
                continue
            end
            % the hole is small enough in the patch so we can inpaint it in this interation
            % nNewPatch = nNewPatch + 1;
            patch = getPatch(inpaintedImgData, sm, iPatch); % an mX1 column vector
            maskPatch = getPatchMask(r, c, sm, iPatch); % an rXc (0,1)-matrix indicates where is the patch
            ind = find(patchMaskNeedInpaint ~= 1);
            iPatch
            %a = Lasso( dict(ind,:), patch(ind), tauLasso, diffLasso, lambdaLasso, rand(k,1));
            [a, fitinfo] = lasso(dict(ind,:), patch(ind), 'Lambda', lambdaLasso);
            % lasso ends
            patchNew = dict*a + fitinfo.Intercept;
            [ir, ic] = getPatchPos(r, c, sm, iPatch);
            imgDataNew(ir:(ir+sm-1),ic:(ic+sm-1)) = imgDataNew(ir:(ir+sm-1),ic:(ic+sm-1)) + reshape(patchNew,[sm,sm]);
            countDataNew = countDataNew + maskPatch;
        end
        maskNeedInpaint = (countDataNew == 0); % new mask
        inpaintedImgData = imgDataNew ./ (maskNeedInpaint + countDataNew); % average inpainted parts, "+ countDataNew" is to avoid being divided by zero
        inpimg = inpaintedImgData; % for debug use
        
        if sum(sum(maskNeedInpaint)) == 0
            % this means all is inpainted
            break
        end
    end
    figure
    imshow(inpaintedImgData);
end

