% This computes the figure comparing outlet flows with Tharthar Lake flows,
% especially in the summer (Figure 7)
%
% Charles Rouge, last modified March 2018

function Outlet_Flow(out)

flows = out.flows;
J = out.system.no_of_nodes;

% Outlet
ofl =  flows.release(110:121,52:J:end) + flows.release(110:121,53:J:end) +...
    flows.spillage(110:121,53:J:end);
ofl = ofl*1E6/86400/30; % Convert to m3/s

% Tharthar
tfl = flows.release(110:121,41:J:end)+flows.spillage(110:121,41:J:end);
tfl = tfl*1E6/86400/30;

% Outlet vs Tharthar
ovt = ofl(7:9,:)-tfl(7:9,:);

%% Figures
figure('Name','Monthly outlet flows')
hold on
plot(1:12,mean(ofl,2),'-bs','LineWidth',2,'MarkerSize',10)
plot(1:12,mean(tfl,2),'-k^','LineWidth',2,'MarkerSize',10)
% legend('Outlet flow','Tharthar Lake outflow','Location','NorthEast')
plot(0:13,200*ones(1,14),'r')
set(gca,'XTick',1:12,...
    'XTickLabel',{'J' 'F' 'M' 'A' 'M' 'J' 'J' 'A' 'S' 'O' 'N' 'D'},...
    'Xlim',[1 12] )
xlabel('Month')
ylabel('Average flow (m^3/s)')
legend('Outlet flow','Tharthar Lake outflow','Location','NorthEast')
title('a) Monthly averages')

figure('Name','Summer outlet flows')
hold on
h1 = cdfplot(ofl(7,:));
h2 = cdfplot(ofl(8,:));
h3 = cdfplot(ofl(9,:));
h4 = cdfplot(tfl(7,:));
h5 = cdfplot(tfl(8,:));
h6 = cdfplot(tfl(9,:));
set(h1,'Color','b','LineWidth',2)
set(h2,'Color','r','LineWidth',2)
set(h3,'Color','k','LineWidth',2)
set(h4,'Color','b','LineWidth',2,'LineStyle','--')
set(h5,'Color','r','LineWidth',2,'LineStyle','--')
set(h6,'Color','k','LineWidth',2,'LineStyle','--')
xlabel('Monthly flow (m^3/s)')
ylabel('Non-exceedance probability')
legend('Outlet: Jul.','Outlet: Aug.','Outlet: Sep.',...
    'Tharthar: Jul.','Tharthar: Aug.','Tharthar: Sep.',...
    'Location','SouthEast')
title('b) Empirical CDF: summer months')
% 
figure('Name','Summer outlet flows vs. Tharthar Lake outflows')
hold on
h1 = cdfplot(ovt(1,:));
h2 = cdfplot(ovt(2,:));
h3 = cdfplot(ovt(3,:));
set(h1,'LineWidth',2)
set(h2,'Color','r','LineWidth',2)
set(h3,'Color','k','LineWidth',2)
plot(zeros(3,1),0:0.5:1,':k')
xlabel('Monthly flow (m^3/s)')
ylabel('Non-exceedance probability')
legend('Jul.','Aug.','Sep.','Location','SouthEast')
title('c) Difference outlet minus Tharthar outflows')

% figure
% hold on
% plot(ofl(7,:),tfl(7,:),'.b')
% plot(ofl(8,:),tfl(8,:),'.r')
% plot(ofl(9,:),tfl(9,:),'.k')