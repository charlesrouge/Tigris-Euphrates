% Main function to compare type A scenarios (Figure 8)
%
% Charles ROUGE, March 2018

function plotBorderFlows2(A0,A1,A2,A3)

% parameters
t = 109;
thr = 500;
j = 5;

%% Euphrates, Turkey-Syria border
[maf,mnf,varquo,pfail]=Aux_FlowIndicators(j,t,A0,thr);
[maf1,mnf,varquo1,pfail1]=Aux_FlowIndicators(j,t,A1,thr);
[maf2,mnf,varquo2,pfail2]=Aux_FlowIndicators(j,t,A2,thr);
[maf3,mnf,varquo3,pfail3]=Aux_FlowIndicators(j,t,A3,thr);

% Annual Flows
figure
hold on
af = [maf(end),maf1(end),maf2(end),maf3(end)];
plot(0:3,af,'-bs','LineWidth',2,'MarkerFaceColor','w','MarkerSize',10)
plot(0:3,mnf(end)*ones(4,1),'--r')
set(gca,'XTick',0:3)
xlabel('Scenario: added irrigation (km^3)')
ylabel('Average border flow (m^3/s)')
legend('Altered flows', 'Natural flows','Location','NorthEast')
title('a) Annual border flow')

% 'Variability quotient \chi (-)'
figure
hold on
af = [varquo(13),varquo1(13),varquo2(13),varquo3(13)];
plot(0:3,af,'-bs','LineWidth',2,'MarkerFaceColor','w','MarkerSize',10)
plot(0:3,ones(4,1),'--r')
set(gca,'XTick',0:3)
xlabel('Scenario: added irrigation (km^3)')
ylabel('Variability quotient \chi (-)')
legend('Altered flows', 'Natural flows','Location','NorthEast')
title('b) Annual border variability')

% Annual probability of failure
figure
hold on
af = [pfail(1,end),pfail1(1,end),pfail2(1,end),pfail3(1,end)];
plot(0:3,af,'-bs','LineWidth',2,'MarkerFaceColor','w','MarkerSize',10)
plot(0:3,pfail(2,end)*ones(4,1),'--r')
set(gca,'XTick',0:3)
xlabel('Scenario: added irrigation (km^3)')
ylabel('Probability of failure')
legend('Altered flows', 'Natural flows','Location','NorthWest')
title('c) Border reliability')

% Monthly flows
figure
hold on
plot(maf(1:12),'-ko','LineWidth',1.5,'MarkerFaceColor','w','MarkerSize',8)
plot(maf1(1:12),'--b^','LineWidth',1.5,'MarkerFaceColor','w','MarkerSize',8)
plot(maf2(1:12),'-bs','LineWidth',1.5,'MarkerFaceColor','w','MarkerSize',8)
plot(maf3(1:12),'--kv','LineWidth',1.5,'MarkerFaceColor','w','MarkerSize',8)
set(gca,'XTick',1:12,...
    'XTickLabel',{'J' 'F' 'M' 'A' 'M' 'J' 'J' 'A' 'S' 'O' 'N' 'D'},...
    'Xlim',[1 12] )
xlabel('Month')
ylabel('Average border flow (m^3/s)')
legend('A0','A1','A2','A3','Location','NorthEast')
title('d) Monthly flows')

% Monthly probabilities of failure
figure
hold on
plot(pfail(1,1:12),'-ko','LineWidth',1.5,'MarkerFaceColor','w','MarkerSize',8)
plot(pfail1(1,1:12),'--b^','LineWidth',1.5,'MarkerFaceColor','w','MarkerSize',8)
plot(pfail2(1,1:12),'-bs','LineWidth',1.5,'MarkerFaceColor','w','MarkerSize',8)
plot(pfail3(1,1:12),'--kv','LineWidth',1.5,'MarkerFaceColor','w','MarkerSize',8)
set(gca,'XTick',1:12,...
    'XTickLabel',{'J' 'F' 'M' 'A' 'M' 'J' 'J' 'A' 'S' 'O' 'N' 'D'},...
    'Xlim',[1 12] )
xlabel('Month')
ylabel('Probability of failure')
legend('A0','A1','A2','A3','Location','NorthWest')
title('e) Monthly reliability')

