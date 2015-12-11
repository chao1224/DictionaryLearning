%function(imgnew) = Recover(D2,img,sm)
%% use dictionay D2 and the original img to do impainting
img = img_red;
m = 100;
sm = 10;
[nrow, ncol,height] = size(img);
nrow2 = nrow -sm + 1;
ncol2 = ncol -sm + 1;
% for i = 1 : nrow + 1
%     for j = 1 : ncol+ 1
%         imfreshape(:,j+ncol*(i-1)) = reshape(img(i:i+sm-1, j:j+sm-1),[m,1]);
%     end
% end

%Step1: turn img into reshape patch call it imgreshape

%Step2: each imgreshape use D to learn finally get a weight

%Step3: use weight and dictionary to recover ==> every time use a count to
%calculate the pixel
count = zeros(nrow,ncol);
imgfinal = zeros(nrow,ncol);
for t = 1 : nrow2*ncol2
    r = floor((t-1)/ncol2) + 1;
    c = mod(t, ncol2);
    if c==0
        c = ncol2;
    end
    count(r:r+sm-1,c:c+sm-1) = count(r:r+sm-1,c:c+sm-1) + 1;
    imgreshape(:,t) = reshape(img(r:r+sm-1,c:c+sm-1),[m,1]);
    weight(:,t) = imgreshape(:,t)\D2;
    newimgreshape(:,t) = D2 * weight(:,t);
    imgfinal(r:r+sm-1,c:c+sm-1) = imgfinal(r:r+sm-1,c:c+sm-1) + reshape(newimgreshape(:,t),[10,10]);
end

