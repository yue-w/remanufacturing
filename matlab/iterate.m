function [m_matrixNew, iteTimes, scoreBeforeOpt, scoreAfterOpt]=iterate(m_matrix,Max,discount, tolerance, NUM, sigma)
%Max is the iteration times
%
    [M,N]=size(m_matrix);
    iteTimes = 0;
    %Compute the values of each cell according to the current connections
    %Compute the total score of the initial connection
    m_matrix = updateValuesLastRow(m_matrix);
    scoreBeforeOpt = sumScoreFirstRow(m_matrix);
    optHistory = zeros(1,Max);
    
    for it=1:Max      
        %scoreFirstRowBefore = sumScoreFirstRow(m_matrix);
        %Value Iteration processes
        %The last component should be considered seperately
        for rowVal= 1:(M-1)
            for colVal = 1:N
                m_matrix= dostep(m_matrix,rowVal,colVal,discount,NUM, sigma);
            end
        end

        %Compute the value of the last row
        for colVal = 1:N
            m_matrix= dostepLastRow(m_matrix,colVal);
        end
        
        %Compute the values of each cell according to the current connections
        m_matrix = updateValuesLastRow(m_matrix);
        
        iteTimes = iteTimes + 1;
        
        %If the difference between two iteration is less than tolerance,
        %break the iteration
        
        %scoreFirstRowAfter = sumScoreFirstRow(m_matrix);
        
        if it>3
            %if the optimization hasn't change for 4 iterations, break
            if abs(optHistory(it)-optHistory(it-3)<tolerance)
                break;
            end
        end
        %
    end
    %Total score after optimization
    scoreAfterOpt = sumScoreFirstRow(m_matrix);
    m_matrixNew=m_matrix;
end