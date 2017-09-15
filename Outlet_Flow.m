% This computes the figure comparing outlet flows with Tharthar Lake flows,
% especially in the summer
%
% Charles Rouge, Aug 2017

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
bar(mean(ofl,2))
plot(0:13,200*ones(1,14),'r')
set(gca,'XTick',1:12,...
    'XTickLabel',{'J' 'F' 'M' 'A' 'M' 'J' 'J' 'A' 'S' 'O' 'N' 'D'},...
    'Xlim',[0 13] )
xlabel('Month')
ylabel('Monthly average flow (m^3/s)')
title('a) Outlet flows')

figure('Name','Monthly Tharthar Lake outflows')
hold on
bar(mean(tfl,2))
plot(0:13,200*ones(1,14),'r')
set(gca,'XTick',1:12,...
    'XTickLabel',{'J' 'F' 'M' 'A' 'M' 'J' 'J' 'A' 'S' 'O' 'N' 'D'},...
    'Xlim',[0 13] )
xlabel('Month')
ylabel('Monthly average flow (m^3/s)')
title('b) Tharthar Lake')


figure('Name','Summer outlet flows')
hold on
h1 = cdfplot(ofl(7,:));
h2 = cdfplot(ofl(8,:));
h3 = cdfplot(ofl(9,:));
set(h1,'LineWidth',2)
set(h2,'Color','r','LineWidth',2)
set(h3,'Color','k','LineWidth',2)
xlabel('Average flow (m^3/s)')
ylabel('Non-exceedance probability')
legend('July','August','September')
title('c) Outlet flows')

figure('Name','Summer outlet flows vs. Tharthar Lake outflows')
hold on
h1 = cdfplot(ovt(1,:));
h2 = cdfplot(ovt(2,:));
h3 = cdfplot(ovt(3,:));
set(h1,'LineWidth',2)
set(h2,'Color','r','LineWidth',2)
set(h3,'Color','k','LineWidth',2)
xlabel('Average flow (m^3/s)')
ylabel('Non-exceedance probability')
legend('July','August','September')
title('d) Difference between outlet wlos and Tharthar outflows')