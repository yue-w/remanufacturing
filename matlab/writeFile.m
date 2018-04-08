function writeFile(resultVector, fileName)
%This function save the data to file 
    %Write the result to txt
    directory = pwd;%Current directory
    directory = fullfile(directory,'\data');
    filename  =  strcat(fileName,'.txt');
    fileDest  = fullfile(directory,filename);  
    fileID = fopen(fileDest,'w');
    fprintf(fileID,'%2s %3s %7s\n','SC ',' OPT', 'NON-OPT');
    fprintf(fileID,'%3.2f %6.3f %6.3f\n',resultVector);
    fclose(fileID);

    %Write the result to csv
    filenameCSV = strcat(fileName,'.csv');
    fileDestCSV  = fullfile(directory,filenameCSV);  
    csvwrite(fileDestCSV,resultVector);
end