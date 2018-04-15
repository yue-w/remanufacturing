function counts = countScores(m_matrix, numCategory)
%Count the number of quality scores in m_matrix
    counts = zeros(1,numCategory);
    [~,N] = size(m_matrix);
    %Check each cell in the first row, it's score
    for col = 1:N
        value = m_matrix(1,col).value;
        
        if value>0
            counts(col) = value;
        end
    end

end