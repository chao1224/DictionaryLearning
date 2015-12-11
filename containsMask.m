function mark = containsMask(imgMask)
    [r, c] = size(imgMask);
    mark = false;
    for i = 1 : r
       for j = 1 : c
           if imgMask(i, j) == 255
              mark = true;
              break;
           end
       end
       if mark
           break;
       end
    end
end