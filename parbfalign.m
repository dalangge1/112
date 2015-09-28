function [ bv, bh, gv, gh ] = parbfalign( B, G, R, sizeH, sizeV, ranges)

    borderH = floor(.25 * sizeH);
    borderV = floor(.25 * sizeV);
    
    patchB = B(borderH:(sizeH-borderH), borderV:(sizeV-borderV));
    patchG = G(borderH:(sizeH-borderH), borderV:(sizeV-borderV));
    patchR = R(borderH:(sizeH-borderH), borderV:(sizeV-borderV));

    %Vertical shifting
    global_iv = 1;
    global_jv = 1;
    global_minv = inf;
    
    sizeB = ranges(1,1) - ranges(1,2);
    sizeG = ranges(2,1) - ranges(2,2);
    
    avgs = Inf(sizeB, sizeG);
    

    for i = ranges(1,2):ranges(1,1)
        shifti = i - ranges(1,2) + 1;
        tB = circshift(patchB, [i 0]);
        RB = ssd(patchR, tB);
        for j = ranges(2,2):ranges(2,1)
            shiftj = j - ranges(1,2) + 1;
            tG = circshift(patchG, [j 0]);
            GR = ssd(tG, patchR);
            GB = ssd(tG, tB);
            avg = GR + RB + GB;
            if (avg < 1)
                avg
            end
            avgs(shifti,shiftj) = avg;
            if avg < global_minv
                global_minv = avg;
                global_iv = i;
                global_jv = j;
            end
        end
    end
    
%     [M, I] = min(avgs(:));
%     [row, col] = ind2sub(size(avgs),I);
%     row
%     col

%     global_iv = i;
%     global_jv = j;

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
