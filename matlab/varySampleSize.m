function varySampleSize(m_matrix,maxIterate,tolerance,pBlocked, maxSampleSize,stepSampleSize,initSampleSize,NUM,sigma)
%This function varies the sample size
    discount = 1;
    %The number of experiments
    %iteNumber = floor((maxSampleSize - initSampleSize)/stepSampleSize);
    vecIteNumber = initSampleSize:stepSampleSize:maxSampleSize;
    iteNumber = size(vecIteNumber,2);
    %average score after optimization
    aveTotalScoreOpt = zeros(1,iteNumber);
    %average score before optimization
    aveTotalScoreNon = zeros(1,iteNumber);

    sampleSize = initSampleSize;

    %resultVector = zeros(iteNumber,3);
    index = 1;
    while (sampleSize<=maxSampleSize)
        totalScoreOpt = 0;
        totalScoreNon = 0;
        for i = 1:sampleSize
            
            
            %Asynchronous
            m_matrix = initMatrix(m_matrix,pBlocked);
            [m_matrix, ~, scoreBeforeOpt, scoreAfterOpt]= iterate(m_matrix,maxIterate,discount,tolerance,NUM,sigma);
            %Synchronous
            %[m_matrix, iteraN, scoreBeforeOpt, scoreAfterOpt]=  iterateSynchronous(m_matrix,maxIterate,discount);

            %Sum the total scores with optimization
            totalScoreOpt = totalScoreOpt + scoreAfterOpt;
            %Sum the total scores without optimization
            totalScoreNon = totalScoreNon + scoreBeforeOpt;        
        end

        aveTotalScoreOpt(index) = totalScoreOpt/sampleSize;
        aveTotalScoreNon(index) = totalScoreNon/sampleSize;

        sampleSize = sampleSize + stepSampleSize;
        index = index + 1;
    end
    resultVector = [vecIteNumber; aveTotalScoreOpt; aveTotalScoreNon];

    %Write the result to txt
    fileName = 'resultSampleSize';
    writeFile(resultVector, fileName);

    %close all
    figure
    plot(vecIteNumber,aveTotalScoreOpt,vecIteNumber,aveTotalScoreNon);
end