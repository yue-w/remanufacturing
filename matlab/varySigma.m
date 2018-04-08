function varySigma(m_matrix, maxIterate,tolerance, sampleSize,NUM,vecSigma,pBlocked)
%This function test the effect of varying the standard deviation of normal
%distribution in the inspecting processes.
    discount = 1;
    expNum = size(vecSigma,2);
    aveTotalScoreOpt = zeros(1,expNum);
    aveTotalScoreNon = zeros(1,expNum);
    index = 1;
    
    for sigma = vecSigma
        totalScoreOpt = 0;
        totalScoreNon = 0;  
        %Average samples
        for i = 1:sampleSize
            m_matrix = initMatrix(m_matrix,pBlocked);
            [m_matrix, ~, scoreBeforeOpt, scoreAfterOpt]= iterate(m_matrix,maxIterate,discount,tolerance,NUM,sigma);
           totalScoreOpt = totalScoreOpt + scoreAfterOpt;
           totalScoreNon = totalScoreNon + scoreBeforeOpt;            
        end
        
        aveTotalScoreOpt(index) = totalScoreOpt/sampleSize;
        aveTotalScoreNon(index) = totalScoreNon/sampleSize;        
        index = index+1;   
    end
    resultVector = [vecSigma; aveTotalScoreOpt; aveTotalScoreNon];
    
    %Write the result to txt
    fileName = 'resultSigma';
    writeFile(resultVector, fileName);
    
    
    %close all
    figure
    plot(vecSigma,aveTotalScoreOpt,vecSigma,aveTotalScoreNon);  

end