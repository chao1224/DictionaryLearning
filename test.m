%% parameters setting
sm = 10;
m = 100;
T = 20000;
k = 100;

%% read image
img = imgData('..\pic\LennaWithText.png');
[row, col] = size(img);


%% get mask
imgMask = zeros(row, col);
for i = 1 : row
   for j = 1 : col
      if img(i, j) == 0
          imgMask(i,j) = 255;
      else
          imgMask(i,j) = 0;
      end
   end
end
%figure
%imshow(imgMask);


%% decide which is mask, and which is not
patchNum = getPatchNum(row, col, sm);
lambda = 0.1;
stepsize = 0.1;
threshold =5.0;
dict = ones(m,k);
for i = 1 : m
   for j = 1 : k
      dict(i,j) = rand(1) * 0.1; 
   end
end
w = zeros(m,1);

A = zeros(m,m);
B = zeros(m,m);

for i = 1 : T
    disp(sprintf('%d',i));
    ipatch = unidrnd(patchNum);
    patch = getPatch(img, sm, ipatch);
    patch_mask = getPatch(imgMask, sm, ipatch);
    mark = containsMask(patch_mask);
    if mark
        i = i - 1;
       continue 
    end
    
    %size(dict)
    %[ra, ca] = size(patch)
    w = lasso(dict, patch);
    w = w(:,1);
    %[ra, ca] = size(w)
    
    
    A = A + w * w';
    B = B + patch * w';
    
    
    dict = dictionaryUpdate(dict, A, B);
end

D2 = dict;
max_value = max(max(dict));
min_value = min(min(dict));
for i = 1 : m
   for j = 1 : k
       D2(i,j) = (dict(i,j) - min_value) / (max_value - min_value) * 255;
   end
end
figure
showPlot();

%%
lambdaGood = 0.1;
lambdaLasso = 0.1;
inpaintedImgData = imgInpaint(img, imgMask, dict, sm, lambdaGood, lambdaLasso);

figure
imshow(inpaintedImgData);

%inpaintedImgData = inpaintedImgData * 255;
%figure
%imshow(inpaintedImgData);