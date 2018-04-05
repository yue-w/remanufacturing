function [value,valuesUpDown] = computeCurrentValueColumSC(m_matrix,anchor,MC,NUM,sigma,SC)%SC is storage cost.
discount = 1;
%Compute the score of this chain (Trace up from the last cell). Instead of just read the score of the
%cell in the first row of this chain, this function compute the score by
%the connections. Because the score in the cells might not have been updated yet.
%All the values of the cells in this chain is stored in valuesUpDown, from
%the first row to the last row
%This function considers the storage cost. If the the score of this chain
%is less than zero, the components might not be used, then, a storage cost
%will be added to the chain. The score of this chain will still be
%negative. the bigger one of these two negative scores will be chosed.
    anchorBackup = anchor;
    m_matrixNew = m_matrix;
    [M,N] = size(m_matrix);
    valuesUpDown = zeros(M,1);
    row = M;
    %m_matrixNew(row,anchor).connectUp = 
    %score = 0;
    while row>1
        columnVal = m_matrix(row,anchor).connectUp;
        row = row -1;
        cost = 0; 
        if (row>0 && columnVal>0)
            %If the uper cell is blocked.
            if m_matrixNew(row,columnVal).blocked == true
                cost = costOpenCell(m_matrix, row,columnVal);
                
            end            
        end
        if (row>0 && columnVal>0)
            %Whether Monte Carlo is used
            if MC == false
                temV = -cost + compute(m_matrixNew,row,columnVal,anchor,discount);
            else
                temV = -cost + compute_MC(m_matrixNew,row,columnVal,anchor,NUM,sigma);
            end
                       
            m_matrixNew(row,columnVal).value = temV;
            valuesUpDown(row) = temV;
            anchor = columnVal;
        end
    end
    valueBuy = m_matrixNew(1,anchor).value;

    %If the score this chain is less than 0
    %number of unused components   
    numOfUnusedC = 0;
    if valueBuy<0
            row = M;
            %Consider whether the last row is blocked. If not, add a storage
            %cost 
            anchor2 = anchorBackup;
            if m_matrixNew(row,anchor2).blocked == false
                numOfUnusedC = numOfUnusedC + 1;
            end       
            %Consider whetehr this cell is blocked. If not, add a storage
            %cost 
            while row>1
                columnVal = m_matrix(row,anchor2).connectUp;
                row = row -1;
                if (row>0 && columnVal>0)
                    %If the uper cell is blocked.
                    if m_matrixNew(row,columnVal).blocked == false
                        numOfUnusedC = numOfUnusedC + 1;
                    end            
                end
                anchor2 = columnVal;
            end       
    end
    valueNotBuy = - SC * numOfUnusedC;
    value = max([valueBuy valueNotBuy]);
end