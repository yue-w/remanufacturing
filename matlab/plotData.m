function plotData
%This function plot the data

%     %Current directory
    directory = pwd;
    directory = fullfile(directory,'\data\');


%     nameN = 'resultSampleSize.csv';
%     directoryN = strcat(directory,nameN);
%     dataN = csvread(directoryN) ;
%     sizeN = dataN(1,:);
%     optScoreN =  dataN(2,:);
%     randNScore =  dataN(3,:);
%     figure
%     % colorOpt = [1, 0, 0];
%     % colorRand = [0, 0, 1];
%     plot(sizeN,optScoreN,'r--o',sizeN,randNScore,'b--o');
%     title('Sample size')
%     xlabel('sample size')
%     ylabel('W')
    
    
%     nameN = 'resultBuyingPrice.csv';
%     directoryN = strcat(directory,nameN);
%     dataN = csvread(directoryN) ;
%     sizeN = dataN(1,:);
%     optScoreN =  dataN(2,:);
%     randNScore =  dataN(3,:);
%     figure
%     % colorOpt = [1, 0, 0];
%     % colorRand = [0, 0, 1];
%     plot(sizeN,optScoreN,'r--o',sizeN,randNScore,'b--o');
%     title('Price of new components')
%     xlabel('price')
%     ylabel('W')
    
%     nameN = 'resultP.csv';
%     directoryN = strcat(directory,nameN);
%     dataN = csvread(directoryN) ;
%     sizeN = dataN(1,:);
%     optScoreN =  dataN(2,:);
%     randNScore =  dataN(3,:);
%     figure
%     % colorOpt = [1, 0, 0];
%     % colorRand = [0, 0, 1];
%     plot(sizeN,optScoreN,'r--o',sizeN,randNScore,'b--o');
%     title('Probability of missing')
%     xlabel('missing probability')
%     ylabel('W')   

    nameN = 'resultSC.csv';
    directoryN = strcat(directory,nameN);
    dataN = csvread(directoryN) ;
    sizeN = dataN(1,:);
    optScoreN =  dataN(2,:);
    randNScore =  dataN(3,:);
    figure
    % colorOpt = [1, 0, 0];
    % colorRand = [0, 0, 1];
    plot(sizeN,optScoreN,'r--o',sizeN,randNScore,'b--o');
    title('Holding cost')
    xlabel('Holding cost')
    ylabel('W')      

%     nameN = 'resultSigma.csv';
%     directoryN = strcat(directory,nameN);
%     dataN = csvread(directoryN) ;
%     sizeN = dataN(1,:);
%     optScoreN =  dataN(2,:);
%     randNScore =  dataN(3,:);
%     figure
%     % colorOpt = [1, 0, 0];
%     % colorRand = [0, 0, 1];
%     plot(sizeN,optScoreN,'r--o',sizeN,randNScore,'b--o');
%     title('Standard deviation')
%     xlabel('standard deviation')
%     ylabel('W') 
    
end