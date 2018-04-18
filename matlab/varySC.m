function varySC(m_matrix, maxIterate,tolerance, sampleSize,NUM,sigma,pBlocked,scVec)
%This function varies the houding cost(storage cost) of unused components
    discount = 1;
    %scVec = 0:0.05:0.6;
    expNum = size(scVec,2);
    aveTotalScoreOpt = zeros(1,expNum);
    aveTotalScoreNon = zeros(1,expNum);
    index = 1;
    scale = 4;
    for sc = scVec
        totalScoreOpt = 0;
        totalScoreNon = 0;  
        %Average samples
        for i = 1:sampleSize
            m_matrix = initMatrix(m_matrix,pBlocked);
            m_matrix = setBuyingPrice(m_matrix,scale);
            [m_matrix, ~, scoreBeforeOpt, scoreAfterOpt]= iterate(m_matrix,maxIterate,discount,tolerance,NUM,sigma);
           totalScoreOpt = totalScoreOpt + scoreAfterOpt;
           totalScoreNon = totalScoreNon + scoreBeforeOpt;            
        end
        
        aveTotalScoreOpt(index) = totalScoreOpt/sampleSize;
        aveTotalScoreNon(index) = totalScoreNon/sampleSize;        
        index = index+1;   
    end
    resultVector = [scVec; aveTotalScoreOpt; aveTotalScoreNon];
    
    fileName = 'resultSC';
    writeFile(resultVector, fileName);

    
    %close all
    figure
    plot(scVec,aveTotalScoreOpt,scVec,aveTotalScoreNon);  
end