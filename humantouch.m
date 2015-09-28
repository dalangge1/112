function [ newB, newG, newR ] = humantouch( oldB, oldG, oldR )
%HUMANTOUCH User alignment of input images.
%   This function prompts the user to select the location of
%   the same prominent feature on the three input images.
%   It then uses the pixel differences in these three locations
%   to align the images.

    figure
    title('Choose a well-defined point in the image.');
    imshow(oldB)
    [xB, yB] = ginput(1);
    close

    figure
    title('Now select the initial point in this image.');
    imshow(oldG)
    [xG, yG] = ginput(1);
    close

    figure
    title('Select the inital point in this image.');
    imshow(oldR)
    [xR, yR] = ginput(1);
    close

    

    shiftxB = floor(xR - xB);
    shiftyB = floor(yR - yB);
    
    shiftxG = floor(xR - xG);
    shiftyG = floor(yR - yG);
    
    newB = circshift(oldB, [shiftyB shiftxB]);
    newG = circshift(oldG, [shiftyG shiftxG]); 
    newR = oldR;

end

