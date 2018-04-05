function totalScore = computeTotalScoreSC(m_matrix, MC,NUMofMC, sigma)
%Compute total score, dismiss the columns with connection confliction
%If the score of a connection is less than 0, add the storage cost to the
%Cells that are not missing
    
    %The storage cost of one cell
    SC = 0.01;
    [M,N] = size(m_matrix);
    totalScore = 0;
    for column = 1:N
        scoreOfThisColumn = 0;
        conflict = false;      
        %anchor is the column that this cell connects to
        anchor = column;
        for row = 1:(M-1)
            downDirection = m_matrix(row, anchor).connectDown;
            upDirection =0;
            if downDirection~=0
                upDirection = m_matrix(row+1, downDirection).connectUp;
            end
            if anchor~=upDirection || m_matrix(row, anchor).connectDown ==0 
               conflict = true;
               break;
            end
            anchor = downDirection;
        end
        
        if conflict == false
              scoreOfThisColumn = computeCurrentValueColumSC(m_matrix,anchor,MC,NUMofMC,sigma,SC);
        end
        totalScore = totalScore + scoreOfThisColumn;

    end
end