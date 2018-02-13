function m_matrixNew=iterateSynchronous(m_matrix,Max,discount)
%Max is the iteration times
%
    [M,N]=size(m_matrix);
        totalScoreMax = computeTotalScore(m_matrix);
        row = 1;
        column = 1;
        connect = 1;
    for it=1:Max
        %Value Iteration processes
        %The last component should be considered seperately
%         %Iteration Method 1. Ordered iteration
%         for rowVal= 1:(M-1)
%             for colVal = 1:N
%                 [~,valueMax,connectTem,value]= dostepSynchronous(m_matrix,rowVal,colVal,discount);                
%                 if totalScoreMax<=valueMax
%                     totalScoreMax = valueMax;
%                     row = rowVal;
%                     column = colVal;
%                     connect = connectTem;                    
%                 end
%             end
%         end

%        %Iteration Method 2. Random iteration
        rowRand = randperm(M-1);
        colRand = randperm(N);
        rowIndex = 1;
        while (rowIndex<M)            
            rowVal = rowRand(rowIndex);
            colIndex = 1;
            while (colIndex<=N)
                colVal = colRand(colIndex);
                [~,valueMax,connectTem,value]= dostepSynchronous(m_matrix,rowVal,colVal,discount);                
                if totalScoreMax<=valueMax
                    totalScoreMax = valueMax;
                    row = rowVal;
                    column = colVal;
                    connect = connectTem;                    
                end
                colIndex = colIndex + 1;
            end
            rowIndex = rowIndex + 1;
        end
        
        m_matrix= updateValuesSynchronous(m_matrix,row,column,connect,value);        
        m_matrix = findAndConnectPatches(m_matrix);  
        
        %Compute the value of the last row
        for colVal = 1:N
            m_matrix= dostepLastRow(m_matrix,colVal);
        end
        %Compute the values of each cell according to the current connections
        m_matrix = updateValuesLastRow(m_matrix);
    end
    m_matrixNew=m_matrix;
end