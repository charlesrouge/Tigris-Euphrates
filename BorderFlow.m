% Computes the flow at a political border downstream of node "j", and for
% year beginning at stage "t", depending on output structure "out" and 
% whether or not there is return flow (using boolean 
% "isrf") between the node and the border. 
% Optional argument, threshold thr in m3/s.
%
% This assumes that release and spillage from node lead to same downstream
% node.
%
% Annual (a_) and monthly (m_) actual (act) and natural (nat) flow stats 
% are computed and plotted. Annual results in km^3/yr, monthly in m^3/s
%
% Charles Rouge, last modified March 2018

function BorderFlow(j,t,out,isrf,thr)

sys = out.system;
irrig = out.irrigation;
flow = out.flows;
Id = sys.id;
J = sys.no_of_nodes;
D = irrig.no_of_sites;
strout = ['Downstream of ' char( sys.site_name(j)) ', ' char(sys.country(j))];

%% Actual flow
af = flow.release(t+1:t+12,j:J:end)+flow.spillage(t+1:t+12,j:J:end);
% Add cross-border return flows if applicable
if isrf == 1
    irrin = Aux_ConvertTopo(Id, irrig.site_id);
    irrout = Aux_ConvertTopo(Id, irrig.return_flow_id); 
    rf = repmat((irrin'==j).* (irrout' ~= j).*irrig.return_flow_fraction', 12, ...
        size(flow.end_period_storage,2)/J).* flow.irrigation_withdrawals(t+1:t+12,:);
    for d = 1:D
        af = af + rf(:,d:D:end);
    end
end

%% Natural flow
nf = flow.total_natural_flow(t+1:t+12,j:J:end);

%% Results annual flow, conversion hm3 => km3
af = af/1000;
nf = nf/1000;

%% Plot annual flow cdf
figure('Name',strout)
hold on
h1=cdfplot(sum(nf));
set(h1,'Color','r','LineWidth',2)
h2=cdfplot(sum(af));
set(h2,'Color','b','LineWidth',2)
set(gca,'Xlim',[0 60])
if nargin == 5 % There is a threshold
    plot(thr/1E9*86400*365*ones(3,1),0:.5:1,'--k') 
    plot((5+thr/1E9*86400*365)*ones(3,1),0:.5:1,'k') 
    legend('Natural flow','Altered flow','Treaty minimum',...
        'Minimum + 5km^3','Location','SouthEast')
else 
    legend('Natural flow','Altered flow','Mean',...
        'Location', 'SouthEast')
end
if j == 5
    title('Euphrates, Turkey-Syria border')
else
    title('Probability distribution of the annual flow','FontSize',18)
end
xlabel('Total annual streamflow (km^3)')
ylabel('Non-exceedance probability')
end