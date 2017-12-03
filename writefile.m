function writefile(result)
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
end
    