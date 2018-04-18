function plotHistogram
%This function plot the histogram for optimized score and the exhaustive
%method
    close all
    directory = pwd;
    directory = fullfile(directory,'\data\');
    nameN = 'histo.csv';
    yLabel='Frequency';
    xLabel='Score';
    nameFigOpt = 'SampleSizeOpt';
    nameFigRand = 'SampleSizeRnd';
    directoryN = strcat(directory,nameN);
    dataN = csvread(directoryN) ;
    %xValue = dataN(1,:);
    optScoreN =  dataN(1,:);
    %optScoreNRoundUp = ceil(optScoreN);
    
    randNScore =  dataN(2,:);
    
    edgeBinsOpt = 0:1:5;
    figure
    histogram(optScoreN,20);
    hold on
    histogram(optScoreN,edgeBinsOpt,'FaceColor','none','LineStyle', '--');

    setFigProperty(nameFigOpt,xLabel,yLabel);
    figure
    
    edgeBinsRnd = 0:0.125:5;
    histogram(randNScore,edgeBinsRnd);
    
    setFigProperty(nameFigRand,xLabel,yLabel);
    

end


function setFigProperty(nameFig,xLabel,yLabel )
%This function is used to adjust the figure
    axis_font_size =10;
%     legend_font_size=8;
    figure_linewidth = 1;
%     legend_linewidth=0.5;
    %mark_size=15;

    %property_legend=legend({legend1,legend2});
    % icons(1).Position = [0.1 0.1 0.01 ];
    % icons(1).Units='centimeters';
    % icons(2).XData = [0.05 0.01];
%     property_legend.FontSize=legend_font_size;
%     property_legend.FontName='times new roman';
%     property_legend.LineWidth=legend_linewidth;
%     property_legend.Units = 'centimeters';
%     % property_legend.NumColumns=1;
%     property_legend.Position=legendPosition;% Define the position and dimensions of the legend


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
%     ax.XLim = xLim;% Range
%     ax.XTick = xTick;% Tick label
    ax.XLabel.String = xLabel;
    ax.XLabel.FontSize = axis_font_size;
    %ax.XGrid='on';
    % ax.XMinorGrid='on';
    % ax.XAxis.MinorTick = 'on';
    % %ax.XAxis.MinorTickValues = 1:0.5:10;
%     ax.TickLength = [0.01 0.01];% Ticklength
%     ax.YLim = yLim;
%     ax.YTick = yTick;
    %ax.YLabel.String = yLabel;
    ax.YLabel.FontSize = axis_font_size;
%     ax.YGrid='on';% grid
%     % ax.YMinorGrid='on';%minor grid
%     ax.GridLineStyle = '-';
    % ax.MinorGridLineStyle = '--'
%     ax.GridColor=[100 100 100]/255;
%     ax.GridAlpha = 0.2;
    % ax.MinorGridColor=[100 100 100]/255;
    % ax.MinorGridAlpha = 0.2;
    %Add bar to the y label
    %lege = strcat(yLabel,'$$\overline{','W','}$$');
    h = ylabel(yLabel);
    set(h,'Interpreter','latex');
%     box on;

    print('-dtiff','-r300',nameFig);
end