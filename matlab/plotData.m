function plotData
%This function plot the data

close all

%global variable
lineWidth = 1;
legendX = 5.9;
legendY = 6.8;
legend1 = 'CORS';
legend2 ='Exhaustive';
yLabel='Average score, ';
%     %Current directory
    directory = pwd;
    directory = fullfile(directory,'\data\');

 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Sample size
    nameN = 'resultSampleSize1-30.csv';
    nameFig = 'SampleSize';
    directoryN = strcat(directory,nameN);
    dataN = csvread(directoryN) ;
    xValue = dataN(1,:);
    optScoreN =  dataN(2,:);
    randNScore =  dataN(3,:);
    figure
    % colorOpt = [1, 0, 0];
    % colorRand = [0, 0, 1];
    plot(xValue,optScoreN,'r-o','LineWidth',lineWidth);
    hold on
    plot(xValue,randNScore,'b-o','LineWidth',lineWidth);
    %Adjust the figure
    xLabel='Sample size, \itN';
 
    xLim = [2 30];%X axis label range
    xTick = 2:2:30;%X axis step
    yLim = [8 16];
    yTick = 8:1:16;
    legendPosition = [legendX legendY 0.001 0.01];% Define the position and dimensions of the legend
    setFigProperty(nameFig,xLabel,yLabel,xLim,xTick,yLim, yTick,legend1,legend2, legendPosition);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Price of new components
    nameN = 'resultBuyingPrice.csv';
    nameFig = 'BuyingPrice';
    directoryN = strcat(directory,nameN);
    dataN = csvread(directoryN) ;
    xValue = dataN(1,:);
    optScoreN =  dataN(2,:);
    randNScore =  dataN(3,:);
    figure
    % colorOpt = [1, 0, 0];
    % colorRand = [0, 0, 1];
    plot(xValue,optScoreN,'r-o','LineWidth',lineWidth);
      hold on
      plot(xValue,randNScore,'b-o','LineWidth',lineWidth);
    %Adjust the figure
    xLabel='Scale ratio';
    xLim = [min(xValue) max(xValue)];%X axis label range
    xTick = min(xValue):1:max(xValue);%X axis step
    yLim = [0 16];
    yTick = 0:2:16;
    legendPosition = [legendX legendY 0.001 0.01];% Define the position and dimensions of the legend
    setFigProperty(nameFig,xLabel,yLabel,xLim,xTick,yLim, yTick,legend1,legend2, legendPosition);
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Missing probability
    nameN = 'resultP.csv';
    nameFig = 'missingProb';
    directoryN = strcat(directory,nameN);
    dataN = csvread(directoryN) ;
    xValue = dataN(1,:);
    optScoreN =  dataN(2,:);
    randNScore =  dataN(3,:);
    figure
    % colorOpt = [1, 0, 0];
    % colorRand = [0, 0, 1];
    plot(xValue,optScoreN,'r-o','LineWidth',lineWidth);
      hold on
      plot(xValue,randNScore,'b-o','LineWidth',lineWidth);     
    %Adjust the figure
    xLabel='Componenet missing probability, \itp';
    xLim = [min(xValue) max(xValue)];%X axis label range
    xTick = min(xValue):(xValue(3)-xValue(1)):max(xValue);%X axis step
    yLim = [5 15];
    yTick = 5:1:15;
    legendPosition = [legendX legendY 0.001 0.01];% Define the position and dimensions of the legend
    setFigProperty(nameFig,xLabel,yLabel,xLim,xTick,yLim, yTick,legend1,legend2, legendPosition);
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Holding cost
    nameN = 'resultSC.csv';
     nameFig = 'holdingCost';
    directoryN = strcat(directory,nameN);
    dataN = csvread(directoryN) ;
    xValue = dataN(1,:);
    optScoreN =  dataN(2,:);
    randNScore =  dataN(3,:);
    figure
    % colorOpt = [1, 0, 0];
    % colorRand = [0, 0, 1];
    plot(xValue,optScoreN,'r-o','LineWidth',lineWidth);
    hold on
    plot(xValue,randNScore,'b-o','LineWidth',lineWidth);
     %Adjust the figure
    xLabel='{Inventory cost, \itd}({\ith,k})';
    xLim = [min(xValue) max(xValue)];%X axis label range
    xTick = min(xValue):(xValue(3)-xValue(1)):max(xValue);%X axis step
    yLim = [9 16];
    yTick = 9:1:16;
    legendPosition = [legendX legendY 0.001 0.01];% Define the position and dimensions of the legend
    setFigProperty(nameFig,xLabel,yLabel,xLim,xTick,yLim, yTick,legend1,legend2, legendPosition);   

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% sigma
    nameN = 'resultSigma.csv';
     nameFig = 'Sigma';
    directoryN = strcat(directory,nameN);
    dataN = csvread(directoryN) ;
    xValue = dataN(1,:);
    optScoreN =  dataN(2,:);
    randNScore =  dataN(3,:);
    figure
    % colorOpt = [1, 0, 0];
    % colorRand = [0, 0, 1];
     plot(xValue,optScoreN,'r-o','LineWidth',lineWidth);
     hold on
     plot(xValue,randNScore,'b-o','LineWidth',lineWidth);
    %Adjust the figure
    xLabel='Standard deviation, \sigma';
    xLim = [min(xValue) max(xValue)];%X axis label range
    xTick = min(xValue):(xValue(4)-xValue(1)):max(xValue);%X axis step
    yLim = [8 15];
    yTick = 8:1:15;
    legendPosition = [legendX legendY 0.001 0.01];% Define the position and dimensions of the legend
    setFigProperty(nameFig,xLabel,yLabel,xLim,xTick,yLim, yTick,legend1,legend2, legendPosition);

end

function setFigProperty(nameFig,xLabel,yLabel,xLim,xTick,yLim, yTick,legend1,legend2, legendPosition )
%This function is used to adjust the figure
    axis_font_size =10;
    legend_font_size=8;
    figure_linewidth = 1;
    legend_linewidth=0.5;
    %mark_size=15;

    property_legend=legend({legend1,legend2});
    % icons(1).Position = [0.1 0.1 0.01 ];
    % icons(1).Units='centimeters';
    % icons(2).XData = [0.05 0.01];
    property_legend.FontSize=legend_font_size;
    property_legend.FontName='times new roman';
    property_legend.LineWidth=legend_linewidth;
    property_legend.Units = 'centimeters';
    % property_legend.NumColumns=1;
    property_legend.Position=legendPosition;% Define the position and dimensions of the legend


    af = gcf;%Current figure
    % af.PaperUnits='centimeters';
    % af.PaperSize=[30 30];   % width by heigth     No efffect on the output
    af.Units = 'centimeters';
    af.Position = [3 3 8 8]; %Location and size of the drawable area, specified as a vector of the form [left bottom width height]. 
    %This area excludes the figure borders, title bar, menu bar, and tool bar,[left bottom width height]
    %af.OuterPosition = [5 5 9 8];    Define the figure size which is 9*8

    ax = gca;%Current axes or chart
    ax.Units = 'centimeters';
    ax.FontSize = axis_font_size;
    ax.LineWidth = figure_linewidth ;
    ax.FontName = 'times new roman';
    ax.FontWeight = 'normal';
    ax.Position = [1.2 1.1 6.4 6.3]; % Define the distance between the axis and the figure, and the width and heigth of the axis
    ax.XLim = xLim;% Range
    ax.XTick = xTick;% Tick label
    ax.XLabel.String = xLabel;
    ax.XLabel.FontSize = axis_font_size;
    ax.XGrid='on';
    % ax.XMinorGrid='on';
    % ax.XAxis.MinorTick = 'on';
    % %ax.XAxis.MinorTickValues = 1:0.5:10;
    ax.TickLength = [0.01 0.01];% Ticklength
    ax.YLim = yLim;
    ax.YTick = yTick;
    %ax.YLabel.String = yLabel;
    ax.YLabel.FontSize = axis_font_size;
    ax.YGrid='on';% grid
    % ax.YMinorGrid='on';%minor grid
    ax.GridLineStyle = '-';
    % ax.MinorGridLineStyle = '--'
    ax.GridColor=[100 100 100]/255;
    ax.GridAlpha = 0.2;
    % ax.MinorGridColor=[100 100 100]/255;
    % ax.MinorGridAlpha = 0.2;
    %Add bar to the y label
    lege = strcat(yLabel,'$$\overline{','W','}$$');
    h = ylabel(lege);
    set(h,'Interpreter','latex');
    box on;

    print('-dtiff','-r300',nameFig);
end