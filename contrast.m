function [ newB, newG, newR ] = contrast( oldB, oldG, oldR )
%CONTRAST Adjusts the contrast of the input images.
%   This function uses imadjust to increase the 
%   contrast of the input images.

    newB = imadjust(oldB, [.1, .9],[]);
    newG = imadjust(oldG, [.1, .9],[]);
    newR = imadjust(oldR, [.1, .9],[]);
end

