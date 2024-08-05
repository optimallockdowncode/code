%Write the APM file 

filenameAPM = 'SEIR.apm';

fid = fopen(filenameAPM,'w');

%% write ipopt options
fprintf(fid,'File ipopt.opt\n');
for i = 1:size(ipopt,1)
fprintf(fid,'\t%s %i \n',ipopt{i,1},ipopt{i,2}); 
end
fprintf(fid,'End File\n\n');

%% write parameters
fprintf(fid,'Parameters\n');
for i = 1:size(Parameters,1)
    fprintf(fid,'\t%s',Parameters{i,1});
    if ~isequal(Parameters{i,2},'')
       fprintf(fid,' = %f',Parameters{i,2});
    end
    if ~isequal(Parameters{i,3},'')
       fprintf(fid,' , %s',Parameters{i,3});
    end
    fprintf(fid,'\n');
end
fprintf(fid,'\n');

%% write constants
fprintf(fid,'Constants\n');
for i = 1:size(Constants,1)
    fprintf(fid,'\t%s = %f\n',Constants{i,1},Constants{i,2});
end
fprintf(fid,'\n');

%% write variables
fprintf(fid,'Variables\n');
for i = 1:size(Variables,1)
   fprintf(fid,'\t%s = %f',Variables{i,1},Variables{i,2});
   if ~isequal(Variables{i,3},'')
      fprintf(fid,' , %s',Variables{i,3}); 
   end
   fprintf(fid,'\n');
end
fprintf(fid,'\n');

%% write intermediates
fprintf(fid,'Intermediates\n');
for i = 1:size(Intermediates,1)
    fprintf(fid,'\t%s\n',Intermediates{i,1}); 
end
fprintf(fid,'\n');

%% write equations
fprintf(fid,'Equations\n');
fprintf(fid,'\t%s\n\n',Equations{1,1});
for i = 2:size(Equations,1)
   fprintf(fid,'\t%s\n',Equations{i,1}); 
end

fclose(fid);

clearvars fid;



