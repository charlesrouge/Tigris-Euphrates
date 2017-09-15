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
% Charles Rouge, last modified August 2015

function BorderFlow(j,t,out,isrf,thr)

sys= out.system;
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
h1=cdfplot(sum(af));
h2=cdfplot(sum(nf));
set(h1,'LineWidth',2)
set(h2,'Color','r','LineWidth',2)
set(gca,'Xlim',[0 60])
if nargin == 5 % There is a threshold
    plot(thr/1E9*86400*365*ones(3,1),0:.5:1,'--k') 
    legend('Actual annual flow','Natural annual flow',...
        'Treaty','Location','SouthEast')
else 
    legend('Actual annual flow','Natural annual flow','Location', ...
        'SouthEast')
end
title('Probability distribution of the annual flow')
xlabel('Flow (km^3/yr)')
ylabel('Non-exceedance probability')

%% Results monthly flow, conversion km3 => m3/s
af = af*1E9/86400/30;
nf = nf*1E9/86400/30;

%% Plot monthly flow cdf
figure('Name',strout)
hold on
h1=cdfplot(af(:));
h2=cdfplot(nf(:));
set(h1,'LineWidth',2)
set(h2,'Color','r','LineWidth',2)
set(gca,'Xlim',[0 5000])
if nargin == 5 % There is a threshold
    plot(thr*ones(3,1),0:.5:1,'--k')
    legend('Actual monthly flow','Natural monthly flow',...
        'Treaty','Location','SouthEast')
else
    legend('Actual monthly flow','Natural monthly flow',...
        'Location','SouthEast')
end
title('Probability distribution of monthly flows')
xlabel('Average flow (m^3/s)')
ylabel('Non-exceedance probability')

%% Barplot monthly flows
figure('Name',strout)
hold on
colormap summer
bar([mean(af,2),mean(nf,2)])
set(gca,'XTick',1:12,...
    'XTickLabel',{'J' 'F' 'M' 'A' 'M' 'J' 'J' 'A' 'S' 'O' 'N' 'D'},...
    'Xlim',[0 13] )
xlabel('Month')
ylabel('Monthly average flow (m^3/s)')
if nargin == 5
    plot(0:13,ones(1,14)*thr,'--k')
    legend('Actual monthly flow','Natural monthly flow','Treaty')
else
    legend('Actual monthly flow','Natural monthly flow')
end