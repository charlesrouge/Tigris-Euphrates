% Getting the current year basin-wide deficit (ys) and deficit conditional
% on previous year deficit (cs)
%
% Charles ROUGE, March 2018

function [ys,cs]=Aux_irrigationdeficits(out)

flows = out.flows;
demand = out.irrigation;
D = demand.no_of_sites;
M = size(flows.irrigation_withdrawals,2)/D;

% irrigation indexes: main euphrates branch
ind = ones(D,1);

% Annual irrigation results
y = sum(flows.irrigation_withdrawals(end-11:end,:));
ys = zeros(1,M); % Annual irrigation results: yearly shortage

% Link of annual shortage with previous year shortage
cs = zeros(1,M); % conditional shortage
yc = sum(flows.irrigation_withdrawals(end-23:end-12,:));
ycs = zeros(1,M); % previous year results

% Site-by-site calculation
for i = 1:D
    if ind(i) == 1
        ys = ys + y(i:D:end);
        ycs = ycs + yc(i:D:end);
    end
end

%% Final results
% current year shortage
ys = (max(ys)-ys)/1000;
% conditional shortage
cs(1,:) = ((max(ycs)-(ycs))>0); % is there a previous year shortage