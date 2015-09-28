function [ newB, newG, newR ] = pyramidalign( oldB, oldG, oldR )
%PYRAMIDALIGN Alignment of images B, G, and R using brute force
%on smaller versions of oldB, oldG, and oldR and scaling up.
%   This function calculates the number of pixels images B 
%   and G must shift both horizontally and vertically to align
%   with image R. It uses brute force alignment on smaller 
%   versions of the images and refines the shift values as it
%   looks at larger and larger versions of the images.

    pyrH = 4; % Depth of pyramid
    
    ranges = [20 -20;  % blue vertical range
              20 -20;  % green vertical range
              20 -20;  % blue horizontal range
              20 -20]; % green horizontal range
    
    for i = pyrH:-1:0
        scale = 1 / (2^i);
        tB = imresize(oldB, scale);
        tG = imresize(oldG, scale);
        tR = imresize(oldR, scale);
        [sizeH, sizeV] = size(tB);

        [ bv, bh, gv, gh ] = bfalign(tB, tG, tR, sizeH, sizeV, ranges);
        
        ranges = [ 2*(bv+1) 2*(bv-1);
                   2*(gv+1) 2*(gv-1);
                   2*(bh+1) 2*(bh-1);
                   2*(gh+1) 2*(gh-1) ];
    end

    newB = circshift(oldB, [bv bh]);
    newG = circshift(oldG, [gv gh]);
    newR = oldR;
    
end

