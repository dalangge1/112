%% Clean up
% These functions calls clean up the MATLAB environment and close all windows
% open "extra" windows.
clear all
close all


%% Variables
% The next few lines define variables for the locations and types of image files
% we will be reading and writing. You  will likely want to change the input and
% output directories to match you personal environment.
input_dir = '../../data/prokudin-gorsky/small/';
output_dir = './out';
file_ext = 'tif';
file_name = '00888a_tiny.tif';


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

J = cat(3, R, G, B);

figure
imshow(J)


