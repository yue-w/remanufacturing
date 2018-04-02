function [m_matrixNewNew,newRoute,newTotalScore] = findSubstituteRoute(m_matrixNew,row, column,numMC, sigma)
%the cell m_matrixNew(row, column)'s connectDown is brocken. This function
%will find a new route with highest score for it. This score is stored in 
%routeScore. And the new route is stored in m_matrixNewNew, with new total
%score stored in newTotalScore
    newRoute = 0;
    m_matrixNewNew = m_matrixNew;
    anchor =1;
    N = size(m_matrixNew,2);
    newTotalScore = computeTotalScore(m_matrixNew,true,numMC, sigma);
    while anchor<=N
        column1 = m_matrixNewNew(row+1,anchor).connectUp;
        if column1>0
            column2 = m_matrixNewNew(row,column1).connectDown; 
        else
            column2 = 0;
        end       
        if anchor~=column2
             %The cell m_matrixNew(row+1,anchor) is not connect to any cell
             %Check if the chain from this cell below is effective
             conflict = checkThisChain(m_matrixNewNew,row+1,anchor);
             if conflict==0
                 m_matrixNewNew(row+1,anchor).connectUp = column;
                 m_matrixNewNew(row,column).connectDown = anchor;
                 temTotalScore = computeTotalScore(m_matrixNewNew,true, numMC, sigma);
             else
                 temTotalScore = 0;
             end
        else
            anchor = anchor + 1;
            continue;
        end
        if newTotalScore<temTotalScore
            newTotalScore=temTotalScore;
            newRoute = anchor;
        end
        anchor = anchor + 1;
    end
end