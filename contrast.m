function [ newB, newG, newR ] = contrast( oldB, oldG, oldR )
    newB = imadjust(oldB, [.1, .9],[]);
    newG = imadjust(oldG, [.1, .9],[]);
    newR = imadjust(oldR, [.1, .9],[]);
end

