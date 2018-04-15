%Number of row (# of components)
M=7;
%Number of column (# of Remaining Useful Year (RUL))
N=5;

%Array of Remaining Useful Year (RUL)
RULs = (1:N);

%Price of buying a new part. Array. all component is 1.1 in this example.
%price = 0.2; this is modified in the function costOpenCell() in dostep.m
%%newPrice = price*ones(1:M);

m_cell.value = 0;
m_cell.connectUp = 0;
m_cell.connectDown = 0;
m_cell.blocked = false;
m_cell.buy = false;
%m_cell.RUL = 0;
m_cell.price = 0;
m_cell.pBlocked = 0;
%Holding cost (storage cost)

m_cell.sc = 0;
m_cell.pBlocked = 0;
m_matrix(M,N)=m_cell;


%m_matrix = initMatrix(m_matrix);

maxIterate = 100;
tolerance = 0.001;
numMonteCarlo = 1;       
sigma = 0.1;


% %Test the sample size
% %The maximumn sample size
% maxSampleSize = 30;
% stepSampleSize = 2;
% initSampleSize = 1;
% pBlocked = 0.2;
% varySampleSize(m_matrix, maxIterate,tolerance,pBlocked,maxSampleSize,stepSampleSize,initSampleSize,numMonteCarlo,sigma);

% %Test the probability of missing
% sampleSize = 20;
% pVec = 0:0.05:1;
% varyP(m_matrix, maxIterate,tolerance, sampleSize,numMonteCarlo,sigma,pVec);
% 
% 
% %Test the holding cost (storage cost)
% pBlocked = 0.2;
% sampleSize = 20;
% scVec = 0:0.05:0.6;
% varySC(m_matrix, maxIterate,tolerance, sampleSize,numMonteCarlo,sigma,pBlocked,scVec);

% %Test the buying price
% pBlocked = 0.2;
% sampleSize = 20;
% vecScale = 1:1:15;
% varyBPrice(m_matrix, maxIterate,tolerance, sampleSize,numMonteCarlo,sigma,pBlocked,vecScale);

% %Test sigma
% pBlocked = 0.2;
% sampleSize = 20;
% vecSigma = 0:0.05:0.5;
% varySigma(m_matrix, maxIterate,tolerance, sampleSize,numMonteCarlo,vecSigma,pBlocked)

%Count the categories
sampleSize = 10;
pBlocked = 0.2;
[countOpt, countRand] = countScoreCategory(m_matrix, maxIterate,tolerance, sampleSize,numMonteCarlo,sigma,pBlocked);
figure
histogram(countOpt);
histogram(countRand);

resultVector = [countOpt; countRand];
writeFile(resultVector, 'histo')


