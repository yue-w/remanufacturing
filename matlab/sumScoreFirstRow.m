function scoreFirstRow = sumScoreFirstRow(m_matrix)
%This function sums the value of the cells in the first row. Make sure that
%the values of all the cells have been updated before calling this function
%updated.
    scoreFirstRow = 0;
    N=size(m_matrix,2);
    for col = 1:N
        scoreFirstRow = scoreFirstRow + m_matrix(1,col).value;
    end

end