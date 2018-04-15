% 
% x = 0:0.1:2*pi;
% y = sin(x);
% lege = 'W';
% myPlot(x,y,lege);
% 
% 
% 
% 
% function myPlot(x,y,W)
%     plot(x,y);
%     %lege = strcat('$\\overline{',W,'}$$(','a',')');
%     
%     %legend({lege},'Interpreter','latex');
%     lege = strcat('$$\overline{','W','}$$');
%     h = xlabel(lege);
%     set(h,'Interpreter','latex');
% end




a = randn(1,200);
[N,edges] = histcounts(a);
histogram(a);



