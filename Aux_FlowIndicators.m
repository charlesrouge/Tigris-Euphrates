% Flow downstream of node j: indicators
% Arguments node number j, time t of first month of year, structure out,
% and optional argument thr if probability of failure is computed
%
% Outputs: 
% maf (1,13), mean annual (13=end) and monthly (1:12) altered flows, m3/s
% mnf (1,13), mean annual (13=end) and monthly (1:12) natural flows, m3/s
% varquo (1,13), annual (13=end) and monthly (1:12) quotient of variability
% of flows, non-dimensional
% pfail (1,13), annual (13=end) and monthly (1:12) probability of being
% below m3/s threshold (optional)
% column 14 has the same indicators, but for all months (for varquo only)


function [maf,mnf,varquo,pfail]=Aux_FlowIndicators(j,t,out,thr)

sys = out.system;
irrig = out.irrigation;
flow = out.flows;
Id = sys.id;
J = sys.no_of_nodes;
D = irrig.no_of_sites;

%% Actual flow
af = flow.release(t+1:t+12,j:J:end)+flow.spillage(t+1:t+12,j:J:end);
% Add cross-border return flows if applicable
irrin = Aux_ConvertTopo(Id, irrig.site_id);
irrout = Aux_ConvertTopo(Id, irrig.return_flow_id); 
rf = repmat((irrin'==j).* (irrout' ~= j).*irrig.return_flow_fraction', 12, ...
    size(flow.end_period_storage,2)/J).* flow.irrigation_withdrawals(t+1:t+12,:);
for d = 1:D
    af = af + rf(:,d:D:end);
end

%% Natural flow
nf = flow.total_natural_flow(t+1:t+12,j:J:end);

%% Conversion hm3 => m3/s
af = af*1E6/86400/30;
nf = nf*1E6/86400/30;

%% Annual results
maf = zeros(1,13);
mnf = zeros(1,13);
for t = 1:12
    maf(t) = mean(af(t,:));
    mnf(t) = mean(nf(t,:));
end
maf(end) = mean(maf(1:12));
mnf(end) = mean(mnf(1:12));

%% Variability indicator
avar = zeros(1,14); % altered
nvar = zeros(1,14); % natural
for t = 1:12
    avar(t) = sum(abs(af(t,:)-maf(t)));
    nvar(t) = sum(abs(nf(t,:)-mnf(t)));
end
avar(13) = sum(abs(sum(af)-maf(end)));
nvar(13) = sum(abs(sum(nf)-mnf(end)));
avar(14) = sum(abs(af(:)-maf(end)));
nvar(14) = sum(abs(nf(:)-mnf(end)));
% Outputs
varquo = avar./max(1E-10*ones(1,14),nvar);

if nargin == 4
    pfail = zeros(2,13);
    for t = 1:12
        pfail(1,t) = sum((af(t,:)<thr));
        pfail(2,t) = sum((nf(t,:)<thr));
    end
    pfail(1,end) = sum((sum(af)<12*thr));
    pfail(2,end) = sum((sum(nf)<12*thr));
    pfail = pfail / size(af,2);
else
    pfail = nan*zeros(2,13);
end

end




















