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

m_matrix(M,N)=m_cell;


%m_matrix = initMatrix(m_matrix);

maxIterate = 100;
tolerance = 0.001;
        
%The maximumn sample size
maxSampleSize = 20;
stepSampleSize = 10;
initSampleSize = 10;
pBlocked = 0.2;

%Test the sample size
varySampleSize(m_matrix, maxIterate,tolerance,pBlocked,maxSampleSize,stepSampleSize,initSampleSize);

%Test the probability of missing
sampleSize = 4;
varyP(m_matrix, maxIterate,tolerance, sampleSize);

%outPut(m_matrix,iteraN,scoreBeforeOpt);





