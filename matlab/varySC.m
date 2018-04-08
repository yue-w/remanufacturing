function varySC(m_matrix, maxIterate,tolerance, sampleSize,NUM,sigma)
%This function varies the houding cost(storage cost) of unused components
    discount = 1;
    scVec = 0:0.05:0.6;
    expNum = size(scVec,2);
    aveTotalScoreOpt = zeros(1,expNum);
    aveTotalScoreNon = zeros(1,expNum);
    index = 1;
    %The probability that each cell be blocked
    p = 0.2;
    
    for sc = scVec
        totalScoreOpt = 0;
        totalScoreNon = 0;  
        %Average samples
        for i = 1:sampleSize
            m_matrix = initMatrix(m_matrix,p);
            [m_matrix, ~, scoreBeforeOpt, scoreAfterOpt]= iterate(m_matrix,maxIterate,discount,tolerance,NUM,sigma);
           totalScoreOpt = totalScoreOpt + scoreAfterOpt;
           totalScoreNon = totalScoreNon + scoreBeforeOpt;            
        end
        
        aveTotalScoreOpt(index) = totalScoreOpt/sampleSize;
        aveTotalScoreNon(index) = totalScoreNon/sampleSize;        
        index = index+1;   
    end
   resultVector = [scVec; aveTotalScoreOpt; aveTotalScoreNon];
   %Write the result to txt
    fileID = fopen('resultSC.txt','w');
    fprintf(fileID,'%2s %3s %7s\n','SC ',' OPT', 'NON-OPT');
    fprintf(fileID,'%3.2f %6.3f %6.3f\n',resultVector);
    fclose(fileID);

    %close all
    figure
    plot(scVec,aveTotalScoreOpt,scVec,aveTotalScoreNon);  
end