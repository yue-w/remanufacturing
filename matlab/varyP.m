function varyP(m_matrix, maxIterate,tolerance, sampleSize,NUM,sigma)
%This function varies the probability that the cells be missing
%Set the probability that the cell be missing
    discount = 1;
    pVec = 0:0.1:1;
    expNum = size(pVec,2);
    aveTotalScoreOpt = zeros(1,expNum);
    aveTotalScoreNon = zeros(1,expNum);

    index = 1;
    for p = pVec
        totalScoreOpt = 0;
        totalScoreNon = 0;      
        %Average samples
        for i = 1:sampleSize
            m_matrix = initMatrix(m_matrix,p);
            %Modify the probability of cells be blocked(missing)
            m_matrix = initpBlocked(m_matrix,p);
           [m_matrix, ~, scoreBeforeOpt, scoreAfterOpt]= iterate(m_matrix,maxIterate,discount,tolerance,NUM,sigma);
           totalScoreOpt = totalScoreOpt + scoreAfterOpt;
           totalScoreNon = totalScoreNon + scoreBeforeOpt;
        end        
        aveTotalScoreOpt(index) = totalScoreOpt/sampleSize;
        aveTotalScoreNon(index) = totalScoreNon/sampleSize;        
        index = index+1;
    end
    
   resultVector = [pVec; aveTotalScoreOpt; aveTotalScoreNon];
   %Write the result to txt
    fileID = fopen('resultP.txt','w');
    fprintf(fileID,'%1s %3s %7s\n','P ',' OPT', 'NON-OPT');
    fprintf(fileID,'%3.2f %6.3f %6.3f\n',resultVector);
    fclose(fileID);

    %close all
    figure
    plot(pVec,aveTotalScoreOpt,pVec,aveTotalScoreNon);    
    
end