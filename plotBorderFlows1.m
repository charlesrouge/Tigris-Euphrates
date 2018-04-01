function plotBorderFlows1(out)

t = 109;

% Euphrates, Turkey-Syria border
[maf1,mnf1,varquo1]=Aux_FlowIndicators(5,t,out);
% Euphrates, Syria-Iraq border
[maf2,mnf2,varquo2]=Aux_FlowIndicators(16,t,out);
% Tigris, Turkey-Iraq border
[maf3,mnf3,varquo3]=Aux_FlowIndicators(9,t,out);

%% Annual flows
figure
hold on
altered = [maf1(end);maf2(end);maf3(end)];
natural = [mnf1(end);mnf2(end);mnf3(end)];
quotient = [varquo1(13),varquo2(13),varquo3(13)];
colormap summer
[a,b,l] = plotyy(1:3,[natural,altered],1:3,quotient,'bar','plot');
set(l,'Color','k','Marker','o','LineWidth',2,'MarkerEdgeColor','k',...
    'MarkerFaceColor','w','MarkerSize',12)
set(a(1),'YTick',0:200:1000)
title('a) Annual flow indicators','FontSize',24)
ylabel(a(1),'Annual average (m^3/s)')
ylabel(a(2),'Variability quotient \chi (-)','FontSize',18,'Color','k')
legend('Natural','Altered')
set(legend,'FontSize',18)
set(a(2),'Ylim',[0 1],'YTick',0:0.2:1,'FontSize',18,'ycolor','k')
set(gca,'XTick',1:3,'XTickLabel',...
    {'A: Euphrates, Turkey-Syria' 'B: Euphrates, Syria-Iraq' ...
    'C: Tigris, Turkey-Iraq'},'Ylim',[0 1000],'FontSize',18)

%% Monthly flows
% point A, Euphrates, Turkey-Syria border
Aux_MonthlyBorderFlows(mnf1(1:12),maf1(1:12),varquo1(1:12))
title('b) Monthly, Euphrates, Turkey-Syria border','FontSize',24)
set(legend,'FontSize',18)
set(gca,'FontSize',18,'Ylim',[0 3000])
%set(a(1),'Ylim',[0 3000])
% point B, Euphrates, Syria-Iraq border
Aux_MonthlyBorderFlows(mnf2(1:12),maf2(1:12),varquo2(1:12))
title('c) Monthly, Euphrates, Syria-Iraq border','FontSize',24)
set(legend,'FontSize',18)
set(gca,'FontSize',18,'Ylim',[0 3000])
% point C, Tigris, Turkey-Iraq border
Aux_MonthlyBorderFlows(mnf3(1:12),maf3(1:12),varquo3(1:12))
title('d) Monthly, Tigris, Turkey-Iraq border','FontSize',24)
set(legend,'FontSize',18)
set(gca,'FontSize',18,'Ylim',[0 1500])

