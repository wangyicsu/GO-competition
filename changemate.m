function MPC_new = changemate(mat,MPC)
    sizemat = size(mat);
    k = 1;
    j = 1;
    key = 1;
    for i = 1:sizemat(1,1)
        if mat(i,1) ~= 9
            f(k,j) = mat(i,2);
            j = j + 1;
            if j>key
                key = j-1;
            end
        end
        if mat(i,1) == 9
            k = k+1;
            j = 1;
        end
    end
    sizef = size(f);
    for i = 1:sizef(1,1)
        f(i,sizef(1,2)+1)=key;
        f(i,sizef(1,2)+2)=0;
        f(i,sizef(1,2)+3)=0;
        f(i,sizef(1,2)+4)=2;
    end
    sizef_new = size(f);
    n = sizef_new(1,1);
    m = sizef_new(1,2);
    for p = 1:n
        for q = 1:m
            k(p,q) = f(p, m-q+1);
        end      
    end
    k(1,q+1) = 0;
    [MPC(:).gencost] = k;
    MPC_new = MPC;
end