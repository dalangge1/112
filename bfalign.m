function [ bv, bh, gv, gh ] = bfalign( B, G, R, sizeH, sizeV, ranges)
%BFALIGN Brute force alignment of images B, G, and R
%   This function calculates the number images B and G must shift
%   both horizontally and vertically to align with image R using 
%   the sum of squared differences.

    borderH = floor(.25 * sizeH);
    borderV = floor(.25 * sizeV);
    
    patchB = B(borderV:(sizeV-borderV), borderH:(sizeH-borderH));
    patchG = G(borderV:(sizeV-borderV), borderH:(sizeH-borderH));
    patchR = R(borderV:(sizeV-borderV), borderH:(sizeH-borderH));

    %Vertical shifting
    global_iv = 1;
    global_jv = 1;
    global_minv = inf;

    for i = ranges(1,2):ranges(1,1)
        tB = circshift(patchB, [i 0]);
        RB = ssd(patchR, tB);
        
        for j = ranges(2,2):ranges(2,1)
            tG = circshift(patchG, [j 0]);
            GR = ssd(tG, patchR);
            GB = ssd(tG, tB);
            avg = GR + RB + GB;
            
            if avg < global_minv
                global_minv = avg;
                global_iv = i;
                global_jv = j;
            end
        end
    end

    % Horizontal shifting
    global_ih = 1;
    global_jh = 1;
    global_minh = inf;

    for i = ranges(3,2):ranges(3,1)
        tB = circshift(patchB, [0 i]);
        RB = ssd(patchR, tB);
        
        for j = ranges(4,2):ranges(4,1)
            tG = circshift(patchG, [0 j]);
            GR = ssd(tG, patchR);
            GB = ssd(tG, tB);
            avg = GR + RB + GB;
            
            if avg < global_minh
                global_minh = avg;
                global_ih = i;
                global_jh = j;
            end
        end
    end
    
    bv = global_iv;
    bh = global_ih;
    
    gv = global_jv;
    gh = global_jh;
    
    

end

