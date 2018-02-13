function totalScore = computeTotalScore(m_matrix)
%Compute total score, dismiss the columns with connection confliction
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
%             %If the score is less than 0, do not connect this line.
%             if m_matrix(1,column).value>0
%              scoreOfThisColumn = computeCurrentValueColum(m_matrix,column,anchor);
%             end
              scoreOfThisColumn = computeCurrentValueColum(m_matrix,anchor);
        end
        if(scoreOfThisColumn>0)
            totalScore = totalScore + scoreOfThisColumn;
        end
    end

end
% 
% function value = computeCurrentValueColum(m_matrix,column,anchor)
% discount = 1; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Modify!
% %Compute the score of this chain (Trace up from the last cell). Instead of just read the score of the
% %cell in the first row of this chain, this function compute the score by
% %the connections. Because the score in the cells might not have been updated yet.
%     m_matrixNew = m_matrix;
%     [M,N] = size(m_matrix);
%     row = M;
%     %m_matrixNew(row,anchor).connectUp = 
%     %score = 0;
%     while row>1
%         columnVal = m_matrix(row,anchor).connectUp;
%         row = row -1;
%         cost = 0; 
%         if m_matrixNew(row,columnVal).blocked == true
%             cost = costOpenCell(0,0,0);
%         end
%         m_matrixNew(row,columnVal).value = -cost + compute(m_matrixNew,row,columnVal,anchor,discount);
%         anchor = columnVal;
%     end
%     value = m_matrixNew(1,anchor).value;
% end