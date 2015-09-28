function [ bv, bh, gv, gh ] = parbfalign( B, G, R, sizeH, sizeV, upperbv, lowerbv, uppergv, lowergv, upperbh, lowerbh, uppergh, lowergh)

    borderH = floor(.25 * sizeH);
    borderV = floor(.25 * sizeV);
    
    patchB = B(borderH:(sizeH-borderH), borderV:(sizeV-borderV));
    patchG = G(borderH:(sizeH-borderH), borderV:(sizeV-borderV));
    patchR = R(borderH:(sizeH-borderH), borderV:(sizeV-borderV));
     

   


    %Vertical shifting
    global_iv = 1;
    global_jv = 1;
    global_minv = inf;
    
    sizeB = upperbv - lowerbv;
    sizeG = uppergv - lowergv;
    
    avgs = Inf(sizeB, sizeG);

    parfor i = 1:sizeB
        tB = circshift(patchB, [i 0]);
        RB = ssd(patchR, tB);
        for j = 1:sizeG
            tG = circshift(patchG, [j 0]);
            GR = ssd(tG, patchR);
            GB = ssd(tG, tB);
            avg = GR + RB + GB;
            
            avgs(i,j) = avg;

        end
    end
    
    [M, I] = min(avgs(:));
    
    [row, col] = ind2sub(size(avgs),I);
    M
    I
    global_iv = col;
    global_jv = row;
    
    global_iv
    global_jv

    % Horizontal shifting
    global_ih = 1;
    global_jh = 1;
    global_minh = inf;

    for i = lowerbh:upperbh
        tB = circshift(patchB, [0 i]);
        RB = ssd(patchR, tB);
        for j = lowergh:uppergh
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

