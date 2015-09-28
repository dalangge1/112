function [ newB, newG, newR ] = crossalign( oldB, oldG, oldR )
%CROSSALIGN Alignment of images B, G, and R using normalized 
%cross-correlation.
%   This function uses the normxcorr2 function built into
%   Matlab and finds the maximum correlation. It then finds
%   the difference between the current alignment and the 
%   alignment based on maximum correlation in order to shift
%   images B and G.

    sizeH = size(oldB, 2);
    sizeV = size(oldB, 1);

    borderH = floor(.25 * sizeH);
    borderV = floor(.25 * sizeV);
    
    patchB = oldB(borderV:(sizeV-borderV), borderH:(sizeH-borderH));
    patchG = oldG(borderV:(sizeV-borderV), borderH:(sizeH-borderH));

    % Shift image B
    RB = normxcorr2(patchB, oldR);
    [y, x] = find(RB==max(RB(:)));
    y = y-size(patchB,1);
    x = x-size(patchB,2); 
    by = -(borderV - y);
    bx = -(borderH - x);
    newB = circshift(oldB, [by bx]);
    
    %Shift image G
    RG = normxcorr2(patchG, oldR);
    [y, x] = find(RG==max(RG(:)));   
    y = y-size(patchG,1);
    x = x-size(patchG,2); 
    gy = -(borderV - y);
    gx = -(borderH - x);
    newG = circshift(oldG, [gy gx]);

    newR = oldR;

end

