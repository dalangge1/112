function [ newB, newG, newR ] = pyramidalign( oldB, oldG, oldR )
    
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
    
    blueshift = [bv bh]
    greenshift = [gv gh]

end

