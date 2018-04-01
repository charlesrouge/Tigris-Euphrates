% Plotting panels B to D of Figure 6
%
% Charles ROUGE, last edited March 2018

function Aux_MonthlyBorderFlows(natural,altered,quotient,over)

figure
hold on
colormap summer
[a,b,l] = plotyy(1:12,[natural',altered'],1:12,quotient,'bar','plot');
set(l,'Color','k','Marker','o','LineWidth',2,'MarkerEdgeColor','k',...
    'MarkerFaceColor','w','MarkerSize',12)
flowmax = 500*(1+floor(max(max(natural),max(altered))/500));
set(a(1),'YTick',0:500:flowmax)
linkaxes([a(1),a(2)],'x')
ylabel(a(1),'Mean flow (m^3/s)')
ylabel(a(2),'Variability quotient \chi (-)','FontSize',18,'Color','k')
legend('Natural','Altered','Location','NorthWest')
set(a(2),'Ylim',[0 flowmax/1000],'YTick',0:0.5:flowmax/1000,'FontSize',18,'ycolor','k')
set(gca,'XTick',1:12,...
    'XTickLabel',{'J' 'F' 'M' 'A' 'M' 'J' 'J' 'A' 'S' 'O' 'N' 'D'},...
    'Xlim',[0 13] )
xlabel('Month')
plot(0:13,1000*ones(1,14),'r')
if nargin == 4
    title(over)
end