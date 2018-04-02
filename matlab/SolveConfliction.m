function [m_matrixNewNew,newRoute,potentialTotal] = SolveConfliction(m_matrixNew,rowVal,columnVal,direction,competeColumn,numMC,sigma)
%The cell you want to connect to has already been connected
%by others.
%Then, change the matrix to the potential direction, and find
%a best substitute connection for the brocken connection
            originalDown = m_matrixNew(rowVal,columnVal).connectDown;
            m_matrixNew(rowVal,columnVal).connectDown = direction;
            m_matrixNew(rowVal+1,direction).connectUp = columnVal;
            
            %Because of the confliction, break the two original connections 
            m_matrixNew(rowVal,competeColumn).connectDown = 0;
            if originalDown > 0    &&  originalDown ~= direction               
                if m_matrixNew(rowVal+1,originalDown).connectUp == columnVal
                    m_matrixNew(rowVal+1,originalDown).connectUp = 0;
                end
            end
            [m_matrixNewNew,newRoute,potentialTotal] = findSubstituteRoute(m_matrixNew,rowVal,competeColumn,numMC,sigma);
end
  