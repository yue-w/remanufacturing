function outPut(m_matrix, iteraN,scoreBeforeOpt)
    [M,N] = size(m_matrix);
    for row = 1:M
        for column = 1:N
            value = m_matrix(row, column).value;
            up = m_matrix(row, column).connectUp;
            down = m_matrix(row, column).connectDown;
            buy = m_matrix(row, column).buy;
            blocked = m_matrix(row, column).blocked;
            fprintf('V:%.2f U:%d D:%d B:%d Buy:%d',value,up,down,blocked,buy );
            if column~=N
                fprintf(' |');
            end
        end      
        fprintf('\n');
    end
    totalScore = computeTotalScore(m_matrix);
    fprintf('Total score:%.2f.', totalScore);
    fprintf('    Initial total Score:%.2f.', scoreBeforeOpt);
    fprintf('    Iteration times:%.2f \n', iteraN);
end