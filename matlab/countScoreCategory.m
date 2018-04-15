 function [countOpt, countRand] = countScoreCategory(m_matrix, maxIterate,tolerance, sampleSize,NUM,sigma,pBlocked)
 %This funciton calculate the count for the number of different scores
    discount = 1;
    numCategory = 5;
%     countOpt = zeros(1,numCategory);
%     countRand = zeros(1,numCategory);
    countRand = 0;
    countOpt = 0;
    
    for i = 1:sampleSize
        m_matrix = initMatrix(m_matrix,pBlocked);
        %Calculate the count for the number of different scores for 
        %the random policy
        m_matrix = updateValuesLastRow(m_matrix);
        temRandCnt = countScores(m_matrix, numCategory);
        countRand = [countRand, temRandCnt];
        %Calculate the count for the number of different scores for 
        %the optimal policy
        [m_matrix, ~, ~, ~]= iterate(m_matrix,maxIterate,discount,tolerance,NUM,sigma);
        temCountOpt = countScores(m_matrix, numCategory);
        countOpt = [countOpt,temCountOpt];
                    
    end
    length = size(countRand,2);
    countRand = countRand(1, 2:length);
    length = size(countOpt,2);
    countOpt = countOpt(1, 2:length);
    
 end