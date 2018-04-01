% Plots panel (a) of Figure 10.
% 
% Charles ROUGE, March 2018

function in = EuphratesInflows(euflows)

ny=29;
in = zeros(ny,1);

for y =1:ny
    in(y) = sum(sum(euflows(:,-10+12*y:1+12*y))); 
end
in = in/1000;

figure
plot(1983:2011,in,'b','LineWidth',2)
hold on
xlabel('Year')
ylabel('Total annual inflow (km^3)')
title('a) Euphrates runoff')
set(gca, 'Xlim',[1987 2011])
plot(1987:2011,30.7975*ones(25,1),'r','LineWidth',2)
legend('Annual runoff','Historical mean')

