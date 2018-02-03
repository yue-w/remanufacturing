function m_matrixNew = updateValuesSynchronous(m_matrix,rowVal,columnVal,connect,value)
        m_matrix(rowVal,columnVal).connectDown = connect;
        %m_matrix(rowVal+1,connect).connectUp = 0;
        if connect>0
            m_matrix(rowVal+1,connect).connectUp = columnVal;
            %m_matrix(rowVal+1,columnVal).connectUp = columnVal;
            m_matrix(rowVal,columnVal).value = value;
        else
            m_matrix(rowVal,columnVal).value = 0;
        end
        
        
        m_matrixNew = m_matrix;

end