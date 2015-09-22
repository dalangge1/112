%% Clean up
% These functions calls clean up the MATLAB environment and close all windows
% open "extra" windows.
clear all
close all


%% Variables
% The next few lines define variables for the locations and types of image files
% we will be reading and writing. You  will likely want to change the input and
% output directories to match you personal environment.
input_dir = 'prokudin-gorsky/';
output_dir = './output';
file_ext = 'tif';
file_name = '00882a.tif';


%% Read image file
% Here we read the input jpg file into a 3D array of 8-bit integers. Before we
% start to manipulate this image it is very important that we first convert the
% integer values into doubles.
I = imread([input_dir file_name]);
I = im2double(I);

%% Get image size
[v_sz, h_sz] = size(I);
v_sz = floor(v_sz / 3);

%% Split image into three color channels
B = I(1:v_sz,:);
G = I(v_sz+1:2*v_sz,:);
R = I(2*v_sz+1:3*v_sz,:);

orig = cat(3, R, G, B);

pyrH = 4;
baseVRange = 20;
baseHRange = 20;


% scale = 1 / (2^4);
% tB = imresize(B, scale);
% tG = imresize(G, scale);
% tR = imresize(R, scale);
% [v, h] = size(tR);
% baseVRange = 20;
% baseHRange = 20;

upperbv = baseVRange;
lowerbv = -baseVRange;
uppergv = baseVRange;
lowergv = -baseVRange;
upperbh = baseHRange;
lowerbh = -baseHRange;
uppergh = baseHRange;
lowergh = -baseHRange;

% bv = 0;
% bh = 0;
% gv = 0;
% gh = 0;
% 
% [ bv, bh, gv, gh ] = bfalign(tB, tG, tR, h, v, upperbv, lowerbv, uppergv, lowergv, upperbh, lowerbh, uppergh, lowergh);
% 
% bv
% bh
% gv
% gh
% 
% 
% 
% tB = circshift(tB, [bv bh]);
% tG = circshift(tG, [gv gh]);
% 
% new = cat(3, tR, tG, tB);

% figure
% imshow(orig)
% figure
% imshow(new)



for i = pyrH:-1:0
    scale = 1 / (2^i);
    tB = imresize(B, scale);
    tG = imresize(G, scale);
    tR = imresize(R, scale);
    [sizeH, sizeV] = size(tB);
    [ bv, bh, gv, gh ] = bfalign(tB, tG, tR, sizeH, sizeV, upperbv, lowerbv, uppergv, lowergv, upperbh, lowerbh, uppergh, lowergh);

%     i
%     bv
%     bh
%     gv
%     gh
%  
    upperbv = 2 * (bv + 1);
    lowerbv = 2 * (bv - 1);
    uppergv = 2 * (gv + 1);
    lowergv = 2 * (gv - 1);
    upperbh = 2 * (bh + 1);
    lowerbh = 2 * (bh - 1);
    uppergh = 2 * (gh + 1);
    lowergh = 2 * (gh - 1);
    
    %img = cat(3, tR, tG, tB);
    %figure
    %imshow(img)

end

B = circshift(B, [bv bh]);
G = circshift(G, [gv gh]);

new = cat(3, R, G, B);

figure
imshow(orig)
figure
imshow(new)

% imwrite(new, [output_dir file_name(1:end-3) '_aligned.' file_ext]);
% figure 
% imshow(B)
% figure
% imshow(G)
% figure
% imshow(R)


