%THIS IS A DATA FORMATTING FILE TO PREPARE THE PARAMETERS
% FOR THE IPOPT SOLVER

filenameCSV = 'SEIR.csv';

final = zeros(length(t),1); final(end) = 1;


HEADER = {'time','final'};
HEADER = [HEADER;repmat({','},1,numel(HEADER))]; %insert commaas
HEADER(end)=[];
HEADER = HEADER(:)';
HEADER = cell2mat(HEADER); %cHeader in text with commas

fid = fopen(filenameCSV,'w'); 
fprintf(fid,'%s\n',HEADER);
fclose(fid);
dlmwrite(filenameCSV,[t',final],'-append');

clearvars HEADER final fid;