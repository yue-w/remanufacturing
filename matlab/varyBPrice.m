function varyBPrice(m_matrix, maxIterate,tolerance, sampleSize,NUM,sigma,pBlocked,vecScale)
%This function test the effect of varying the price of buying missing
%components

    discount = 1;
    %The vector that store the cost of buying new component. The order is
    %Cylinder Block, Cylinder Head, Flywhell housing, Gearbox,
    %Connecting-rod, Crankshaft, Fly whell
    %vecPriceBase = [0.42 0.25 0.03 0.03 0.07 0.17 0.02];
    %The scale to increase the buying cost
    %vecScale = 0.5:0.5:10;
    expNum = size(vecScale,2);
    aveTotalScoreOpt = zeros(1,expNum);
    aveTotalScoreNon = zeros(1,expNum);    
    
    index = 1;
    for scale = vecScale
        totalScoreOpt = 0;
        totalScoreNon = 0;      
        for i = 1:sampleSize
            m_matrix = initMatrix(m_matrix,pBlocked);
            %Set the price of buying the blocked component
            m_matrix = setBuyingPrice(m_matrix,scale);
           [m_matrix, ~, scoreBeforeOpt, scoreAfterOpt]= iterate(m_matrix,maxIterate,discount,tolerance,NUM,sigma);
           totalScoreOpt = totalScoreOpt + scoreAfterOpt;
           totalScoreNon = totalScoreNon + scoreBeforeOpt;
        end        
        aveTotalScoreOpt(index) = totalScoreOpt/sampleSize;
        aveTotalScoreNon(index) = totalScoreNon/sampleSize;        
        index = index+1;
    end
    
   resultVector = [vecScale; aveTotalScoreOpt; aveTotalScoreNon];

    %Write the result to txt
    fileName = 'resultBuyingPrice';
    writeFile(resultVector, fileName); 
    
    %close all
    figure
    plot(vecScale,aveTotalScoreOpt,vecScale,aveTotalScoreNon);      
    

end