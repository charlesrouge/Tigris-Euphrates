% Annual irrigation shortages and hydropower production, Euphrates wide,
% for 1987-2011, for historical scenario "hist"
%
% Charles ROUGE, March 2018

function [irr_shortage,pow] = Aux_hist_pow_irr(hist)

% Variables
irr = hist.flows.irrigation_withdrawals;
dem = hist.irrigation;
sys = hist.system;
D = dem.no_of_sites;
J = sys.no_of_nodes;

%% irrigation demands, allocation, shortage
demand = 0;
alloc =  zeros(25,1);
for d = 1:D
    demand = demand + dem.demand(d);
    for y = 1:25
        alloc(y) = alloc(y) + sum(irr(38+12*y:49+12*y,d));
    end
end
% allocation as a fraction of demand
irr_shortage = demand-alloc;
irr_shortage = irr_shortage /1000; % conversion to km3

%% Power
pow = zeros(25,1);
for j=1:J
    for y =1:25
        pow(y) = pow(y) + hist.econ.hydropower_production(y+5,j);
    end
end
pow = pow / 1000; % Conversion to TWh
