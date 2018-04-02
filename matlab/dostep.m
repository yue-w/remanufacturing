function m_matrixNew=dostep(m_matrix,rowVal,columnVal,discount, NUM,sigma)
    [M,N] =  size(m_matrix);
    
    %If the current cell is blocked    
    if m_matrix(rowVal,columnVal).blocked == true
        %The cost of opening cell (buying new component) Sij. 
        gij = -costOpenCell(m_matrix,rowVal,columnVal);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        [connect,value,update]= do4(m_matrix,rowVal,columnVal,discount,NUM, sigma); 
        %v = compute(m_matrix,rowVal,columnVal,connect,discount);
        v = compute_MC(m_matrix,rowVal,columnVal,connect,NUM,sigma);
        
        valueWithCost = gij+v;
        
        %If it's first row, only conncet the cells when score is positive,
        %if it's not first row, connect the cells whithour checking the
        %score. Because negative score in the lower rows might have
        %positive revenue if the chain is finished.
        if rowVal ==1
            m_matrix = checkPositiveScoreFirstRow(m_matrix,rowVal,columnVal,connect,valueWithCost);
        else
            if update ==true
                m_matrix =upDateValues(m_matrix,rowVal,columnVal,connect,valueWithCost); 
%                 %Test: connect all the cells that have not been connected by a line
%                 m_matrix = findAndConnectPatches(m_matrix);
            end
                 %Test: connect all the cells that have not been connected by a line
                 m_matrix = findAndConnectPatches(m_matrix);           
        end
        if valueWithCost>0
            m_matrix(rowVal,columnVal).buy = true;
        end
            %m_matrix(rowVal,columnVal).buy = true;

    %If the current cell is not blocked
    else %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          [connect,value,update]= do4(m_matrix,rowVal,columnVal,discount,NUM,sigma);

            if update ==true
                m_matrix= upDateValues(m_matrix,rowVal,columnVal,connect,value);
%                 %Test: connect all the cells that have not been connected by a line
%                 m_matrix = findAndConnectPatches(m_matrix);               
            end
                %Test: connect all the cells that have not been connected by a line
                 m_matrix = findAndConnectPatches(m_matrix);             
    end   
    m_matrixNew = m_matrix;
end

function [connect,combinationValue, update] = do4(m_matrix,rowVal,columnVal,discount, NUM, sigma)
    connect = m_matrix(rowVal,columnVal).connectDown;
    %connect = 0;
%     connectD = m_matrix(rowVal,columnVal).connectDown;
%     if connectD>0
%         connectU = m_matrix(rowVal,connectD).connectUp;
%     else
%         connectU = 0;
%     end
%     if connectU == columnVal
%         connect = connectD;
%     else
%         connect = 0;
%     end
    MC = true;
    combinationValue = 0;
    m_matrix(rowVal,columnVal).buy = false;
    valueMax = computeTotalScore(m_matrix,MC,NUM,sigma);
    N=size(m_matrix,2);

    changedOnce = false;
    
    for direction = 1:N
        m_matrixNew = m_matrix;
        competeColumn = m_matrix(rowVal+1,direction).connectUp;
        if competeColumn == 0 %|| competeColumn == direction
            %there is no confliction. compute total score of new
            %combination
            m_matrixNew(rowVal,columnVal).connectDown = direction;
            m_matrixNew(rowVal+1,direction).connectUp = columnVal;
            m_matrixNew = findAndConnectPatches(m_matrixNew);
            potentialTotal = computeTotalScore(m_matrixNew,MC, NUM, sigma);
            
        elseif competeColumn == columnVal
            %there is no confliction. compute total score of new
            %combination
            m_matrixNew(rowVal,columnVal).connectDown = direction;
            m_matrixNew(rowVal+1,direction).connectUp = columnVal;
            potentialTotal = computeTotalScore(m_matrixNew,MC,NUM, sigma); 
            
        else       
               effective = checkEffectiveConnection(m_matrix,rowVal,direction);
               if effective == true
                   %The cell you want to connect to has already been connected
                   %by others.
                   %Then, change the matrix to the potential direction, and find
                   %a best substitute connection for the brocken connection                  
                   [m_matrixNew,newRoute,potentialTotal] = SolveConfliction(m_matrixNew,rowVal,columnVal,direction,competeColumn,NUM, sigma);
               else
                    %there is no confliction. compute total score of new
                    %combination
                    m_matrixNew(rowVal,columnVal).connectDown = direction;
                    m_matrixNew(rowVal+1,direction).connectUp = columnVal;
                    potentialTotal = computeTotalScore(m_matrixNew,MC,NUM, sigma);                  
               end

        end
        
       

        if valueMax <= potentialTotal
         %if this new direction has higher total value, update.
            connect = direction;
            %combinationValue = compute(m_matrixNew,rowVal,columnVal,connect,discount);
            
            combinationValue = compute_MC(m_matrixNew,rowVal,columnVal,connect,NUM,sigma);
            
            valueMax = potentialTotal;
            
            %Whether the connection has changed once
            changedOnce = true;
        end
       

    end

    %if none of the different connections improves the score, it means
    %this cell should not connect to any cell, and no cell should connect
    %to it. So, do not update the connection.
    if changedOnce == true
        update = true;   
    else
        update = false;
    end
end

% function [connectChecked,valueChecked] = checkDuplicity(m_matrix,rowVal,columnVal,connect, value )
% %Check whether the cell will connected to has been connected to other cells whose
% %column is higher
%     competeColumn = m_matrix(rowVal+1,connect).connectUp;
%     if competeColumn~=columnVal && competeColumn~=0
%         competeValue= m_matrix(rowVal,competeColumn).value;
%         %If the cell whose column is higher also has higher value
%         if competeValue>value
%             connectChecked = 0;
%             valueChecked = 0;
%         else
%             connectChecked = connect;
%             valueChecked = value;            
%         end
%     else
%         connectChecked = connect;
%         valueChecked = value;
%     end
% end

% function update = conflictCheck(m_matrix,rowVal,columnVal,potentialConnect, value,discount)
% %Check whether the cell that will be connected with has been connected by
% %another cell that has higher value
%     competeColumn = m_matrix(rowVal+1,potentialConnect).connectUp;
%     if competeColumn~=columnVal && competeColumn~=0%236
%             competeValue = compute(m_matrix,rowVal,competeColumn,potentialConnect,discount);
%             %If the cell whose column is higher also has higher value
%             if competeValue>value
%                 %Method one: check whether the compete cell is blocked, if it
%                 %is, add the cost to the value
%                 if m_matrix(rowVal,competeColumn).blocked == true
%                      costOpenCompete = costOpenCell(m_matrix,rowVal,competeColumn);%Now, assume the cost is constant
%                      competeValue = competeValue -costOpenCompete;
%                 end
% 
%                 if m_matrix(rowVal,columnVal).blocked == true
%                     costOpenValue = costOpenCell(m_matrix,rowVal,columnVal);%Now, assume the cost is constant
%                     value  = value - costOpenValue;
%                 end
%                     
%                  if competeValue>value                    
%                     update=false;
%                  else
%                      update=true;
%                  end
% 
%                 %Method two: check the total score(revenue)
%                 %To be tested
% 
%             else
%                % update = true;
%                %***************************************************************
%                 %Method one: check whether the compete cell is blocked, if it
%                 %is, add the cost to the value
%                 if m_matrix(rowVal,competeColumn).blocked == true
%                      costOpenCompete = costOpenCell(m_matrix, rowVal,competeColumn);%Now, assume the cost is constant
%                      competeValue = competeValue -costOpenCompete;
%                 end
% 
%                 if m_matrix(rowVal,columnVal).blocked == true
%                     costOpenValue = costOpenCell(m_matrix,rowVal,columnVal);%Now, assume the cost is constant
%                     value  = value - costOpenValue;
%                 end
%                     
%                  if competeValue>value                    
%                     update=false;
%                  else
%                      update=true;
%                  end
% 
%                 %Method two: check the total score(revenue)
%                 %To be tested
%                 
%                 %***************************************************************
%             end
%     else
%         update = true;
%     end
% end

% function update = conflictCheck2(m_matrix,rowVal,columnVal,potentialConnect, value,discount,connect)
% %Check whether the cell that will be connected with has been connected by
% %another cell that has higher value
%     competeColumn = m_matrix(rowVal+1,potentialConnect).connectUp;
%     if competeColumn~=columnVal && competeColumn~=0%236
%             competeValue = compute(m_matrix,rowVal,competeColumn,potentialConnect,discount);
%             %If the cell whose column is higher also has higher value
%             if competeValue>value
%                 %update=false;%Wait a minute, this new connection might open a new product
%                 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                 totalScoreHigher = checkTotalScore2(m_matrix,rowVal,columnVal,competeColumn,potentialConnect);
%                 if totalScoreHigher == true
%                     update=true;
%                 else
%                     update=false;
%                 end
%                 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%             else
%                 %update=true;%Wait a minute, this new connection might open a new product
%                 totalScoreHigher = checkTotalScore2(m_matrix,rowVal,columnVal,competeColumn,potentialConnect);
%                  if totalScoreHigher == true
%                      update=true;
%                  else
%                    update=false;
%                  end
%             end
%     else
%         update=true;%Wait a minute
% %         totalScoreHigher = checkTotalScore(m_matrix,rowVal,columnVal,connect,potentialConnect);
% %          if totalScoreHigher == true
% %              update=true;
% %          else
% %            update=false;
% %          end
%     end
% end

% function totalIncrease = totalValueCheck(m_matrix,rowVal,columnVal,potentialConnect, value,discount)
% %Check whether the total value will increase if a new connection will be
% %made
%     totalIncrease = false;
%     competeColumn = m_matrix(rowVal+1,potentialConnect).connectUp;
%     if competeColumn~=columnVal %%&& competeColumn~=0
%         %competeValue = compute(m_matrix,rowVal,competeColumn,potentialConnect,discount);
%         competeTotal = computeTotalScore(m_matrix);
%         m_matrixNew = m_matrix;
%         m_matrixNew(rowVal,columnVal).connectDown = potentialConnect;
%         m_matrixNew(rowVal+1,potentialConnect).connectUp = columnVal;
%         newTotal = computeTotalScore(m_matrixNew);
%         if newTotal>=competeTotal
%           totalIncrease = true;  
%         end
%     end
%       
% end
% function increase = increaseCheck(m_matrix,rowVal,columnVal,direction,oldValue,newValue,discount)
% %Check whether the rewards of this new connection is higher when the lost of breaking
% %the old connection been considered
%     competeColumn = m_matrix(rowVal + 1,direction).connectUp;
%     if competeColumn~=columnVal && competeColumn~=0
%         lostVal = compute(m_matrix,rowVal,competeColumn,direction,discount);
%         %Making this combination means breaking an existing connection and lost
%         %the corresponding reward.
%         potentialVal = newValue - lostVal;
%         if potentialVal > oldValue 
%             increase = true;
%         else
%             increase = false;
%         end   
%     else
%         increase = true;
%     end
% end

% function totalScoreHigher = checkTotalScore(m_matrix,rowVal,columnVal,oldDirection, newDirection)
% 
%     currentScore = computeTotalScore(m_matrix);
%     totalScoreHigher = false;
%     m_matrixOld = m_matrix;
%     m_matrixOld(rowVal,columnVal).connectDown = oldDirection;
%     if oldDirection~=0
%         m_matrixOld(rowVal+1,oldDirection).connectUp = columnVal; %Wait a second, this cell might not connect up to m_matrix(rowVal,columnVal)
%     end
%     
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     %Add some code to check the potential connection. Because oldDirection
%     %is just potential direction, the cell it want to connect to might not
%     %connect back to it (see comment on line 329). So there mingt be
%     %potential connctions.
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%      oldTotal = computeTotalScore(m_matrixOld);
%      currentUp = m_matrix(rowVal,oldDirection).connectUp;  
%      %score1 = checkPotentialRout(m_matrix,rowVal,currentUp, oldDirection);
% 
%     matrixNewNew = m_matrix;
%     matrixNewNew(rowVal,columnVal).connectDown = newDirection;
%     matrixNewNew(rowVal+1,newDirection).connectUp = columnVal;
%     %Old connections might be broken. And new connections might be made,
%     %but the score is not calculated. Add it.
%     score = checkPotentialRout(m_matrixOld,rowVal,oldDirection, newDirection);
%     
%     newTotal = computeTotalScore(matrixNewNew);
%     
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% %If the following codes are commented, the cases with at most one cell blocked will work. the
% %case with two blocked cells will not work.
%     if score<0
%         score = 0;
%     end
%     newTotal = score + computeTotalScore(matrixNewNew);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
% 
%     if oldTotal<newTotal
%         totalScoreHigher = true;
%     end
% end

% function totalScoreHigher = checkTotalScore2(m_matrix,rowVal,columnVal,oldDirection, newDirection)
% 
%     competeColum = m_matrix(rowVal+1,oldDirection).connectUp;
%     score1 = 0;
%     if competeColum~= oldDirection
%         %score1 = checkPotentialRoutCompareExisting(m_matrix,rowVal,columnVal,oldDirection);
%         score1 = checkPotentialRout(m_matrix,rowVal,oldDirection, newDirection);
%     end
%     totalScoreHigher = false;
%     m_matrixOld = m_matrix;
%     m_matrixOld(rowVal,columnVal).connectDown = oldDirection;
%     if oldDirection~=0
%         m_matrixOld(rowVal+1,oldDirection).connectUp = columnVal; %Wait a second, this cell might not connect up to m_matrix(rowVal,columnVal)
%     end
%      oldTotal = computeTotalScore(m_matrixOld);
%      
%      currentUp = m_matrix(rowVal,oldDirection).connectUp;  
%      %score1 = checkPotentialRout(m_matrix,rowVal,currentUp, oldDirection);
% 
%     matrixNewNew = m_matrix;
%     matrixNewNew(rowVal,columnVal).connectDown = newDirection;
%     matrixNewNew(rowVal+1,newDirection).connectUp = columnVal;
%     score2 = 0;
%     if competeColum~=newDirection
%         score2 = checkPotentialRout(m_matrix,rowVal,oldDirection, newDirection);
%     end
%     
%     
%     competeColum = m_matrix(rowVal+1,newDirection).connectUp;
%     score3 = 0;
%     if competeColum~= newDirection
%         score3 = checkPotentialRoutCompareExisting(m_matrix,rowVal,columnVal,newDirection);
%     end
%     
%     newTotal = computeTotalScore(matrixNewNew);
%     
% 
%     if score2<0
%         score2 = 0;
%     end
%     
%     if score1<0
%     score1 = 0;
%     end
%     
%     oldTotal = computeTotalScore(m_matrixOld) +  score1;  
%     newTotal = score2 + computeTotalScore(matrixNewNew);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% %%
% %
% %     oldTotal = computeTotalScore(m_matrixOld) + score1;  
% %     maxScore = max([score2,score3]);
% %     newTotal = maxScore + computeTotalScore(matrixNewNew);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%     
%     
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% %%
% %%
% %     matrixNewNew(rowVal+1,oldDirection).connectUp =0;
% %     newTotal = score2 + score3 + computeTotalScore(matrixNewNew);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
% 
%     if oldTotal<newTotal
%         totalScoreHigher = true;
%     end
% 
%         
% end


function m_matrixNew = checkPositiveScoreFirstRow(m_matrix,rowVal,columnVal,connect,valueWithCost)
        if valueWithCost>0     
            m_matrixNew = upDateValues(m_matrix,rowVal,columnVal,connect,valueWithCost);
             m_matrix(rowVal,columnVal).buy = true;
            
        else
            m_matrix(rowVal,columnVal).connectDown = 0;
            m_matrix(rowVal+1,columnVal).connectUp = 0;
            m_matrix(rowVal,columnVal).buy = false;
            m_matrix(rowVal,columnVal).value = 0;
            m_matrixNew =m_matrix;
        end
       
end

function m_matrixNew = upDateValues(m_matrix,rowVal,columnVal,connect,value)
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
