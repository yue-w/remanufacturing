function m_matrixNew=iterate(m_matrix,Max,discount)
%Max is the iteration times
%
    [M,N]=size(m_matrix);
    for it=1:Max
        %Value Iteration processes
        %The last component should be considered seperately
        for rowVal= 1:(M-1)
            for colVal = 1:N
                m_matrix= dostep(m_matrix,rowVal,colVal,discount);
            end
        end

        %Compute the value of the last row
        for colVal = 1:N
            m_matrix= dostepLastRow(m_matrix,colVal);
        end
        %Compute the values of each cell according to the current connections
        m_matrix = updateValues(m_matrix);
    end
    m_matrixNew=m_matrix;
end