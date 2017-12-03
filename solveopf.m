function result = solveopf
    mat = csvread('generator.csv',1,2);
    MPC = psse2mpc('powersystem.raw');
    MPC_GO = changemate(mat,MPC);
    result = runopf(MPC_GO);
    writefile(result);
end
  