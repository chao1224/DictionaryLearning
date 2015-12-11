function img = imgData(str)
    img = double(imread(str));
    if max(max(img)) > 1
        img = img / 255;
    end
end