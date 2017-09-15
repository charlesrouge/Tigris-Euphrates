% Plots the decreasing water value as we go from upstream a river towards
% downstream, from the upstream id of interest, idup, and at year y
% Additionnal argument is vector with distances to outlet "distance".
% By default, distance is set to 1 between two consecutive nodes.
%
% WARNING: this supposes that the releases go towards the river's mouth
%
% Charles Rouge, last modified September 2017

function WaterValue(out, idup, y, distance)

% Local variables
system = out.system;
J = system.no_of_nodes;
phi = out.econ.marginal_water_value;
Id = system.id;

rel = Aux_ConvertTopo(Id, system.downstream_release_id);

%% Retrieve indexes of nodes from idup towards downstream
[m,I] = max((Id == idup));
river = [I];
lastriv = rel(I);
while lastriv > 0
    if (system.is_hydropower_reservoir(lastriv) || rel(lastriv)==0) && ...
            lastriv ~= 30 % the Mosul Regulation Dam ('Mosul Reg' node 30) is not considered in the figure
        river = [river lastriv];
    end
    lastriv = rel(lastriv);
end
%river = riv(1:end-1);
lr = length(river);

%% Get water values and associated distances
val = zeros(lr,size(phi,2)/J);
for i = 1:lr
    val(i,:) = phi(y+1,river(i):J:end);
end
if nargin == 3
    dist = (lr:-1:1);
    out = [''];
    ups = 1;
else
    dist = zeros(1,lr);
    for i = 1:lr
        [m,j_id] = max(Id(river(i)) == distance(:,1)); % retrieve right index in "distance" vector
        dist(i) = distance(j_id,2);
    end
    out = [''];
    ups = 100;
end
val = val/1000; % convert to $/1000m3

%% Construct step graph of water values
vf = zeros(2*length(mean(val,2)),2);
vf(2:2:end,1) = dist;
vf(3:2:end,1) = vf(2:2:end-2,1);
vf(1,1) = vf(2,1)+ups;
vf(1:2:end,2) = mean(val,2);
vf(2:2:end,2) = mean(val,2);

%% Plot water values

if nargin == 3
    name_string = ['Longitudinal profile without distances to outlet'];
else
    name_string = ['Longitudinal profile with approximate distances to outlet'];
end

figure('Name',name_string)
hold on
value_irrig = 50;
plot(0:floor(vf(1,1)+1), value_irrig*ones(1,floor(vf(1,1)+2)))
legend('Value of water for irrigation','Location','NorthWest')
plot(vf(:,1),vf(:,2),'k','LineWidth',2)
set(gca,'Xlim',[0 vf(1,1)])%,'Ylim',[0 1.1*max(max(val))]
ylabel('Water value ($/1,000 m^3)')
if nargin > 3
    xlabel('Distance to outlet (km)')
end

if nargin == 3

% Reduce the size of the axis so that all the labels fit in the figure.
Xt = 1:lr;
pos = get(gca,'Position');
set(gca,'Position',[pos(1), .2, pos(3) .65])
set(gca,'XTick',Xt,'XTickLabel','');
ax = axis;    % Current axis limits
axis(axis);    % Set the axis limit modes (e.g. XLimMode) to manual
Yl = ax(3:4);  % Y-axis limits
riv = river(end:-1:1);
% Place the text labels
t = text(Xt,Yl(1)*ones(1,length(Xt)),system.site_name(riv));
set(t,'HorizontalAlignment','right','VerticalAlignment','top', ...
      'Rotation',45);
end
  


    