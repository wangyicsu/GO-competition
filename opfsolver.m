    mat = csvread('generator.csv',1,2);
    MPC = psse2mpc('powersystem.raw');
    
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
    MPC_GO = MPC;
    
    
    result = runopf(MPC_GO);
    message_1 = '--generation dispatch\n';
    message_2 = 'bus id,unit id,pg(MW),qg(MVar)\n';
    message_3 = '--end of generation dispatch';
    formatSpec = '%d,''1 '',%f,%f\n';
    fileID = fopen('solution.txt','w');
    fprintf(fileID,message_1);
    fprintf(fileID,message_2);
    sizegen = size(result.gen);
    sizerow = sizegen(1,1);
    for i=1:sizerow
        fprintf(fileID, formatSpec, result.gen(i,1), result.gen(i,2),result.gen(i,3));
    end
    fprintf(fileID,message_3);
