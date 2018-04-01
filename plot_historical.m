% PLotting figure 10, panels (b) to (g)
%
% Charles ROUGE, March 2018

function plot_historical(a0,a1,a2,a3,b0,b1,b2,b3)

%% Getting annual irrigation shortage and hydropower production
[isa0,pa0] = Aux_hist_pow_irr(a0);
[isa1,pa1] = Aux_hist_pow_irr(a1);
[isa2,pa2] = Aux_hist_pow_irr(a2);
[isa3,pa3] = Aux_hist_pow_irr(a3);
[isb0,pb0] = Aux_hist_pow_irr(b0);
[isb1,pb1] = Aux_hist_pow_irr(b1);
[isb2,pb2] = Aux_hist_pow_irr(b2);
[isb3,pb3] = Aux_hist_pow_irr(b3);

%% Panel (b): annual irrigation deficits
figure
hold on
plot(1987:2011,isa0,'b','LineWidth',2)
plot(1987:2011,isb0,'k','LineWidth',2)
plot(1987:2011,isa3,'--b','LineWidth',2)
plot(1987:2011,isb3,':k','LineWidth',2)
legend('A0','B0','A3','B3')
xlabel('Year')
ylabel('Annual deficit (km^3)')
title('b) Euphrates irrigation deficit')
set(gca, 'Xlim',[1987 2011])

%% Panel (c): annual hydropower production
figure
hold on
plot(1987:2011,pa0,'b','LineWidth',2)
plot(1987:2011,pb0,'k','LineWidth',2)
plot(1987:2011,pa3,'--b','LineWidth',2)
plot(1987:2011,pb3,':k','LineWidth',2)
legend('A0','B0','A3','B3')
xlabel('Year')
ylabel('Annual production (TWh)')
title('c) Euphrates power production')
set(gca, 'Xlim',[1987 2011])

%% Getting annual historical border flows
thr = 500*86400*360/1E9; % treaty threshold
fa0=Aux_historical_border_flow(a0);
fa1=Aux_historical_border_flow(a1);
fa2=Aux_historical_border_flow(a2);
fa3=Aux_historical_border_flow(a3);
fb0=Aux_historical_border_flow(b0);
fb1=Aux_historical_border_flow(b1);
fb2=Aux_historical_border_flow(b2);
fb3=Aux_historical_border_flow(b3);

%% Putting the data for panels d-g in a table
tab = zeros(4,8);
tab(:,1) = [sum(isa0),sum(pa0),sum(max(thr-fa0,0)),sum((fa0 < thr))];
tab(:,2) = [sum(isa1),sum(pa1),sum(max(thr-fa1,0)),sum((fa1 < thr))];
tab(:,3) = [sum(isa2),sum(pa2),sum(max(thr-fa2,0)),sum((fa2 < thr))];
tab(:,4) = [sum(isa3),sum(pa3),sum(max(thr-fa3,0)),sum((fa3 < thr))];
tab(:,5) = [sum(isb0),sum(pb0),sum(max(thr-fb0,0)),sum((fb0 < thr))];
tab(:,6) = [sum(isb1),sum(pb1),sum(max(thr-fb1,0)),sum((fb1 < thr))];
tab(:,7) = [sum(isb2),sum(pb2),sum(max(thr-fb2,0)),sum((fb2 < thr))];
tab(:,8) = [sum(isb3),sum(pb3),sum(max(thr-fb3,0)),sum((fb3 < thr))];


%% Panel (d): total 25-year irrigation deficits per scenario
figure
hold on
plot(0:3,tab(1,1:4),'-bs','LineWidth',2,'MarkerFaceColor','w','MarkerSize',10)
plot(0:3,tab(1,5:8),'-ko','LineWidth',2,'MarkerFaceColor','w','MarkerSize',10)
set(gca,'XTick',0:3)
xlabel('Scenario: added irrigation (km^3)')
ylabel('25-year deficit (km^3)')
title('d) All scenarios: irrigation')
legend('A scenarios','B scenarios','Location','NorthWest')

%% Panel (e): total 25-year hydropower production per scenario
figure
hold on
plot(0:3,tab(2,1:4),'-bs','LineWidth',2,'MarkerFaceColor','w','MarkerSize',10)
plot(0:3,tab(2,5:8),'-ko','LineWidth',2,'MarkerFaceColor','w','MarkerSize',10)
set(gca,'XTick',0:3)
xlabel('Scenario: added irrigation (km^3)')
ylabel('25-year annual production (TWh)')
title('e) All scenarios: hydropower')
legend('A scenarios','B scenarios','Location','NorthEast')

%% Panel (f): total 25-year border deficit per scenario
figure
hold on
plot(0:3,tab(3,1:4),'-bs','LineWidth',2,'MarkerFaceColor','w','MarkerSize',10)
plot(0:3,tab(3,5:8),'-ko','LineWidth',2,'MarkerFaceColor','w','MarkerSize',10)
set(gca,'XTick',0:3)
xlabel('Scenario: added irrigation (km^3)')
ylabel('25-year border deficit (km^3)')
title('f) All scenarios: border deficit')
legend('A scenarios','B scenarios','Location','NorthWest')

%% Panel (g): total 25-year border reliability per scenario
figure
hold on
plot(0:3,tab(4,1:4),'-bs','LineWidth',2,'MarkerFaceColor','w','MarkerSize',10)
plot(0:3,tab(4,5:8),'-ko','LineWidth',2,'MarkerFaceColor','w','MarkerSize',10)
set(gca,'XTick',0:3)
xlabel('g) Scenario: added irrigation (km^3)')
ylabel('Number of border deficit years')
title('g) All scenarios: border reliability')
legend('A scenarios','B scenarios','Location','NorthWest')