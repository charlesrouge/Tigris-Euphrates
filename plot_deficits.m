% Main functions to plot irrigation deficits in Figure 9
%
% Charles ROUGE, March 2018

function plot_deficits(b0,b1,b2,b3)

% Get the deficits 
[y1,cs]=Aux_irrigationdeficits(b0);
[y1a,csa]=Aux_irrigationdeficits(b1);
[y1b,csb]=Aux_irrigationdeficits(b2);
[y1c,csc]=Aux_irrigationdeficits(b3);

% get the probability distribusion
def1 = zeros(4,101);
defc = zeros(4,101);

for i = 0:100
    def1(1,i+1) = sum((y1 > i*0.1))/1000;
    def1(2,i+1) = sum((y1a > i*0.1))/1000;
    def1(3,i+1) = sum((y1b > i*0.1))/1000;
    def1(4,i+1) = sum((y1c > i*0.1))/1000;
    defc(1,i+1) = sum((y1 > i*0.1).*cs)/sum(cs);
    defc(2,i+1) = sum((y1a > i*0.1).*csa)/sum(csa);
    defc(3,i+1) = sum((y1b > i*0.1).*csb)/sum(csb);
    defc(4,i+1) = sum((y1c > i*0.1).*csc)/sum(csc);
end

% panel a
figure
hold on
plot(0:.1:10,def1(1,:),'k','LineWidth',2)
plot(0:.1:10,def1(2,:),':r','LineWidth',2)
plot(0:.1:10,def1(3,:),'--k','LineWidth',2)
plot(0:.1:10,def1(4,:),'r','LineWidth',2)
xlabel('Annual irrigation deficit (km^3)')
ylabel('Probability')
title('a) Euphrates deficit probabilities')
legend('B0','B1','B2','B3','Location','NorthEast')

% panel b
figure
hold on
plot(0:.1:10,defc(1,:),'k','LineWidth',2)
plot(0:.1:10,defc(2,:),':r','LineWidth',2)
plot(0:.1:10,defc(3,:),'--k','LineWidth',2)
plot(0:.1:10,defc(4,:),'r','LineWidth',2)
xlabel('Annual irrigation deficit (km^3)')
ylabel('Probability')
title('b) Conditional on previous year deficit')
legend('B0','B1','B2','B3','Location','NorthEast')
set(gca,'Ylim',[0 .8])